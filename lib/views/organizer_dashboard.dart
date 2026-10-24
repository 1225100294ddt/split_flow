import 'package:flutter/material.dart';
import '../data/app_store.dart';
import 'add_expense_screen.dart';
import 'welcome_screen.dart'; 

class OrganizerDashboard extends StatelessWidget {
  const OrganizerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final store = AppStore.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text('SplitFlow · Organizador'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar sesión',
            onPressed: () {
              // Navegación directa para evitar errores de rutas no registradas
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const WelcomeScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: AnimatedBuilder(
        animation: store,
        builder: (context, _) {
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const Text(
                'Panel del organizador',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text('Administra integrantes y gastos del grupo.'),
              const SizedBox(height: 20),

              Card(
                child: ListTile(
                  leading: const Icon(
                    Icons.groups,
                    color: Color(0xFF6C5CE7),
                    size: 35,
                  ),
                  title: const Text('Integrantes'),
                  subtitle: const Text('Personas registradas'),
                  trailing: Text('${store.members.length}'),
                ),
              ),

              Card(
                child: ListTile(
                  leading: const Icon(
                    Icons.account_balance_wallet,
                    color: Colors.green,
                  ),
                  title: const Text('Gastos del grupo'),
                  subtitle: const Text('Total registrado'),
                  trailing: Text(
                    '\$${store.totalExpenses.toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              const Text(
                'Herramientas del organizador',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              Card(
                child: ListTile(
                  leading: const Icon(Icons.person_add_alt_1),
                  title: const Text('Agregar integrante'),
                  subtitle: const Text('Registrar nombre y correo'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _addMember(context),
                ),
              ),

              Card(
                child: ListTile(
                  leading: const Icon(Icons.add_card),
                  title: const Text('Registrar gasto'),
                  subtitle: const Text('Agregar un movimiento al grupo'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AddExpenseScreen(),
                      ),
                    );
                  },
                ),
              ),

              Card(
                child: ListTile(
                  leading: const Icon(Icons.receipt_long),
                  title: const Text('Revisar gastos'),
                  subtitle: Text('${store.expenses.length} movimientos'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showExpenses(context, store),
                ),
              ),

              const SizedBox(height: 20),
              const Text(
                'Integrantes del grupo',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              if (store.members.isEmpty)
                const Text('Todavía no hay integrantes.')
              else
                ...store.members.map(
                  (member) => Card(
                    child: ListTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      title: Text(member.name),
                      subtitle: Text(member.email),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  void _addMember(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Agregar integrante'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                hintText: 'Escribe el nombre',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Correo electrónico',
                hintText: 'correo@ejemplo.com',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              final name = nameController.text.trim();
              final email = emailController.text.trim().toLowerCase();

              if (name.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Escribe un nombre válido.')),
                );
                return;
              }

              if (email.isEmpty || !email.contains('@')) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Escribe un correo válido.')),
                );
                return;
              }

              final store = AppStore.instance;

              if (store.members.any(
                (member) => member.email.toLowerCase() == email,
              )) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Ese correo ya está registrado.'),
                  ),
                );
                return;
              }

              Navigator.of(dialogContext).pop();

              store.addMember(
                name: name,
                email: email,
              );

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Integrante agregado correctamente.'),
                ),
              );
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    ).whenComplete(() {
      nameController.dispose();
      emailController.dispose();
    });
  }

  void _showExpenses(BuildContext context, AppStore store) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: store.expenses.isEmpty
            ? const Padding(
                padding: EdgeInsets.all(24),
                child: Text('Todavía no hay gastos registrados.'),
              )
            : ListView(
                shrinkWrap: true,
                children: store.expenses.reversed.map((expense) {
                  return ListTile(
                    title: Text(expense.description),
                    subtitle: Text('Pagó: ${expense.paidBy}'),
                    trailing: Text(
                      '\$${expense.amount.toStringAsFixed(2)}',
                    ),
                  );
                }).toList(),
              ),
      ),
    );
  }
}