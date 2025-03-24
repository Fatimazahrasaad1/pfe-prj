<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Promotion;
use Carbon\Carbon;


class PromotionsSeeder extends Seeder
{
    /**
     * Exécute le seeder.
     */
    public function run()
    {
        // Promotions de type "percentage"
        Promotion::create([
            'code' => 'SUMMER20',
            'title' => 'Réduction d\'été',
            'description' => 'Obtenez 20 % de réduction sur tous les produits',
            'type' => 'percentage',
            'value' => 20.00,
            'min_purchase_amount' => 50.00,
            'usage_limit' => 100,
            'usage_count' => 0,
            'is_active' => true,
            'start_date' => Carbon::now(), // Débute aujourd'hui
            'end_date' => Carbon::now()->addMonth(), // Expire dans 1 mois
            'image_url' => 'http://10.0.2.2:8000/img/promo35%midmouth.png',
        ]);

        Promotion::create([
            'code' => 'WELCOME10',
            'title' => 'Bienvenue',
            'description' => 'Obtenez 10 % de réduction sur votre première commande',
            'type' => 'percentage',
            'value' => 10.00,
            'min_purchase_amount' => 0.00,
            'usage_limit' => 4,
            'usage_count' => 0,
            'is_active' => true,
            'start_date' => Carbon::now(), // Débute aujourd'hui
            'end_date' => Carbon::now()->addMonths(6), // Expire dans 6 mois
            'image_url' => 'http://10.0.2.2:8000/img/promo35%midmouth.png',
        ]);

        // Promotions de type "fixed_amount"
        Promotion::create([
            'code' => 'SAVE15',
            'title' => 'Économisez 15 €',
            'description' => 'Obtenez 15 € de réduction sur votre commande',
            'type' => 'fixed_amount',
            'value' => 15.00,
            'min_purchase_amount' => 100.00,
            'usage_limit' => 6,
            'usage_count' => 0,
            'is_active' => true,
            'start_date' => Carbon::now(), // Débute aujourd'hui
            'end_date' => Carbon::now()->addWeeks(2), // Expire dans 2 semaines
            'image_url' => 'http://10.0.2.2:8000/img/promo35%midmouth.png',
        ]);

        Promotion::create([
            'code' => 'FIVEOFF',
            'title' => '5 € de réduction',
            'description' => 'Obtenez 5 € de réduction sur votre commande',
            'type' => 'fixed_amount',
            'value' => 5.00,
            'min_purchase_amount' => 20.00,
            'usage_limit' => 8, // Pas de limite
            'usage_count' => 0,
            'is_active' => true,
            'start_date' => Carbon::now(), // Débute aujourd'hui
            'end_date' => Carbon::now()->addYear(), // Expire dans 1 an
            'image_url' => 'http://10.0.2.2:8000/img/promo35%midmouth.png',
        ]);

        // Promotions de type "free_shipping"
        Promotion::create([
            'code' => 'FREESHIP',
            'title' => 'Livraison gratuite',
            'description' => 'Livraison gratuite sur toutes les commandes',
            'type' => 'free_shipping',
            'value' => 0.00,
            'min_purchase_amount' => 0.00,
            'usage_limit' => 2, // Pas de limite
            'usage_count' => 0,
            'is_active' => true,
            'start_date' => Carbon::now(), // Débute aujourd'hui
            'end_date' => Carbon::now()->addWeek(), // Expire dans 1 semaine
            'image_url' => 'http://10.0.2.2:8000/img/promo35%midmouth.png',
        ]);

        Promotion::create([
            'code' => 'SHIP50',
            'title' => 'Livraison gratuite (commandes plus de 50 €)',
            'description' => 'Livraison gratuite pour les commandes supérieures à 50 €',
            'type' => 'free_shipping',
            'value' => 0.00,
            'min_purchase_amount' => 50.00,
            'usage_limit' => 9, // Pas de limite
            'usage_count' => 0,
            'is_active' => true,
            'start_date' => Carbon::now(), // Débutfze aujourd'hui
            'end_date' => Carbon::now()->addMonth(), // Expire dans 1 mois
            'image_url' => 'http://10.0.2.2:8000/img/promo35%midmouth.png',
        ]);
    }
}
