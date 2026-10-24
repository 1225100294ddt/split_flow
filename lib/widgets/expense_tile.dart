import 'package:flutter/material.dart';

class ExpenseTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String payer;
  final String amount;
  final Color color;

  const ExpenseTile({
    super.key,
    required this.icon,
    required this.title,
    required this.payer,
    required this.amount,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 9),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.12),
          child: Icon(icon, color: color, size: 20),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text('Pagó: $payer'),
        trailing: Text(amount, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
