import 'package:espense_calculator/core/appColors.dart';
import 'package:espense_calculator/model/ExpenseDataModel.dart';
import 'package:espense_calculator/provider/expenseProvider.dart';
import 'package:espense_calculator/views/addExpenseScreen/view/addExpenseScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../components/expenseListItem.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.theme,
        child: const Icon(
          Icons.add,
          color: AppColor.white,
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddExpenseScreen()));
        },
      ),
      appBar: AppBar(
        backgroundColor: AppColor.theme,
        centerTitle: true,
        title: const Text(
          "Home",
          style: TextStyle(
            color: AppColor.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(child: bodyView()),
    );
  }

  Widget bodyView() {
    return Consumer<ExpenseProvider>(builder: (context, provider, child) {
      print("LENGHT AT NOTIFY ${provider.expenses.length}");
      var expenses = provider.expenses;
      Map<String, double> aggregatedExpenses = {};

      expenses.forEach((expense) {
        if (aggregatedExpenses.containsKey(expense.category)) {
          aggregatedExpenses[expense.category] = double.parse(expense.amount) +
              aggregatedExpenses[expense.category]!;
        } else {
          aggregatedExpenses[expense.category] = double.parse(expense.amount);
        }
      });

      List<ExpenseDataModel> aggregatedExpenseList = aggregatedExpenses.entries
          .map((entry) => ExpenseDataModel(
                title: 'Total',
                amount: entry.value.toString(),
                category: entry.key,
              ))
          .toList();
      return SingleChildScrollView(
        child: provider.expenses.isEmpty
            ? Column(
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.4,
                  ),
                  const Center(
                    child: Text(
                      "No Expenses Yet.\n Press Button Below to add your First Expense",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              )
            : Column(
                children: [
                  // SfCircularChart(
                  //     title: ChartTitle(text: 'Sales by sales person'),
                  //     legend: Legend(isVisible: true),
                  //     series: <PieSeries<ExpenseDataModel, String>>[
                  //       PieSeries<ExpenseDataModel, String>(
                  //           explode: true,
                  //           explodeIndex: 0,
                  //           dataSource: provider.expenses,
                  //           xValueMapper: (ExpenseDataModel data, _) =>
                  //               data.title,
                  //           yValueMapper: (ExpenseDataModel data, _) =>
                  //               num.parse(data.amount),
                  //           dataLabelMapper: (ExpenseDataModel data, _) =>
                  //               data.category,
                  //           dataLabelSettings:
                  //               DataLabelSettings(isVisible: true)),
                  //     ]),
                  InkWell(
                    onTap: () {
                      print(provider.expenses.length);
                    },
                    child: SfCircularChart(
                      legend: Legend(isVisible: true),
                      series: <CircularSeries>[
                        PieSeries<ExpenseDataModel, String>(
                          dataSource:
                              aggregatedExpenseList, //provider.expenses,
                          xValueMapper: (ExpenseDataModel data, _) =>
                              data.category,
                          yValueMapper: (ExpenseDataModel data, _) =>
                              num.parse(data.amount),
                          dataLabelMapper: (ExpenseDataModel data, _) =>
                              '\$${data.amount}',
                          dataLabelSettings: DataLabelSettings(isVisible: true),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var item = provider.expenses[index];
                        return ExpenseListItem(
                          expenseData: item,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      itemCount: provider.expenses.length)
                ],
              ),
      );
    });
  }
}
