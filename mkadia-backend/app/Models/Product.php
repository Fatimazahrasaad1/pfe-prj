<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    use HasFactory;

    protected $fillable = [
        'name',
        'description',
        'price',
        'image_url',
        'weight',
        'rate',
        'category_id',
        'quantity',
    ];
    public function category()
    {
        return $this->belongsTo(Category::class, 'category_id');
    }
}