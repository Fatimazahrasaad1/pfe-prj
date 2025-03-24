<?php

// app/Models/User.php

namespace App\Models;

use Illuminate\Contracts\Auth\Authenticatable;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\DriverProfile;
use Laravel\Sanctum\HasApiTokens;

class User extends Model implements Authenticatable
{
    use \Illuminate\Auth\Authenticatable;
    use HasFactory;
    use HasApiTokens;

    protected $fillable = ['name', 'email', 'password', 'role'];

    protected $casts = [
        'email_verified_at' => 'datetime',
    ];

    public function clientProfile()
    {
        return $this->hasOne(ClientProfile::class);
    }

    // public function driverProfile()
    // {
    //     return $this->hasOne(DriverProfile::class);
    // }
}

