<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use App\Models\ClientProfile;
use App\Models\DriverProfile;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Password;
use Illuminate\Auth\Events\PasswordReset;
use Illuminate\Support\Str;

class AuthController extends Controller
{
    /**
     * Gère la connexion de l'utilisateur
     */
    public function login(Request $request)
    {
        // Validation des données
        $validator = Validator::make($request->all(), [
            'email' => 'required|email',
            'password' => 'required|string|min:8',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'error' => $validator->errors()->first()
            ], 422);
        }

        // Tentative de connexion
        $credentials = $request->only('email', 'password');

        if (!auth()->attempt($credentials)) {
            return response()->json([
                'error' => 'Email ou mot de passe incorrect'
            ], 401);
        }

        // Récupération de l'utilisateur et création du token
        $user = auth()->user();
        $token = $user->createToken('authToken')->plainTextToken;

        // Récupération des données du profil selon le rôle
        $profileData = [];
        if ($user->role === 'driver') {
            $profile = DriverProfile::where('user_id', $user->id)->first();
            $profileData = [
                'phone' => $profile->phone ?? null,
                'latitude' => $profile->latitude ?? null,
                'longitude' => $profile->longitude ?? null,
            ];
        } else {
            $profile = ClientProfile::where('user_id', $user->id)->first();
            $profileData = [
                'address' => $profile->address ?? null,
                'phone' => $profile->phone ?? null,
                'avatarURL' => $profile->avatar_url ?? null,
            ];
        }

        return response()->json([
            'user' => array_merge([
                'id' => $user->id,
                'name' => $user->name,
                'email' => $user->email,
                'role' => $user->role,
            ], $profileData),
            'token' => $token
        ]);
    }

    /**
     * Gère l'inscription d'un nouvel utilisateur
     */
    public function register(Request $request)
    {
        // Validation des données
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:8|confirmed',
            'role' => 'required|string|in:client,driver',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'error' => $validator->errors()->first()
            ], 422);
        }

        // Création de l'utilisateur
        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
            'role' => $request->role,
        ]);

        // Création du profil selon le rôle
        if ($request->role === 'driver') {
            DriverProfile::create([
                'user_id' => $user->id,
                'phone' => $request->phone ?? '',
                'latitude' => 0,
                'longitude' => 0,
            ]);
        } else {
            ClientProfile::create([
                'user_id' => $user->id,
                'address' => $request->address ?? '',
                'phone' => $request->phone ?? '',
                'avatar_url' => $request->avatarURL ?? '',
            ]);
        }

        // Création du token
        $token = $user->createToken('authToken')->plainTextToken;

        return response()->json([
            'user' => [
                'id' => $user->id,
                'name' => $user->name,
                'email' => $user->email,
                'role' => $user->role,
                'address' => $request->role === 'client' ? ($request->address ?? '') : null,
                'phone' => $request->phone ?? '',
                'avatarURL' => $request->role === 'client' ? ($request->avatarURL ?? '') : null,
            ],
            'token' => $token
        ], 201);
    }

    /**
     * Gère la demande de réinitialisation de mot de passe
     */
    public function forgotPassword(Request $request)
    {
        $request->validate(['email' => 'required|email']);

        $status = Password::sendResetLink(
            $request->only('email')
        );

        return $status === Password::RESET_LINK_SENT
            ? response()->json(['message' => __($status)])
            : response()->json(['error' => __($status)], 400);
    }

    /**
     * Gère la réinitialisation du mot de passe
     */
    public function resetPassword(Request $request)
    {
        $request->validate([
            'token' => 'required',
            'email' => 'required|email',
            'password' => 'required|min:8|confirmed',
        ]);

        $status = Password::reset(
            $request->only('email', 'password', 'password_confirmation', 'token'),
            function ($user, $password) {
                $user->forceFill([
                    'password' => Hash::make($password)
                ])->setRememberToken(Str::random(60));

                $user->save();

                event(new PasswordReset($user));
            }
        );

        return $status === Password::PASSWORD_RESET
            ? response()->json(['message' => __($status)])
            : response()->json(['error' => __($status)], 400);
    }

    /**
     * Déconnexion de l'utilisateur
     */
    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();

        return response()->json(['message' => 'Déconnexion réussie']);
    }
}