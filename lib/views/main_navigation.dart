import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'groups_screen.dart';
import 'statistics_screen.dart';
import 'profile_screen.dart';
import '../data/demo_auth.dart';
import 'welcome_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int selectedIndex = 0;

  final pages = const [
    HomeScreen(),
    GroupsScreen(),
    StatisticsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: IndexedStack(index: selectedIndex, children: pages)),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) => setState(() => selectedIndex = index),
        indicatorColor: const Color(0xFFEDEBFF),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home, color: Color(0xFF6C5CE7)), label: 'Inicio'),
          NavigationDestination(icon: Icon(Icons.groups_outlined), selectedIcon: Icon(Icons.groups, color: Color(0xFF6C5CE7)), label: 'Grupos'),
          NavigationDestination(icon: Icon(Icons.bar_chart_outlined), selectedIcon: Icon(Icons.bar_chart, color: Color(0xFF6C5CE7)), label: 'Estadísticas'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person, color: Color(0xFF6C5CE7)), label: 'Perfil'),
        ],
      ),
      
appBar: AppBar(
  title: const Text('SplitFlow'),
  actions: [
    IconButton(
      tooltip: 'Cerrar sesión',
      icon: const Icon(Icons.logout),
      onPressed: () {
        DemoAuth.logout();

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => const WelcomeScreen(),
          ),
          (route) => false,
        );
      },
    ),
  ],
),
    );
  }
}
