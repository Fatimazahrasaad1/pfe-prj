<?php

// app/Models/User.php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class User extends Model
{
    use HasFactory;

    protected $fillable = ['name', 'email', 'password', 'role'];

    protected $casts = [
        'email_verified_at' => 'datetime',
    ];

    public function clientProfile()
{
    return $this->hasOne(ClientProfile::class);
}

public function driverProfile()
{
    return $this->hasOne(DriverProfile::class);
}
}
