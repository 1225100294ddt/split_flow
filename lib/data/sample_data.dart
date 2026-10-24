import '../../../models/expense_model.dart';
import '../../../models/group_model.dart';

const sampleGroups = <GroupModel>[
  GroupModel(name: 'Amigos', members: '4 integrantes', pending: '\$850', totalSpent: '\$3,500'),
  GroupModel(name: 'Proyecto escolar', members: '5 integrantes', pending: '\$0', totalSpent: '\$1,250'),
  GroupModel(name: 'Viaje', members: '3 integrantes', pending: '\$1,200', totalSpent: '\$4,800'),
];

const sampleExpenses = <ExpenseModel>[
  ExpenseModel(title: 'Comida', payer: 'Alan', amount: 500, category: 'Comida'),
  ExpenseModel(title: 'Transporte', payer: 'Juan', amount: 300, category: 'Transporte'),
  ExpenseModel(title: 'Entretenimiento', payer: 'Pedro', amount: 200, category: 'Entretenimiento'),
  ExpenseModel(title: 'Hotel', payer: 'Alan', amount: 800, category: 'Otros'),
];
