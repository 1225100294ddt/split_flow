
import 'package:flutter/material.dart';
import '../data/app_store.dart';
import '../widgets/page_title.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  String money(double amount) {
    return '\$${amount.toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    const purple = Color(0xFF6C5CE7);
    final store = AppStore.instance;

    return AnimatedBuilder(
      animation: store,
      builder: (context, _) {
        final expenses = store.expenses;
        final total = store.totalExpenses;

        final categories = <String, double>{};

        for (final expense in expenses) {
          categories.update(
            expense.description,
            (value) => value + expense.amount,
            ifAbsent: () => expense.amount,
          );
        }

        final sortedCategories = categories.entries.toList()
          ..sort((a, b) => b.value.compareTo(a.value));

        final maxCategory = sortedCategories.isEmpty
            ? 1.0
            : sortedCategories.first.value;

        final now = DateTime.now();

        final monthlyExpenses = <int, double>{};

        for (final expense in expenses) {
          if (expense.date.year == now.year) {
            monthlyExpenses.update(
              expense.date.month,
              (value) => value + expense.amount,
              ifAbsent: () => expense.amount,
            );
          }
        }

        final lastMonths = List.generate(4, (index) {
          return DateTime(now.year, now.month - 3 + index);
        });

        final maxMonth = lastMonths.fold<double>(
          0,
          (maximum, month) {
            final value = monthlyExpenses[month.month] ?? 0;
            return value > maximum ? value : maximum;
          },
        );

        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const PageTitle(
              title: 'Estadísticas',
              subtitle: 'Resumen de gastos del grupo Amigos',
            ),
            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF725BFA),
                    Color(0xFF9C27B0),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'GASTOS TOTALES',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    money(total),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${expenses.length} gastos registrados',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tendencia mensual',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      height: 120,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: lastMonths.map((month) {
                          final amount =
                              monthlyExpenses[month.month] ?? 0;

                          final barHeight = maxMonth == 0
                              ? 8.0
                              : 88.0 * amount / maxMonth;

                          const monthNames = [
                            'Ene', 'Feb', 'Mar', 'Abr',
                            'May', 'Jun', 'Jul', 'Ago',
                            'Sep', 'Oct', 'Nov', 'Dic',
                          ];

                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    height: barHeight.clamp(8.0, 88.0),
                                    decoration: BoxDecoration(
                                      color: month.month == now.month
                                          ? purple
                                          : const Color(0xFFEDEBFF),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    monthNames[month.month - 1],
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Gastos por concepto',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),

                    if (sortedCategories.isEmpty)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Center(
                          child: Text(
                            'Todavía no hay gastos registrados.',
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                      )
                    else
                      ...sortedCategories.map((category) {
                        final fraction =
                            category.value / maxCategory;

                        return _CategoryBar(
                          name: category.key,
                          amount: money(category.value),
                          fraction: fraction,
                          color: purple,
                        );
                      }),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _CategoryBar extends StatelessWidget {
  final String name;
  final String amount;
  final double fraction;
  final Color color;

  const _CategoryBar({
    required this.name,
    required this.amount,
    required this.fraction,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: Text(name)),
              Text(
                amount,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 7),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: fraction.clamp(0.0, 1.0),
              minHeight: 7,
              backgroundColor: const Color(0xFFEEEEF5),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ],
      ),
    );
  }
}
