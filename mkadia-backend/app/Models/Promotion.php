<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Promotion extends Model
{
    use HasFactory;

    protected $fillable = [
        'code',
        'title',
        'description',
        'type',
        'value',
        'min_purchase_amount',
        'usage_limit',
        'usage_count',
        'is_active',
        'start_date',
        'end_date',
        'image_url'
    ];

    protected $casts = [
        'start_date' => 'datetime',
        'end_date' => 'datetime',
        'is_active' => 'boolean',
        'value' => 'decimal:2',
        'min_purchase_amount' => 'decimal:2',
    ];

    public function isValid()
    {
        $now = now();
        return $this->is_active &&
               $now->greaterThanOrEqualTo($this->start_date) &&
               $now->lessThanOrEqualTo($this->end_date) &&
               ($this->usage_limit === 0 || $this->usage_count < $this->usage_limit);
    }
}