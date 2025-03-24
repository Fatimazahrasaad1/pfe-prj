import 'package:flutter/material.dart';
import 'package:mkadia/provider/PasswordProvider.dart';
import 'package:provider/provider.dart';

class ChangeMotDePassePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PasswordProvider(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          elevation: 0,
          title: Text(
            'Modifier le mot de passe',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Champ pour l'ancien mot de passe
                Consumer<PasswordProvider>(
                  builder: (context, passwordProvider, child) {
                    return TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Ancien mot de passe',
                        hintText: 'Entrez votre ancien mot de passe',
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: Colors.green, width: 1),
                        ),
                        prefixIcon: Icon(Icons.lock, color: Colors.green),
                      ),
                      onChanged: (value) {
                        passwordProvider.setOldPassword(value);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer votre ancien mot de passe';
                        }
                        return null;
                      },
                    );
                  },
                ),
                const SizedBox(height: 20),

                // Champ pour le nouveau mot de passe
                Consumer<PasswordProvider>(
                  builder: (context, passwordProvider, child) {
                    return TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Nouveau mot de passe',
                        hintText: 'Entrez votre nouveau mot de passe',
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: Colors.green, width: 1),
                        ),
                        prefixIcon: Icon(Icons.lock, color: Colors.green),
                      ),
                      onChanged: (value) {
                        passwordProvider.setNewPassword(value);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer un nouveau mot de passe';
                        }
                        return null;
                      },
                    );
                  },
                ),
                const SizedBox(height: 20),

                // Champ pour la confirmation du nouveau mot de passe
                Consumer<PasswordProvider>(
                  builder: (context, passwordProvider, child) {
                    return TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Confirmer le mot de passe',
                        hintText: 'Confirmez votre nouveau mot de passe',
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: Colors.green, width: 1),
                        ),
                        prefixIcon: Icon(Icons.lock, color: Colors.green),
                      ),
                      onChanged: (value) {
                        passwordProvider.setConfirmPassword(value);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez confirmer votre mot de passe';
                        }
                        if (value != passwordProvider.newPassword) {
                          return 'Les mots de passe ne correspondent pas';
                        }
                        return null;
                      },
                    );
                  },
                ),
                const SizedBox(height: 30),

                // Bouton pour sauvegarder le mot de passe
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      if (Provider.of<PasswordProvider>(context, listen: false).validatePasswords()) {
                        // Logique pour mettre à jour le mot de passe
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Mot de passe mis à jour avec succès!')),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Les mots de passe ne correspondent pas!')),
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                      child: Text(
                        'Sauvegarder',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      elevation: 8,
                      minimumSize: Size(150, 50),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}