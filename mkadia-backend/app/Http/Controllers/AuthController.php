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
    /**
     * Handle user login
     */
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
        
        // Revoke all existing tokens
        $user->tokens()->delete();
        
        // Create new token with abilities based on role
        $abilities = $user->role === 'driver' ? ['driver'] : ['client'];
        $token = $user->createToken('auth-token', $abilities)->plainTextToken;

        // Get profile data based on role
        $profileData = $this->getProfileData($user);

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
     * Handle user registration
     */
    public function register(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => ['required', 'string', 'max:255'],
            'email' => ['required', 'string', 'email', 'max:255', 'unique:users'],
            'password' => ['required', 'string', 'min:8'],
            'role' => ['required', 'string', 'in:client,driver'],
            // 'phone' => ['required', 'string'],
            // 'address' => ['required_if:role,client', 'string'],
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

        Log::info(''. $request );
        // Create profile based on role
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

        // Create token with appropriate abilities
        $abilities = $request->role === 'driver' ? ['driver'] : ['client'];
        $token = $user->createToken('auth-token', $abilities)->plainTextToken;
      
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

    /**
     * Handle password reset request
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
     * Handle password reset
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
     * Handle user logout
     */
    public function logout(Request $request)
    {
        // Revoke the current token
        $request->user()->currentAccessToken()->delete();

        return response()->json(['message' => 'Successfully logged out']);
    }

    /**
     * Get profile data based on user role
     */
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