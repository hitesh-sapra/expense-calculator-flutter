import 'package:espense_calculator/core/appColors.dart';
import 'package:espense_calculator/provider/expenseProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  String _selectedCategory = 'Food';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.theme,
        foregroundColor: AppColor.white,
        centerTitle: true,
        title: const Text(
          "Add New Expense",
          style: TextStyle(
            color: AppColor.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(child: formView()),
    );
  }

  Widget formView() {
    return Consumer<ExpenseProvider>(
      builder: (context, provider, child) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Expense Title',
                  labelStyle: TextStyle(color: AppColor.theme),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.theme),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.theme),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the expense title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                cursorColor: AppColor.theme,
                controller: _amountController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  labelStyle: TextStyle(color: AppColor.theme),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.theme),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.theme),
                  ),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the amount';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                focusColor: AppColor.theme,
                value: _selectedCategory,
                items: ['Food', 'Travel', 'Shopping', 'Others']
                    .map((category) => DropdownMenuItem<String>(
                          value: category,
                          child: Text(
                            category,
                            style: const TextStyle(color: AppColor.theme),
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.theme)),
                  labelText: 'Category',
                  labelStyle: TextStyle(color: AppColor.theme),
                ),
              ),
              const SizedBox(height: 60),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.theme,
                  minimumSize: Size(double.infinity, 48), // Maximum width
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(8), // Adjust the radius as needed
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    String title = _titleController.text;
                    double amount = double.parse(_amountController.text);
                    String category = _selectedCategory;

                    provider.addNewExpense(
                        title: title,
                        amount: amount.toString(),
                        category: category);
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    color: AppColor.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
