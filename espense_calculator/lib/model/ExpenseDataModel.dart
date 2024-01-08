import 'dart:convert';

class ExpenseDataModel {
  String title = '';
  String amount = '';
  String category = '';
  String createdAt = '';
  ExpenseDataModel({
    this.title = '',
    this.amount = '',
    this.category = '',
    this.createdAt = '',
  });
  // Asynchronous initialization method

  factory ExpenseDataModel.fromJson(Map<String, dynamic> json) {
    return ExpenseDataModel(
      title:
          json['title'].toString() == "null" || json['title'].toString().isEmpty
              ? 'No Name'
              : json['title'].toString(),
      amount:
          json['amount'].toString() == 'null' ? '' : json['amount'].toString(),
      category: json['category'].toString() == 'null'
          ? ''
          : json['category'].toString(),
      createdAt: json['created_at'] == 'null' ? '' : json['created_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'category': category,
      'created_at': createdAt,
      'amount': amount,
    };
  }

  static Map<String, dynamic> toMap(ExpenseDataModel recording) => {
        'title': recording.title,
        'category': recording.category,
        'created_at': recording.createdAt,
        'amount': recording.amount,
      };
  static String encode(List<ExpenseDataModel> expense) => json.encode(
        expense
            .map<Map<String, dynamic>>((music) => ExpenseDataModel.toMap(music))
            .toList(),
      );

  static List<ExpenseDataModel> decode(String expense) =>
      (json.decode(expense) as List<dynamic>)
          .map<ExpenseDataModel>((item) => ExpenseDataModel.fromJson(item))
          .toList();
}
