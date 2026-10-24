
import 'package:flutter/material.dart';

class GroupMember {
  final String name;
  final String email;

  GroupMember({
    required this.name,
    required this.email,
  });
}

class GroupExpense {
  final String description;
  final double amount;
  final String paidBy;
  final String splitMethod;
  final DateTime date;

  GroupExpense({
    required this.description,
    required this.amount,
    required this.paidBy,
    required this.splitMethod,
    required this.date,
  });
}

class AppStore extends ChangeNotifier {
  AppStore._();

  static final AppStore instance = AppStore._();

  final List<GroupMember> members = [
    GroupMember(name: 'Alan', email: 'alan@splitflow.demo'),
    GroupMember(name: 'Juan', email: 'juan@splitflow.demo'),
    GroupMember(name: 'Daniel', email: 'daniel@splitflow.demo'),
    GroupMember(name: 'Carlos', email: 'carlos@splitflow.demo'),
  ];

  final List<GroupExpense> expenses = [];

  void addMember({
    required String name,
    required String email,
  }) {
    members.add(
      GroupMember(
        name: name.trim(),
        email: email.trim(),
      ),
    );
    notifyListeners();
  }

  void addExpense({
    required String description,
    required double amount,
    required String paidBy,
    required String splitMethod,
  }) {
    expenses.add(
      GroupExpense(
        description: description.trim(),
        amount: amount,
        paidBy: paidBy,
        splitMethod: splitMethod,
        date: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  double get totalExpenses {
    return expenses.fold(
      0.0,
      (total, expense) => total + expense.amount,
    );
  }
}
