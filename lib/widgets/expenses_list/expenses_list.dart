import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenses,required this.onRemoveExpense});

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(ExpenseItem(expenses[index])), //keys make widgets uniquely identifiable and data attached with it by using Valuekey()
        background: Container(  //it shows a slightly variation when we remove the item
         color: Theme.of(context).colorScheme.error.withOpacity(0.7),
         margin: EdgeInsets.symmetric(horizontal: Theme.of(context).cardTheme.margin!.horizontal),
        ) ,
        onDismissed: (direction) {  //left to right or right to left
           onRemoveExpense(expenses[index]); 
        },//it removes the associated data after swipping from my list of expenses
        child: ExpenseItem(expenses[index]),
      ), //dismissal used to swipe or remove the data after save it
    );
    //we don't use column widget here beacuse the item are very more ,instead we use listview widget to scroll the items with builder,which create those list items only when they are visible or about to become visible
  }
}
