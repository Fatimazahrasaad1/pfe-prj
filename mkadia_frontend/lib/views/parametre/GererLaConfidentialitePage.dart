import 'package:flutter/material.dart';
import 'package:provider/provider.dart';  // Ajoutez le provider ici
import 'package:mkadia/provider/provi_confidentialité.dart';  // Assurez-vous d'importer votre provider

class GererLaConfidentialitePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PrivacySettingsProvider(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Sécurité et Confidentialité',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          backgroundColor: Colors.green,
          elevation: 0,
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Consumer<PrivacySettingsProvider>(
                  builder: (context, provider, child) {
                    return _buildSettingTile(
                      title: 'Partage de données',
                      description: 'Gérez vos préférences de partage de données.',
                      value: provider.isDataSharingEnabled,
                      onChanged: (bool value) {
                        provider.setDataSharingEnabled(value);
                      },
                    );
                  },
                ),
                Consumer<PrivacySettingsProvider>(
                  builder: (context, provider, child) {
                    return _buildSettingTile(
                      title: 'Localisation',
                      description: 'Activez ou désactivez l\'accès à votre localisation.',
                      value: provider.isLocationEnabled,
                      onChanged: (bool value) {
                        provider.setLocationEnabled(value);
                      },
                    );
                  },
                ),
                Consumer<PrivacySettingsProvider>(
                  builder: (context, provider, child) {
                    return _buildSettingTile(
                      title: 'Notifications',
                      description: 'Recevez des notifications concernant la confidentialité.',
                      value: provider.isNotificationsEnabled,
                      onChanged: (bool value) {
                        provider.setNotificationsEnabled(value);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingTile({
    required String title,
    required String description,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            SizedBox(height: 10),
            SwitchListTile(
              value: value,
              onChanged: onChanged,
              title: Text(
                value ? 'Activé' : 'Désactivé',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: value ? Colors.green : Colors.red,
                ),
              ),
              subtitle: Text(
                'Cliquez pour changer',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}