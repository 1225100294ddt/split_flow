import 'package:flutter/material.dart';

class GroupTile extends StatelessWidget {
  final String name;
  final String members;
  final String pending;
  final VoidCallback onTap;

  const GroupTile({
    super.key,
    required this.name,
    required this.members,
    required this.pending,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFEDEBFF),
          child: const Icon(Icons.groups_outlined, color: Color(0xFF6C5CE7)),
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('$members\nPendiente: $pending'),
        isThreeLine: true,
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
