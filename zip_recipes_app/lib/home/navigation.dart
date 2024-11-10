import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:zip_recipes_app/home/favorites.dart';
import 'package:zip_recipes_app/home/home.dart';
import 'package:zip_recipes_app/home/settings.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _selectedIndex = 1;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: List.generate(3, (index) {
          return Offstage(
            offstage: _selectedIndex != index,
            child: Navigator(
              key: _navigatorKeys[index],
              onGenerateRoute: (routeSettings) {
                return MaterialPageRoute(
                  builder: (context) => _getPage(index),
                );
              },
            ),
          );
        }),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color(0xFFF5F5F5),
        color: Color(0xFF86D293),
        animationDuration: Duration(milliseconds: 300),
        items: [
          Icon(Icons.favorite, color: Colors.white),
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.settings, color: Colors.white),
        ],
        index: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  // Helper method to get the root page for each tab.
  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return FavoritesPage();
      case 1:
        return HomePage();
      case 2:
        return SettingsPage();
      default:
        return HomePage();
    }
  }

  Future<bool> _onWillPop() async {
    final isFirstRouteInCurrentTab =
        !await _navigatorKeys[_selectedIndex].currentState!.maybePop();
    if (isFirstRouteInCurrentTab) {
      if (_selectedIndex != 1) {
        _onItemTapped(1); // Switch back to home tab if not on it
        return false;
      }
    }
    return isFirstRouteInCurrentTab;
  }
}