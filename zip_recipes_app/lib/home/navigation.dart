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
  int _selectedIndex = 1;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  void _onItemTapped(int index) {
    if (_selectedIndex == index) {
      // Se já estamos no tab selecionado, garantir que voltamos à raiz da navegação
      _navigatorKeys[index].currentState?.popUntil((route) => route.isFirst);
    } else {
      // Alterar o índice e mudar para outro tab
      setState(() {
        _selectedIndex = index;
      });
    }
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

  // Helper method to get the root page for each tab.
  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return const FavoritesPage();
      case 1:
        return const HomePage();
      case 2:
        return const SettingsPage();
      default:
        return const HomePage();
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