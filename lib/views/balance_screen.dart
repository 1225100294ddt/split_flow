import 'package:flutter/material.dart';
import '../widgets/recommendation_card.dart';

class BalanceScreen extends StatelessWidget {
  const BalanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('⚖️ Equilibrio')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text('Aportaciones del grupo', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          const Text('Consulta quién ha aportado más o menos según los gastos registrados.', style: TextStyle(color: Colors.black54)),
          const SizedBox(height: 20),
          const _MemberBalance(name: 'Alan', status: 'Equilibrado', detail: 'Su aportación está cerca de lo que le corresponde.', color: Color(0xFF2EAD76), icon: Icons.check_circle_outline),
          const _MemberBalance(name: 'Juan', status: 'Pagó más', detail: 'Ha adelantado dinero para el grupo.', color: Color(0xFF6C5CE7), icon: Icons.trending_up),
          const _MemberBalance(name: 'Pedro', status: 'Pagó menos', detail: 'Su aportación es menor a la parte que le corresponde.', color: Color(0xFFFFA64D), icon: Icons.trending_down),
          const _MemberBalance(name: 'Carlos', status: 'Equilibrado', detail: 'Su aportación está cerca de lo que le corresponde.', color: Color(0xFF2EAD76), icon: Icons.check_circle_outline),
          const SizedBox(height: 12),
          const RecommendationCard(text: 'Pedro podría realizar el próximo gasto del grupo para ayudar a equilibrar las aportaciones.'),
          const SizedBox(height: 12),
          const Text('Los estados son datos de ejemplo. La versión conectada calculará el equilibrio usando los gastos reales.', style: TextStyle(fontSize: 12, color: Colors.black54)),
        ],
      ),
    );
  }
}

class _MemberBalance extends StatelessWidget {
  final String name;
  final String status;
  final String detail;
  final Color color;
  final IconData icon;
  const _MemberBalance({required this.name, required this.status, required this.detail, required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: CircleAvatar(backgroundColor: color.withOpacity(0.12), child: Icon(icon, color: color)),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(detail),
        trailing: Text(status, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
