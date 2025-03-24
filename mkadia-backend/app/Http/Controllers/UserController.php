<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;
use App\Models\ClientProfile;

class UserController extends Controller
{
    public function getUser(Request $request)
    {
        $user = $request->user();
        $clientProfile = ClientProfile::where('user_id', $user->id)->first();

        return response()->json([
            'name' => $user->name,
            'email' => $user->email,
            'address' => $clientProfile->address,
            'phone' => $clientProfile->phone,
            'avatarURL' => $clientProfile->avatar_url,
            'orders' => [], // Vous pouvez ajouter la logique pour récupérer les commandes ici
        ]);
    }
}