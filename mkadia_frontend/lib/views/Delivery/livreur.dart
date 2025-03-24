import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LivreurPage extends StatefulWidget {
  @override
  _LivreurPageState createState() => _LivreurPageState();
}

class _LivreurPageState extends State<LivreurPage> {
  Map<String, dynamic>? livreurData;

  @override
  void initState() {
    super.initState();
    fetchLivreurData();
  }

  Future<void> fetchLivreurData() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/livreur/1'));
    
    if (response.statusCode == 200) {
      setState(() {
        livreurData = json.decode(response.body);
      });
    } else {
      throw Exception('Échec de chargement des données du livreur');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profil du livreur')),
      body: livreurData == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(16.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Nom: ${livreurData!['name']}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Text('Email: ${livreurData!['email']}', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 8),
                      Text('Téléphone: ${livreurData!['phone']}', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 8),
                      Text('Latitude: ${livreurData!['latitude']}', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 8),
                      Text('Longitude: ${livreurData!['longitude']}', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
