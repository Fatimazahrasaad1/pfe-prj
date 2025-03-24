<?php
// database/seeders/DriverSeeder.php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\DriverProfile;
use App\Models\User;

class DriverSeeder extends Seeder
{
    public function run()
    {
        // Créer un utilisateur driver
        $user = User::create([
            'name' => 'John Driver',
            'email' => 'driver@example.com',
            'password' => bcrypt('password'),
            'role' => 'driver',
        ]);

        // Créer un profil driver
        DriverProfile::create([
            'user_id' => $user->id,
            'phone' => '987654321',
            'latitude' => 40.7128,
            'longitude' => -74.0060,
        ]);
    }
}

