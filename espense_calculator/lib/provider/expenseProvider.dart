import 'package:espense_calculator/core/localStorage.dart';
import 'package:espense_calculator/model/ExpenseDataModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseProvider extends ChangeNotifier {
  List<ExpenseDataModel> expenses = [];
  // ExpenseProvider() {
  //   initialize();
  // }
  addNewExpense({String title = '', String amount = '', String category = ''}) {
    expenses.add(ExpenseDataModel(
        title: title,
        amount: amount,
        category: category,
        createdAt: DateFormat('dd/MM/yy').format(DateTime.now())));
    //LocalStorage.storeUserExpensesLocally(expenses);
    notifyListeners();
  }

  initialize() async {
    List<ExpenseDataModel> savedExpenses =
        await LocalStorage.fetchSavedUserExpense();
    expenses.addAll(savedExpenses);
    notifyListeners();
  }
}
