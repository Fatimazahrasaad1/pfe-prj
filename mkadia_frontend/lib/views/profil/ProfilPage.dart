import 'package:flutter/material.dart';
import 'package:mkadia/models/user.dart';
import 'package:mkadia/provider/UserProvider.dart';
import 'package:provider/provider.dart';
import 'package:mkadia/views/parametre/parametre.dart';
import 'package:mkadia/views/home/HomeView.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Utilisateur'),
        backgroundColor: Colors.green,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              _handleLogout(context, userProvider);
            },
          ),
        ],
      ),
      body: user == null
          ? const Center(child: CircularProgressIndicator())
          : _buildProfileContent(context, user),
    );
  }

  void _handleLogout(BuildContext context, UserProvider userProvider) {
    userProvider.logout();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const HomeView()),
      (route) => false,
    );
  }

  Widget _buildProfileContent(BuildContext context, User user) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildUserAvatar(user),
          const SizedBox(height: 20),
          _buildUserName(user),
          const SizedBox(height: 20),
          _buildProfileInfoCard(user),
          const SizedBox(height: 20),
          _buildOrderHistoryCard(context),
          const SizedBox(height: 20),
          _buildSettingsCard(context),
        ],
      ),
    );
  }

  Widget _buildUserAvatar(User user) {
    return Center(
      child: CircleAvatar(
        radius: 50,
        backgroundImage: _getAvatarImage(user.avatarURL),
        backgroundColor: Colors.green.shade100,
        child: (user.avatarURL == null || user.avatarURL!.isEmpty)
            ? const Icon(Icons.person, size: 50, color: Colors.white)
            : null,
      ),
    );
  }

  ImageProvider _getAvatarImage(String? avatarURL) {
    if (avatarURL == null || avatarURL.isEmpty) {
      return const AssetImage('assets/images/default_avatar.png');
    }
    return avatarURL.startsWith('assets/')
        ? AssetImage(avatarURL)
        : NetworkImage(avatarURL) as ImageProvider;
  }

  Widget _buildUserName(User user) {
    return Center(
      child: Text(
        user.name,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.green,
        ),
      ),
    );
  }

  Widget _buildProfileInfoCard(User user) {
    return _buildCard(
      title: 'Informations de Profil',
      children: [
        _buildListTile(Icons.email, 'Email', user.email),
        _buildListTile(Icons.phone, 'Téléphone', user.phone ?? 'Non renseigné'),
        _buildListTile(Icons.location_on, 'Adresse', user.address ?? 'Non renseignée'),
      ],
    );
  }

  Widget _buildOrderHistoryCard(BuildContext context) {
    return _buildCard(
      title: 'Historique des Commandes',
      children: [
        ListTile(
          leading: const Icon(Icons.history, color: Colors.green),
          title: const Text('Voir l\'historique'),
          onTap: () => Navigator.pushNamed(context, '/orderHistory'),
        ),
      ],
    );
  }

  Widget _buildSettingsCard(BuildContext context) {
    return _buildCard(
      title: 'Paramètres et Préférences',
      children: [
        ListTile(
          leading: const Icon(Icons.settings, color: Colors.green),
          title: const Text('Paramètres'),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ParametrePage()),
          ),
        ),
      ],
    );
  }

  Widget _buildCard({required String title, required List<Widget> children}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 10),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon, color: Colors.green),
      title: Text(title),
      subtitle: Text(
        subtitle,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}