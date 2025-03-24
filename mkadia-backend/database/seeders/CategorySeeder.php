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
            ['name' => 'All', 'image_url' => 'http://10.0.2.2:8000/img/grid.png'],
            ['name' => 'Fruit', 'image_url' => 'http://10.0.2.2:8000/img/fruits.png'],
            ['name' => 'Vegetable', 'image_url' => 'http://10.0.2.2:8000/img/vegetable.png'],
            ['name' => 'Milk & Egg', 'image_url' => 'http://10.0.2.2:8000/img/milkegg.png'],
            ['name' => 'Meat', 'image_url' => 'http://10.0.2.2:8000/img/meat.png'],
        ];

        foreach ($categories as $category) {
            Category::create($category);
        }
    }
}
