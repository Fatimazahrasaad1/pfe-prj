import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:8000/api'; 

  // Récupérer tous les produits
  static Future<List<dynamic>> fetchProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      final List<dynamic> products = responseBody['products'];

      // Récupérer les détails de la catégorie pour chaque produit
      for (var product in products) {
        final categoryResponse = await http.get(Uri.parse('$baseUrl/categories/${product['category_id']}'));
        if (categoryResponse.statusCode == 200) {
          final categoryData = jsonDecode(categoryResponse.body);
          product['category'] = categoryData['category']; // Ajouter les détails de la catégorie au produit
        }
      }

      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }

  // Récupérer toutes les catégories
  static Future<List<dynamic>> fetchCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/categories'));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      // Décoder la réponse JSON (qui est déjà une liste)
      final List<dynamic> categories = jsonDecode(response.body);

      // Retourner la liste des catégories
      return categories;
    } else {
      throw Exception('Failed to load categories');
    }
  }

  // Rechercher des produits
  static Future<List<Map<String, dynamic>>> searchProducts(String query) async {
    final response = await http.get(
      Uri.parse('$baseUrl/products/search?query=$query'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      
      if (data['status'] == true) { // Vérifier si l'API a trouvé des produits
        final List<dynamic> productsList = data['products'];
        
        // Correction : Utilisation de `Map<String, dynamic>.from(json)`
        return productsList.map((json) => Map<String, dynamic>.from(json)).toList();
      } else {
        return []; // Retourner une liste vide si aucun produit trouvé
      }
    } else {
      throw Exception('Failed to search products');
    }
  }

  // Récupérer un produit spécifique par son ID
  static Future<Map<String, dynamic>> fetchProductById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/products/$id'));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      // Décoder la réponse JSON
      final Map<String, dynamic> responseBody = jsonDecode(response.body);

      // Retourner les détails du produit
      return responseBody;
    } else {
      throw Exception('Failed to load product');
    }
  }

    // Récupérer toutes les promotions actives
  static Future<List<dynamic>> fetchPromotions() async {
    final response = await http.get(Uri.parse('$baseUrl/promotions'));
    
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load promotions');
    }
  }

  // Vérifier la validité d'un code promotionnel
  static Future<Map<String, dynamic>> verifyPromoCode(String code) async {
    final response = await http.post(
      Uri.parse('$baseUrl/promotions/verify'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'code': code,
      }),
    );

    return jsonDecode(response.body);
  }

  // Appliquer un code promotionnel à une commande
  static Future<Map<String, dynamic>> applyPromoCode(String code, double cartTotal) async {
    final response = await http.post(
      Uri.parse('$baseUrl/promotions/apply'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'code': code,
        'cart_total': cartTotal,
      }),
    );

    return jsonDecode(response.body);
  }
}