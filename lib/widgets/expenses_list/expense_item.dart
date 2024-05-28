import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,// it shift the topic to the left side
          children: [
            Text(
              expense.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                    '\$${expense.amount.toStringAsFixed(2)}'), //here 2 means=12.3456=12.34 only 2 values allowed after point
                const Spacer(), //it is a widget that can be used in any row or column and it takes up all the space it can get b/t other widget b/w it is placed
                Row(
                  children: [
                    Icon(categoryIcons[expense.category]),
                    const SizedBox(width: 8),
                    Text(expense.formattedDate),
                  ],
                ),
                // \would output a single quote and \\ output the backward slash and without slas dollar is injection syntax
                // \ backward slash is not a output instead it tells dart that this dollar sign after the backward slash should be output as text
              ],
            )
          ],
        ),
      ),
    );
  }
}
