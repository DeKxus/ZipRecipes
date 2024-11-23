import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:zip_recipes_app/home/favorites.dart';
import 'package:zip_recipes_app/home/home.dart';
import 'package:zip_recipes_app/home/settings.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  //current page index
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    FavoritesPage(),
    HomePage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar:  CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: const Color(0xFF86D293),
        animationDuration: const Duration(milliseconds: 300),
        items: const [
          Icon(Icons.favorite, color: Colors.white),
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.settings, color: Colors.white),
        ],
        index: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}