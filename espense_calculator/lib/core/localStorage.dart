import 'package:espense_calculator/model/ExpenseDataModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static storeUserExpensesLocally(List<ExpenseDataModel> expenses) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodedData = ExpenseDataModel.encode(expenses);

    await prefs.setString('user_expenses', encodedData);
  }

  static Future<List<ExpenseDataModel>> fetchSavedUserExpense() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? expenseString = await prefs.getString('user_expenses');

    final List<ExpenseDataModel> expenses =
        ExpenseDataModel.decode(expenseString ?? "");
    return expenses;
  }
}
