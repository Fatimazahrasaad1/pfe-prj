<?php

// database/seeders/UserSeeder.php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\User;
use App\Models\ClientProfile;
use App\Models\DriverProfile;
use Hash;

class UserSeeder extends Seeder
{
    public function run()
    {
        // Seeder pour un client
        $client = User::create([
            'name' => 'John Doe',
            'email' => 'client@example.com',
            'password' => Hash::make('password'),
            'role' => 'client',
        ]);

        ClientProfile::create([
            'user_id' => $client->id,
            'email' => $client->email,
            'phone' => '123456789',
            'address' => '123 Main St',
        ]);

        // Seeder pour un livreur
        $driver = User::create([
            'name' => 'Driver Name',
            'email' => 'driver@example.com',
            'password' => Hash::make('password'),
            'role' => 'driver',
        ]);

        DriverProfile::create([
            'user_id' => $driver->id,
            'phone' => '987654321',
            'latitude' => 40.7128,
            'longitude' => -74.0060,
        ]);
    }
}

