import 'package:espense_calculator/core/appColors.dart';
import 'package:espense_calculator/model/ExpenseDataModel.dart';
import 'package:flutter/material.dart';

class ExpenseListItem extends StatelessWidget {
  ExpenseListItem({super.key, required this.expenseData});
  ExpenseDataModel expenseData;
  @override
  Widget build(BuildContext context) {
    return Row(
      //crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                expenseData.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColor.black,
                  fontWeight: FontWeight.w800,
                  fontSize: 22,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              RichText(
                text: TextSpan(
                  text: "Category: ",
                  style: const TextStyle(
                      color: AppColor.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 14),
                  children: [
                    TextSpan(
                      text: expenseData.category,
                      style: const TextStyle(
                          color: AppColor.black, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Flexible(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "₹${expenseData.amount}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            RichText(
              text: TextSpan(
                text: "Date: ",
                style: const TextStyle(
                    color: AppColor.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 14),
                children: [
                  TextSpan(
                    text: expenseData.createdAt,
                    style: const TextStyle(
                        color: AppColor.black, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            )
          ],
        ))
      ],
    );
  }
}
