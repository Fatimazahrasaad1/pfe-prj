<?php

namespace App\Http\Controllers;

use App\Models\Driver;
use Illuminate\Http\Request;

class DriverController extends Controller {
    // Obtenir les infos d'un livreur
    public function show($id) {
        $driver = Driver::with('user')->find($id);
        if (!$driver) {
            return response()->json(['message' => 'Livreur non trouvé'], 404);
        }
        return response()->json([
            'name' => $driver->user->name,
            'email' => $driver->user->email,
            'phone' => $driver->phone,
            'latitude' => $driver->latitude,
            'longitude' => $driver->longitude
        ]);
    }

    // Mettre à jour les infos d'un livreur
    public function update(Request $request, $id) {
        $driver = Driver::find($id);
        if (!$driver) {
            return response()->json(['message' => 'Livreur non trouvé'], 404);
        }

        $driver->update($request->all());
        return response()->json(['message' => 'Informations mises à jour']);
    }
}

