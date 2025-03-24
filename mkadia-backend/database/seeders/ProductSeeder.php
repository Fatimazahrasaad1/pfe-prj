<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Category;
use App\Models\Product;

class ProductSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */

    public function run()
    {
        $products = [
            // Fruit
            [
                'name' => 'Orange',
                'description' => 'The orange is a juicy, sweet, and tangy fruit from the citrus family.',
                'price' => 1.2,
                'image_url' => 'http://10.0.2.2:8000/img/fruits.png',
                'weight' => '500 grams',
                'rate' => 3.0,
                'category_id' => 2,
                'quantity' => 1000,
            ],
            [
                'name' => 'Apple',
                'description' => 'The apple is a sweet fruit from the rose family.',
                'price' => 1.5,
                'image_url' => 'http://10.0.2.2:8000/img/fruits.png',
                'weight' => '500 grams',
                'rate' => 4.0,
                'category_id' => 2,
                'quantity' => 1000,
            ],
            [
                'name' => 'Banana',
                'description' => 'The banana is a tropical fruit known for its sweetness.',
                'price' => 1.0,
                'image_url' => 'http://10.0.2.2:8000/img/fruits.png',
                'weight' => '500 grams',
                'rate' => 5.0,
                'category_id' => 2,
                'quantity' => 1000,
            ],
            [
                'name' => 'Grapes',
                'description' => 'Grapes are small, juicy Fruit that grow in clusters.',
                'price' => 2.0,
                'image_url' => 'http://10.0.2.2:8000/img/fruits.png',
                'weight' => '500 grams',
                'rate' => 4.0,
                'category_id' => 2,
                'quantity' => 1000,
            ],
            [
                'name' => 'Pineapple',
                'description' => 'Pineapple is a tropical fruit with a sweet and tangy flavor.',
                'price' => 3.0,
                'image_url' => 'http://10.0.2.2:8000/img/fruits.png',
                'weight' => '500 grams',
                'rate' => 5.0,
                'category_id' => 2,
                'quantity' => 1000,
            ],
    
            // Vegetable
            [
                'name' => 'Carrot',
                'description' => 'Carrot is a root vegetable, usually orange in color.',
                'price' => 0.8,
                'image_url' => 'http://10.0.2.2:8000/img/vegetable.png',
                'weight' => '500 grams',
                'rate' => 4.0,
                'category_id' => 3,
                'quantity' => 1000,
            ],
            [
                'name' => 'Potato',
                'description' => 'Potato is a starchy vegetable commonly used in various dishes.',
                'price' => 1.0,
                'image_url' => 'http://10.0.2.2:8000/img/vegetable.png',
                'weight' => '500 grams',
                'rate' => 3.0,
                'category_id' => 3,
                'quantity' => 1000,
            ],
            [
                'name' => 'Tomato',
                'description' => 'Tomato is a red, juicy fruit often used as a vegetable in cooking.',
                'price' => 1.2,
                'image_url' => 'http://10.0.2.2:8000/img/vegetable.png',
                'weight' => '500 grams',
                'rate' => 5.0,
                'category_id' => 3,
                'quantity' => 1000,
            ],
            [
                'name' => 'Cucumber',
                'description' => 'Cucumber is a refreshing vegetable with a mild flavor.',
                'price' => 1.5,
                'image_url' => 'http://10.0.2.2:8000/img/vegetable.png',
                'weight' => '500 grams',
                'rate' => 4.0,
                'category_id' => 3,
                'quantity' => 1000,
            ],
            [
                'name' => 'Lettuce',
                'description' => 'Lettuce is a leafy green vegetable commonly used in salads.',
                'price' => 1.0,
                'image_url' => 'http://10.0.2.2:8000/img/vegetable.png',
                'weight' => '500 grams',
                'rate' => 4.0,
                'category_id' => 3,
                'quantity' => 1000,
            ],
    
            // Milk & Egg
            [
                'name' => 'Milk',
                'description' => 'Milk is a dairy product rich in calcium and vitamins.',
                'price' => 1.0,
                'image_url' => 'http://10.0.2.2:8000/img/milkegg.png',
                'weight' => '1 liter',
                'rate' => 4.0,
                'category_id' => 4,
                'quantity' => 1000,
            ],
            [
                'name' => 'Eggs',
                'description' => 'Eggs are a high-protein food product from hens.',
                'price' => 2.0,
                'image_url' => 'http://10.0.2.2:8000/img/milkegg.png',
                'weight' => '12 pieces',
                'rate' => 5.0,
                'category_id' => 4,
                'quantity' => 1000,
            ],
            [
                'name' => 'Butter',
                'description' => 'Butter is a dairy product made from churned cream.',
                'price' => 3.0,
                'image_url' => 'http://10.0.2.2:8000/img/milkegg.png',
                'weight' => '250 grams',
                'rate' => 5.0,
                'category_id' => 4,
                'quantity' => 1000,
            ],
            [
                'name' => 'Cheese',
                'description' => 'Cheese is a dairy product made from milk through curdling.',
                'price' => 4.0,
                'image_url' => 'http://10.0.2.2:8000/img/milkegg.png',
                'weight' => '200 grams',
                'rate' => 4.0,
                'category_id' => 4,
                'quantity' => 1000,
            ],
            [
                'name' => 'Yogurt',
                'description' => 'Yogurt is a dairy product made by fermenting milk with bacteria.',
                'price' => 1.5,
                'image_url' => 'http://10.0.2.2:8000/img/milkegg.png',
                'weight' => '500 grams',
                'rate' => 4.0,
                'category_id' => 4,
                'quantity' => 1000,
            ],
    
            // Meat
            [
                'name' => 'Chicken Breast',
                'description' => 'Chicken breast is a lean and versatile meat.',
                'price' => 5.0,
                'image_url' => 'http://10.0.2.2:8000/img/meat.png',
                'weight' => '500 grams',
                'rate' => 5.0,
                'category_id' => 5,
                'quantity' => 1000,
            ],
            [
                'name' => 'Beef Steak',
                'description' => 'Beef steak is a tender and flavorful cut of meat.',
                'price' => 7.0,
                'image_url' => 'http://10.0.2.2:8000/img/meat.png',
                'weight' => '500 grams',
                'rate' => 5.0,
                'category_id' => 5,
                'quantity' => 1000,
            ],
            [
                'name' => 'Chicken',
                'description' => 'Chicken is a versatile meat rich in protein.',
                'price' => 6.0,
                'image_url' => 'http://10.0.2.2:8000/img/meat.png',
                'weight' => '500 grams',
                'rate' => 4.0,
                'category_id' => 5,
                'quantity' => 1000,
            ],
            [
                'name' => 'Lamb Leg',
                'description' => 'Lamb leg is a tender and flavorful meat from young sheep.',
                'price' => 8.0,
                'image_url' => 'http://10.0.2.2:8000/img/meat.png',
                'weight' => '500 grams',
                'rate' => 4.0,
                'category_id' => 5,
                'quantity' => 1000,
            ],
        ];
    
        foreach ($products as $product) {
            Product::create($product);
        }
    }
}
