import 'package:flutter/material.dart';
import '../widgets/expense_tile.dart';
import '../widgets/summary_card.dart';
import 'add_expense_screen.dart';
import 'balance_screen.dart';
import 'debts_screen.dart';
import 'statistics_screen.dart';

class GroupDetailScreen extends StatelessWidget {
  final String groupName;
  const GroupDetailScreen({super.key, this.groupName = 'Amigos'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('🎉 $groupName')),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF6C5CE7),
        foregroundColor: Colors.white,
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddExpenseScreen())),
        child: const Icon(Icons.add),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 88),
        children: [
          const Text('4 integrantes', style: TextStyle(color: Colors.black54)),
          const SizedBox(height: 16),
          const Row(children: [
            Expanded(child: SummaryCard(title: 'Total gastado', amount: '\$3,500', icon: Icons.payments_outlined, color: Color(0xFF6C5CE7))),
            SizedBox(width: 12),
            Expanded(child: SummaryCard(title: 'Pendiente', amount: '\$850', icon: Icons.warning_amber_rounded, color: Color(0xFFFFA64D))),
          ]),
          const SizedBox(height: 18),
          Row(children: [
            Expanded(child: _GroupAction(label: 'Gastos', icon: Icons.receipt_long, onTap: () {})),
            const SizedBox(width: 7),
            Expanded(child: _GroupAction(label: 'Deudas', icon: Icons.account_balance_wallet_outlined, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DebtsScreen())))),
            const SizedBox(width: 7),
            Expanded(child: _GroupAction(label: 'Equilibrio', icon: Icons.balance_outlined, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BalanceScreen())))),
          ]),
          const SizedBox(height: 22),
          const Text('Gastos recientes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          const ExpenseTile(icon: Icons.restaurant, title: 'Comida', payer: 'Alan', amount: '\$500', color: Color(0xFFFFA64D)),
          const ExpenseTile(icon: Icons.directions_car, title: 'Transporte', payer: 'Juan', amount: '\$300', color: Color(0xFF6C5CE7)),
          const ExpenseTile(icon: Icons.sports_esports, title: 'Entretenimiento', payer: 'Pedro', amount: '\$200', color: Color(0xFF2EAD76)),
          const ExpenseTile(icon: Icons.hotel, title: 'Hotel', payer: 'Alan', amount: '\$800', color: Color(0xFFE85D75)),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const StatisticsScreen())),
            icon: const Icon(Icons.bar_chart),
            label: const Text('Ver estadísticas del grupo'),
          ),
        ],
      ),
    );
  }
}

class _GroupAction extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  const _GroupAction({required this.label, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonalIcon(
      onPressed: onTap,
      icon: Icon(icon, size: 16),
      label: Text(label, overflow: TextOverflow.ellipsis),
      style: FilledButton.styleFrom(
        backgroundColor: const Color(0xFFEDEBFF),
        foregroundColor: const Color(0xFF49358F),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
      ),
    );
  }
}
