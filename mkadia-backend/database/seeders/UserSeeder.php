<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\User;
use App\Models\ClientProfile;
use App\Models\DriverProfile;
use Illuminate\Support\Facades\Hash;

class UserSeeder extends Seeder
{
    public function run()
    {
        // 1. Administrateur
        User::create([
            'name' => 'Admin Mkadia',
            'email' => 'admin@mkadia.com',
            'password' => Hash::make('admin123'),
            'role' => 'admin',
        ]);

        // 2. Client
        $client = User::create([
            'name' => 'Client Test',
            'email' => 'client@mkadia.com',
            'password' => Hash::make('client123'),
            'role' => 'client',
        ]);

        ClientProfile::create([
            'user_id' => $client->id,
            'email' => $client->email, // Gardé pour client_profiles
            'phone' => '0612345678',
            'address' => '123 Avenue Hassan II, Casablanca',
            'avatar_url' => null,
        ]);

        // 3. Livreur (sans email dans driver_profiles)
        $driver = User::create([
            'name' => 'Livreur Test',
            'email' => 'livreur@mkadia.com',
            'password' => Hash::make('livreur123'),
            'role' => 'driver',
        ]);

        DriverProfile::create([
            'user_id' => $driver->id,
            'phone' => '0698765432',
            'latitude' => 33.5731,
            'longitude' => -7.5898,
        ]);
    }
}