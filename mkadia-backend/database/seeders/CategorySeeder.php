<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Category;

class CategorySeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run()
    {
        $categories = [
            ['name' => 'All', 'image_url' => 'http://127.0.0.1:8009/img/grid.png'],
            ['name' => 'Fruit', 'image_url' => 'http://127.0.0.1:8009/img/fruits.png'],
            ['name' => 'Vegetable', 'image_url' => 'http://127.0.0.1:8009/img/vegetable.png'],
            ['name' => 'Milk & Egg', 'image_url' => 'http://127.0.0.1:8009/img/milkegg.png'],
            ['name' => 'Meat', 'image_url' => 'http://127.0.0.1:8009/img/meat.png'],
        ];

        foreach ($categories as $category) {
            Category::create($category);
        }
    }
}
