import 'package:flutter/material.dart';
import '../data/app_store.dart';
import '../data/sample_data.dart';
import '../widgets/group_tile.dart';
import '../widgets/recommendation_card.dart';
import '../widgets/section_heading.dart';
import '../widgets/summary_card.dart';
import 'add_expense_screen.dart';
import 'group_detail_screen.dart';
import 'groups_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String money(double value) => '\$${value.toStringAsFixed(2)}';

  @override
  Widget build(BuildContext context) {
    final store = AppStore.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text('SplitFlow'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar sesión',
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/login',
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: AnimatedBuilder(
        animation: store,
        builder: (context, _) {
          final expenses = store.expenses.reversed.toList();

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const Text(
                '¡Hola! 👋',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Este es el resumen de tus gastos.',
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: SummaryCard(
                      title: 'Gastos registrados',
                      amount: money(store.totalExpenses),
                      icon: Icons.payments_outlined,
                      color: const Color(0xFF6C5CE7),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SummaryCard(
                      title: 'Movimientos',
                      amount: '${expenses.length}',
                      icon: Icons.receipt_long,
                      color: const Color(0xFF2EAD76),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),
              SectionHeading(
                title: 'Mis grupos',
                actionText: 'Ver todos',
                onAction: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const GroupsScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),

              ...sampleGroups.map(
                (group) => GroupTile(
                  name: group.name,
                  members: group.members,
                  pending: group.pending,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => GroupDetailScreen(
                          groupName: group.name,
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),
              const SectionHeading(title: 'Gastos recientes'),
              const SizedBox(height: 10),

              if (expenses.isEmpty)
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: Text(
                        'Todavía no hay gastos. Registra el primero.',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
              else
                ...expenses.take(5).map(
                  (expense) => Card(
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Color(0xFFEDEBFF),
                        child: Icon(
                          Icons.receipt_long,
                          color: Color(0xFF6C5CE7),
                        ),
                      ),
                      title: Text(expense.description),
                      subtitle: Text(
                        'Pagó: ${expense.paidBy} · ${expense.splitMethod}',
                      ),
                      trailing: Text(
                        money(expense.amount),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

              const SizedBox(height: 16),
              const SectionHeading(title: 'Recomendación SplitFlow'),
              const SizedBox(height: 10),
              const RecommendationCard(
                text: 'Registra los gastos del grupo para mantener '
                    'un seguimiento claro de las aportaciones.',
              ),
              const SizedBox(height: 18),

              FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF6C5CE7),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AddExpenseScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text('Agregar gasto'),
              ),
            ],
          );
        },
      ),
    );
  }
}