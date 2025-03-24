import 'package:flutter/material.dart';
import 'package:mkadia/models/order.dart';
import 'package:mkadia/provider/BottomNavProvider.dart';
import 'package:mkadia/views/Delivery/ConfirmationPage.dart';
import 'package:mkadia/views/Delivery/TrackingPage.dart';
import 'package:mkadia/views/home/HomeView.dart';
import 'package:mkadia/views/ConfirmationOrder/OrderConfirmationPage.dart';
import 'package:mkadia/views/profil/ProfilPage.dart';
import 'package:provider/provider.dart';


class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List<Widget> get views => [
        const HomeView(),
        _buildDeliveryNavigator(), 
         const ProfilPage(), 
      ];

  @override
  Widget build(BuildContext context) {
    final bottomNavProvider = Provider.of<BottomNavProvider>(context, listen: true);

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          bottomNavProvider.setCurrentIndex(index);
        },
        indicatorColor: Colors.amber,
        selectedIndex: bottomNavProvider.currentIndex, 
        destinations: const <Widget>[

          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),

          NavigationDestination(
            selectedIcon: Icon(Icons.local_shipping),
            icon: Icon(Icons.local_shipping_outlined),
            label: 'Delivery',
          ),

          NavigationDestination(
            selectedIcon: Icon(Icons.person),
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
          
        ],
      ),
      body: IndexedStack(
        index: bottomNavProvider.currentIndex, 
        children: views,
      ),
    );
  }

  Widget _buildDeliveryNavigator() {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (context) {
            switch (settings.name) {
              case '/deliveryTracking':
                return const DeliveryTrackingPage();
              case '/deliveryConfirmation':
                final order = settings.arguments as Order;
                return DeliveryConfirmationPage(order: order);
              default:
                return const OrderConfirmationPage(); 
            }
          },
        );
      },
    );
  }
}