<?php
// database/seeders/ClientProfileSeeder.php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\ClientProfile;
use App\Models\User;

class ClientProfileSeeder extends Seeder
{
    public function run()
    {
        // Créer un utilisateur client
        $user = User::create([
            'name' => 'John Client',
            'email' => 'client@example.com',
            'password' => bcrypt('password'),
            'role' => 'client',
        ]);

        // Créer un profil client
        ClientProfile::create([
            'user_id' => $user->id,
            'email' => $user->email,
            'phone' => '123456789',
            'address' => '123 Main St',
            'avatar_url' => 'https://example.com/avatar.jpg',
        ]);
    }
}

