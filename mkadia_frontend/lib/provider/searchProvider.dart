import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchProvider with ChangeNotifier {
  List<String> _searchHistory = [];
  List _searchResults = [];
  bool _isLoading = false;
  String _error = '';

  List<String> get searchHistory => _searchHistory;
  List get searchResults => _searchResults;
  bool get isLoading => _isLoading;
  String get error => _error;

  void addSearchTerm(String term) {
    if (term.isNotEmpty && !_searchHistory.contains(term)) {
      _searchHistory.insert(0, term); 
      if (_searchHistory.length > 10) {
        _searchHistory.removeLast(); 
      }
      notifyListeners();
    }
  }

  void clearSearchHistory() {
    _searchHistory.clear();
    notifyListeners();
  }

  void clearSearchResults() {
    _searchResults = [];
    notifyListeners();
  }

Future<void> searchProducts(String query) async {
  if (query.isEmpty) {
    _searchResults = [];
    notifyListeners();
    return;
  }

  _isLoading = true;
  _error = '';
  notifyListeners();

  try {
    print("Searching for: $query");

    // Appeler l'API avec le terme de recherche
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/products/search?query=$query'),
      headers: {'Content-Type': 'application/json'},
    ).timeout(const Duration(seconds: 10));

    print("Status code: ${response.statusCode}");
    print("Response: ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // Vérifier la structure de la réponse
      if (data['status'] == true && data['products'] != null) {
        _searchResults = data['products'];

        // Ajouter le terme de recherche à l'historique
        addSearchTerm(query); // <-- Ajouter cette ligne
      } else {
        _searchResults = [];
        _error = data['message'] ?? 'No products found';
      }
    } else {
      _searchResults = [];
      if (response.statusCode == 404) {
        _error = 'API endpoint not found. Please check the URL.';
      } else {
        _error = 'Error ${response.statusCode}: ${response.reasonPhrase}';
      }
    }
  } catch (e) {
    print("Exception: $e");
    _searchResults = [];
    _error = e.toString();
  } finally {
    _isLoading = false;
    notifyListeners();
  }
}
}