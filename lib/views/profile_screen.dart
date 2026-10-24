import 'package:flutter/material.dart';
import '../widgets/page_title.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const PageTitle(title: 'Mi perfil', subtitle: 'Tu cuenta de SplitFlow'),
        const SizedBox(height: 24),
        const Center(
          child: CircleAvatar(
            radius: 42,
            backgroundColor: Color(0xFFE9E4FF),
            child: Icon(Icons.person, size: 48, color: Color(0xFF6C5CE7)),
          ),
        ),
        const SizedBox(height: 12),
        const Center(child: Text('Alan', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
        const Center(child: Text('alan@email.com', style: TextStyle(color: Colors.black54))),
        const SizedBox(height: 24),
        const _ProfileOption(icon: Icons.settings_outlined, title: 'Configuración'),
        const _ProfileOption(icon: Icons.notifications_none, title: 'Notificaciones'),
        const _ProfileOption(icon: Icons.help_outline, title: 'Ayuda'),
        const _ProfileOption(icon: Icons.privacy_tip_outlined, title: 'Privacidad'),
        _ProfileOption(
          icon: Icons.logout,
          title: 'Cerrar sesión',
          onTap: () => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('La autenticación todavía no está conectada.')),
          ),
        ),
        const SizedBox(height: 12),
        const Text('Prototipo académico: los datos que aparecen son de ejemplo.', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: Colors.black54)),
      ],
    );
  }
}

class _ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  const _ProfileOption({required this.icon, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF6C5CE7)),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap ?? () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$title: función pendiente.'))),
      ),
    );
  }
}
