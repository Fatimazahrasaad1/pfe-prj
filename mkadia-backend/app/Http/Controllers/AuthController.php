<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use App\Models\ClientProfile;
use App\Models\DriverProfile;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Password;
use Illuminate\Auth\Events\PasswordReset;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Str;
use Illuminate\Validation\ValidationException;

class AuthController extends Controller
{
    public function login(Request $request)
    {
        $credentials = $request->validate([
            'email' => ['required', 'email'],
            'password' => ['required'],
        ]);

        if (!Auth::attempt($credentials)) {
            throw ValidationException::withMessages([
                'email' => ['The provided credentials are incorrect.'],
            ]);
        }

        $user = Auth::user();
        $user->tokens()->delete();
        
        $abilities = match($user->role) {
            'driver' => ['driver'],
            'admin' => ['admin'],
            default => ['client']
        };
        
        $token = $user->createToken('auth-token', $abilities)->plainTextToken;

        return response()->json([
            'user' => array_merge([
                'id' => $user->id,
                'name' => $user->name,
                'email' => $user->email,
                'role' => $user->role,
            ], $this->getProfileData($user)),
            'token' => $token
        ]);
    }

    public function register(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => ['required', 'string', 'max:255'],
            'email' => ['required', 'string', 'email', 'max:255', 'unique:users'],
            'password' => ['required', 'string', 'min:8'],
            'role' => ['required', 'string', 'in:client,driver'],
            'phone' => ['required', 'string'],
            'address' => ['required_if:role,client', 'string'],
            'avatarURL' => ['nullable', 'string', 'url'],
        ]);

        if ($validator->fails()) {
            return response()->json([
                'error' => $validator->errors()->first()
            ], 422);
        }

        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
            'role' => $request->role,
        ]);

        if ($request->role === 'driver') {
            DriverProfile::create([
                'user_id' => $user->id,
                'email' => $request->email,
                'phone' => $request->phone,
                'latitude' => 0,
                'longitude' => 0,
            ]);
        } else {
            ClientProfile::create([
                'user_id' => $user->id,
                'email' => $request->email,
                'address' => $request->address,
                'phone' => $request->phone,
                'avatar_url' => $request->avatarURL,
            ]);
        }

        $token = $user->createToken('auth-token', [$request->role])->plainTextToken;
      
        return response()->json([
            'user' => array_merge([
                'id' => $user->id,
                'name' => $user->name,
                'email' => $user->email,
                'role' => $user->role,
            ], $this->getProfileData($user)),
            'token' => $token
        ], 201);
    }

    public function forgotPassword(Request $request)
    {
        $request->validate(['email' => 'required|email']);
        $status = Password::sendResetLink($request->only('email'));
        return $status === Password::RESET_LINK_SENT
            ? response()->json(['message' => __($status)])
            : response()->json(['error' => __($status)], 400);
    }

    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();
        return response()->json(['message' => 'Successfully logged out']);
    }

    private function getProfileData($user)
    {
        if ($user->role === 'driver') {
            $profile = DriverProfile::where('user_id', $user->id)->first();
            return [
                'phone' => $profile->phone ?? null,
                'latitude' => $profile->latitude ?? null,
                'longitude' => $profile->longitude ?? null,
            ];
        }

        $profile = ClientProfile::where('user_id', $user->id)->first();
        return [
            'address' => $profile->address ?? null,
            'phone' => $profile->phone ?? null,
            'avatarURL' => $profile->avatar_url ?? null,
        ];
    }
}