<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\CategoryController;
use App\Http\Controllers\OrderController;
use App\Http\Controllers\PromotionController;

use App\Http\Controllers\DriverController;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\Api\UserController;

Route::middleware('auth:sanctum')->get('/user', [UserController::class, 'getUser']);

Route::get('/livreur/{id}', [DriverController::class, 'show']);
Route::put('/livreur/{id}', [DriverController::class, 'update']);

Route::post('/login', [AuthController::class, 'login']);
Route::post('/register', [AuthController::class, 'register']);
Route::post('/forgot-password', [AuthController::class, 'forgotPassword']);
Route::post('/reset-password', [AuthController::class, 'resetPassword']);
Route::post('/logout', [AuthController::class, 'logout'])->middleware('auth:sanctum');

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

// Route protégée par Sanctum (exemple d'authentification)
Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

Route::get('/products/search', [ProductController::class, 'search']);

// Routes pour les produits 
Route::get('/products', [ProductController::class, 'index']);
Route::get('/products/{id}', [ProductController::class, 'show']);

// Routes pour les catégories
Route::get('/categories', [CategoryController::class, 'index']);

Route::get('/orders', [OrderController::class, 'index']);
Route::get('/orders/{id}', [OrderController::class, 'show']);
Route::post('/orders/{order}/update-status', [OrderController::class, 'updateStatus']);
Route::put('/orders/{id}', [OrderController::class, 'update']); 
Route::delete('/orders/{id}', [OrderController::class, 'destroy']); 

// Routes pour les promotions
Route::get('/promotions', [PromotionController::class, 'index']);
Route::post('/promotions/verify', [PromotionController::class, 'verifyCode']);
Route::post('/promotions/apply', [PromotionController::class, 'applyCode']);