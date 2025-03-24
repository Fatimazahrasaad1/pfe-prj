import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = 'http://10.0.2.2:8000';

  // Méthode pour se connecter
  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      final responseBody = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        return {
          'user': responseBody['user'],
          'token': responseBody['token'],
        };
      } else {
        throw Exception(responseBody['error'] ?? 'Échec de la connexion');
      }
    } catch (e) {
      throw Exception('Erreur de connexion: ${e.toString()}');
    }
  }

  // Méthode pour s'inscrire
  static Future<Map<String, dynamic>> register(
      String name, String email, String password, String role) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'name': name,
          'email': email,
          'password': password,
          'role': role,
        }),
      );

      final responseBody = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 201 || response.statusCode == 200) {
        return {
          'user': responseBody['user'],
          'token': responseBody['token'],
        };
      } else {
        throw Exception(responseBody['error'] ?? 'Échec de l\'inscription');
      }
    } catch (e) {
      throw Exception('Erreur d\'inscription: ${e.toString()}');
    }
  }

  // Méthode pour récupérer les informations de l'utilisateur
  static Future<Map<String, dynamic>> fetchUser(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/user'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final responseBody = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        return responseBody;
      } else {
        throw Exception(responseBody['message'] ??
            'Échec de la récupération des données utilisateur');
      }
    } catch (e) {
      throw Exception('Erreur de récupération: ${e.toString()}');
    }
  }

  // Méthode pour réinitialiser le mot de passe
  static Future<void> forgotPassword(String email) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/forgot-password'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'email': email,
        }),
      );

      if (response.statusCode != 200) {
        final responseBody = jsonDecode(utf8.decode(response.bodyBytes));
        throw Exception(responseBody['message'] ??
            'Échec de l\'envoi de l\'email de réinitialisation');
      }
    } catch (e) {
      throw Exception('Erreur: ${e.toString()}');
    }
  }
}
