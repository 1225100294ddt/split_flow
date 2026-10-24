import 'package:flutter/material.dart';
import '../data/app_store.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final amountController = TextEditingController();

  String? payer;
  String splitMethod = 'Partes iguales';

  @override
  void dispose() {
    nameController.dispose();
    amountController.dispose();
    super.dispose();
  }

  void saveExpense() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (payer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecciona quién pagó el gasto.')),
      );
      return;
    }

    final amount = double.parse(
      amountController.text.trim().replaceAll(',', '.'),
    );

    AppStore.instance.addExpense(
      description: nameController.text.trim(),
      amount: amount,
      paidBy: payer!,
      splitMethod: splitMethod,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('¡Gasto registrado correctamente!'),
      ),
    );

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    const purple = Color(0xFF6C5CE7);
    final store = AppStore.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar gasto'),
      ),
      body: AnimatedBuilder(
        animation: store,
        builder: (context, _) {
          // Obtenemos los nombres de los integrantes dinámicamente desde el store
          final peopleNames = store.members.map((m) => m.name).toList();

          // Si la lista no está vacía y el pagador actual no es válido, asignamos el primero por defecto
          if (peopleNames.isNotEmpty && (payer == null || !peopleNames.contains(payer))) {
            payer = peopleNames.first;
          }

          return Form(
            key: formKey,
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                TextFormField(
                  controller: nameController,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    labelText: 'Nombre del gasto',
                    hintText: 'Ej. Comida',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.receipt_long),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Escribe el nombre del gasto.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: amountController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Cantidad',
                    prefixText: '\$ ',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.attach_money),
                  ),
                  validator: (value) {
                    final amount = double.tryParse(
                      (value ?? '').trim().replaceAll(',', '.'),
                    );

                    if (amount == null || amount <= 0) {
                      return 'Ingresa una cantidad mayor que cero.';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Selector dinámico conectado a AppStore
                DropdownButtonFormField<String>(
                  value: peopleNames.contains(payer) ? payer : null,
                  decoration: const InputDecoration(
                    labelText: '¿Quién pagó?',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  items: peopleNames.isEmpty
                      ? []
                      : peopleNames.map((person) {
                          return DropdownMenuItem(
                            value: person,
                            child: Text(person),
                          );
                        }).toList(),
                  onChanged: peopleNames.isEmpty
                      ? null
                      : (value) {
                          if (value != null) {
                            setState(() => payer = value);
                          }
                        },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Selecciona un pagador.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                DropdownButtonFormField<String>(
                  value: splitMethod,
                  decoration: const InputDecoration(
                    labelText: 'Método de división',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.call_split),
                  ),
                  items: [
                    'Partes iguales',
                    'Por cantidad',
                    'Por porcentaje',
                  ].map((method) {
                    return DropdownMenuItem(
                      value: method,
                      child: Text(method),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => splitMethod = value);
                    }
                  },
                ),
                const SizedBox(height: 18),

                Text(
                  peopleNames.isEmpty
                      ? 'Participantes: Ninguno registrado aún'
                      : 'Participantes: ${peopleNames.join(', ')}',
                  style: const TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 24),

                FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: purple,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  onPressed: peopleNames.isEmpty ? null : saveExpense,
                  icon: const Icon(Icons.check),
                  label: const Text('Registrar gasto'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}