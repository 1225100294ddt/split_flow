import 'package:flutter/material.dart';
import 'welcome_screen.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SplitFlow · Administrador'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar sesión',
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const WelcomeScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Panel de administración',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Supervisa el funcionamiento de la aplicación.',
          ),
          const SizedBox(height: 20),

          const Row(
            children: [
              Expanded(
                child: _MetricCard(
                  title: 'Usuarios',
                  value: '1,248',
                  icon: Icons.people,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _MetricCard(
                  title: 'Grupos',
                  value: '342',
                  icon: Icons.groups,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Row(
            children: [
              Expanded(
                child: _MetricCard(
                  title: 'Gastos',
                  value: '8,762',
                  icon: Icons.receipt_long,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _MetricCard(
                  title: 'Reportes',
                  value: '5',
                  icon: Icons.flag,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),
          const Text(
            'Gestión del sistema',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),

          _adminOption(
            context,
            Icons.manage_accounts,
            'Usuarios',
            'Gestionar cuentas y permisos',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const _AdminUsersScreen(),
                ),
              );
            },
          ),
          _adminOption(
            context,
            Icons.report_problem_outlined,
            'Reportes e incidencias',
            'Revisar problemas comunicados',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const _AdminReportsScreen(),
                ),
              );
            },
          ),
          _adminOption(
            context,
            Icons.category_outlined,
            'Categorías',
            'Consultar categorías de gastos',
            onTap: () {
              _showInfoSnackBar(context, 'Categorías generales del sistema cargadas.');
            },
          ),
          _adminOption(
            context,
            Icons.settings_outlined,
            'Configuración',
            'Opciones generales de la aplicación',
            onTap: () {
              _showInfoSnackBar(context, 'Panel de configuración general.');
            },
          ),
        ],
      ),
    );
  }

  Widget _adminOption(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle, {
    required VoidCallback onTap,
  }) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF6C5CE7)),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  void _showInfoSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _MetricCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: const Color(0xFF6C5CE7)),
            const SizedBox(height: 10),
            Text(title),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Pantalla interactiva para la gestión de Usuarios
class _AdminUsersScreen extends StatelessWidget {
  const _AdminUsersScreen();

  @override
  Widget build(BuildContext context) {
    final mockUsers = [
      {'name': 'Alan Palomino', 'email': 'alan@splitflow.demo', 'role': 'Organizador'},
      {'name': 'Juan Pérez', 'email': 'juan@splitflow.demo', 'role': 'Miembro'},
      {'name': 'María López', 'email': 'maria@splitflow.demo', 'role': 'Administrador'},
      {'name': 'Carlos Ruiz', 'email': 'carlos@splitflow.demo', 'role': 'Miembro'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Gestión de Usuarios')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: mockUsers.length,
        itemBuilder: (context, index) {
          final user = mockUsers[index];
          return Card(
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person)),
              title: Text(user['name']!),
              subtitle: Text(user['email']!),
              trailing: Chip(
                label: Text(
                  user['role']!,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Pantalla interactiva para Reportes e incidencias
class _AdminReportsScreen extends StatelessWidget {
  const _AdminReportsScreen();

  @override
  Widget build(BuildContext context) {
    final mockReports = [
      {'title': 'Error al sincronizar gastos', 'status': 'Pendiente', 'date': '24 Oct 2026'},
      {'title': 'Problema con la división de pagos', 'status': 'Resuelto', 'date': '22 Oct 2026'},
      {'title': 'Solicitud de cambio de contraseña masiva', 'status': 'En revisión', 'date': '20 Oct 2026'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Reportes e Incidencias')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: mockReports.length,
        itemBuilder: (context, index) {
          final report = mockReports[index];
          return Card(
            child: ListTile(
              leading: const Icon(Icons.warning_amber_rounded, color: Colors.orange),
              title: Text(report['title']!),
              subtitle: Text('Fecha: ${report['date']}'),
              trailing: Text(
                report['status']!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: report['status'] == 'Resuelto' ? Colors.green : Colors.red,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}