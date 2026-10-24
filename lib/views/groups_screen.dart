import 'package:flutter/material.dart';
import '../data/sample_data.dart';
import '../widgets/group_tile.dart';
import '../widgets/page_title.dart';
import 'group_detail_screen.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const PageTitle(title: 'Mis grupos', subtitle: 'Tus gastos compartidos'),
        const SizedBox(height: 18),
        ...sampleGroups.map((group) => GroupTile(
          name: group.name,
          members: group.members,
          pending: group.pending,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => GroupDetailScreen(groupName: group.name))),
        )),
        const SizedBox(height: 12),
        FilledButton.icon(
          style: FilledButton.styleFrom(backgroundColor: const Color(0xFF6C5CE7), padding: const EdgeInsets.symmetric(vertical: 15)),
          onPressed: () => showDialog<void>(
            context: context,
            builder: (dialogContext) {
              final controller = TextEditingController();
              return AlertDialog(
                title: const Text('Crear grupo'),
                content: TextField(controller: controller, decoration: const InputDecoration(labelText: 'Nombre del grupo')),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Cancelar')),
                  FilledButton(
                    onPressed: () {
                      final name = controller.text.trim();
                      Navigator.pop(dialogContext);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(name.isEmpty ? 'Escribe un nombre para el grupo.' : 'Grupo "$name" (demo). Para guardarlo, conecta una base de datos.'),
                      ));
                    },
                    child: const Text('Crear'),
                  ),
                ],
              );
            },
          ),
          icon: const Icon(Icons.add),
          label: const Text('Crear grupo'),
        ),
      ],
    );
  }
}
