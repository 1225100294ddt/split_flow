import 'package:flutter/material.dart';
import '../data/demo_auth.dart'; // Ajusta la ruta según la ubicación de tu archivo demo_auth.dart
import 'main_navigation.dart';
import 'organizer_dashboard.dart';
import 'admin_dashboard.dart';

class RoleRouter extends StatelessWidget {
  const RoleRouter({super.key});

  @override
  Widget build(BuildContext context) {
    final user = DemoAuth.currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(
          child: Text('No hay una sesión iniciada.'),
        ),
      );
    }

    switch (user.role) {
      case UserRole.miembro:
        return const MainNavigation();

      case UserRole.organizador:
        return const OrganizerDashboard();

      case UserRole.admin:
        return const AdminDashboard();
    }
  }
}