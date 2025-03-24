<?php
namespace App\Http\Controllers;

use App\Models\Order;
use App\Models\OrderItem;
use Illuminate\Http\Request;

class OrderController extends Controller
{
    // Récupérer toutes les commandes
    public function index()
    {
        $orders = Order::with(['user', 'items.product'])->get(); 
        return response()->json([
            'status' => true,
            'orders' => $orders,
        ]);
    }

    // Créer une nouvelle commande
    public function store(Request $request)
    {
        // Valider les données de la commande
        $request->validate([
            'user_id' => 'required|exists:users,id',
            'items' => 'required|array', 
            'items.*.product_id' => 'required|exists:products,id',
            'items.*.quantity' => 'required|integer|min:1',
            'items.*.price' => 'required|numeric|min:0',
            'delivery_id' => 'nullable|exists:deliveries,id',
        ]);

        // Calculer le montant total de la commande
        $totalAmount = collect($request->items)->sum(function ($item) {
            return $item['price'] * $item['quantity'];
        });

        // Créer la commande
        $order = Order::create([
            'user_id' => $request->user_id,
            'total_amount' => $totalAmount,
            'order_date' => now(),
            'delivery_id' => $request->delivery_id,
            'order_status' => 'pending', 
        ]);

        // Ajouter les éléments de commande
        foreach ($request->items as $item) {
            OrderItem::create([
                'order_id' => $order->id,
                'product_id' => $item['product_id'],
                'price' => $item['price'],
                'quantity' => $item['quantity'],
                'total' => $item['price'] * $item['quantity'],
            ]);
        }

        return response()->json([
            'status' => true,
            'message' => 'Order created successfully!',
            'order' => $order->load('items.product'),
        ], 201);
    }

    // Récupérer une commande spécifique
    public function show($id)
    {
        $order = Order::with(['user', 'items.product'])->find($id); 
        if ($order) {
            return response()->json(['status' => true, 'order' => $order]);
        } else {
            return response()->json(['status' => false, 'message' => 'Order not found'], 404);
        }
    }

    // Mettre à jour le statut d'une commande
    public function updateStatus(Request $request, $id)
    {
        $request->validate([
            'order_status' => 'required|in:pending,processing,completed,canceled',
        ]);

        $order = Order::find($id);
        if ($order) {
            $order->update(['order_status' => $request->order_status]);
            return response()->json([
                'status' => true,
                'message' => 'Order status updated successfully!',
                'order' => $order,
            ]);
        } else {
            return response()->json(['status' => false, 'message' => 'Order not found'], 404);
        }
    }

    // Mettre à jour une commande (par exemple, pour modifier la livraison)
    public function update(Request $request, $id)
    {
        $request->validate([
            'delivery_id' => 'nullable|exists:deliveries,id',
        ]);

        $order = Order::find($id);
        if ($order) {
            $order->update($request->only(['delivery_id']));
            return response()->json([
                'status' => true,
                'message' => 'Order updated successfully!',
                'order' => $order,
            ]);
        } else {
            return response()->json(['status' => false, 'message' => 'Order not found'], 404);
        }
    }

    // Supprimer une commande
    public function destroy($id)
    {
        $order = Order::find($id);
        if ($order) {
            $order->delete();
            return response()->json([
                'status' => true,
                'message' => 'Order deleted successfully!',
            ]);
        } else {
            return response()->json(['status' => false, 'message' => 'Order not found'], 404);
        }
    }
}