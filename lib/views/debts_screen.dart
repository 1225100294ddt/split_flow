import 'package:flutter/material.dart';
import '../widgets/recommendation_card.dart';
import '../widgets/summary_card.dart';

class DebtsScreen extends StatelessWidget {
  const DebtsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Deudas')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SummaryCard(title: 'Deudas pendientes del grupo', amount: '\$850', icon: Icons.account_balance_wallet_outlined, color: Color(0xFFFFA64D)),
          const SizedBox(height: 20),
          const Text('Quién debe a quién', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _DebtTile(debtor: 'Pedro', creditor: 'Alan', amount: '\$125'),
          _DebtTile(debtor: 'Juan', creditor: 'Alan', amount: '\$75'),
          _DebtTile(debtor: 'Carlos', creditor: 'Juan', amount: '\$50'),
          const SizedBox(height: 12),
          const RecommendationCard(text: 'Registra una deuda como pagada cuando los integrantes confirmen la liquidación. Esta versión no realiza transferencias bancarias.'),
        ],
      ),
    );
  }
}

class _DebtTile extends StatelessWidget {
  final String debtor;
  final String creditor;
  final String amount;
  const _DebtTile({required this.debtor, required this.creditor, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFE85D75).withOpacity(0.12),
          child: const Icon(Icons.person_outline, color: Color(0xFFE85D75)),
        ),
        title: Text('$debtor → $creditor', style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: const Text('Deuda pendiente'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(amount, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFE85D75))),
            TextButton(
              onPressed: () => showDialog<void>(
                context: context,
                builder: (dialogContext) => AlertDialog(
                  title: const Text('Registrar liquidación'),
                  content: Text('¿Marcar la deuda de $debtor a $creditor por $amount como pagada? Es una demostración y no mueve dinero.'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Cancelar')),
                    FilledButton(
                      onPressed: () {
                        Navigator.pop(dialogContext);
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Demo: aquí se actualizaría la deuda.')));
                      },
                      child: const Text('Confirmar'),
                    ),
                  ],
                ),
              ),
              child: const Text('Liquidar'),
            ),
          ],
        ),
      ),
    );
  }
}
