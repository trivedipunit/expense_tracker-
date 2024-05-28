import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key}); //constructor function
//super.key =named key argument to the parent class

  @override
  State<Expenses> createState() {
    //createstate method
    return _ExpensesState();
  }
}

//StatefulWidget is made by two class - wiget class itself, state class

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    //for expenses to be available in this file, you must add an import at the top of expense.dart
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void _openAddExpenseOverlay() {
    //this takes us to a screen when we click on '+' button
    showModalBottomSheet(
      isScrollControlled:
          true, //when it is set to be true the modal overlay will take the full available height so we don't overlap any inputs
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }
  //here context is available sice we are in a class that extends state, context contains metadata information related to widget (expense widget) and its position in the widget tree
  //ctx is now the context object for the modal element that's created by flutter

  void _addExpense(Expense expense) {
    setState(() {
      // When you call setState, Flutter schedules a rebuild of the widget, reflecting the updated state
      _registeredExpenses.add(expense);
    });
  }
 //removes the associated data after swipping from my list of expenses
  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
     //Bring back the deleted expense
     ScaffoldMessenger.of(context).clearSnackBars();
     ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense Deleted.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: (){
            setState(() { // update the UI
               _registeredExpenses.insert(expenseIndex, expense);  
            });
          },
          ),
        )
     );
  }

  @override
  Widget build(BuildContext context) { //build method
    Widget mainContent = const Center(  //if we didn't write anything that this will appear
      child: Text('No expenses found. Start adding some'),
    ); 
    if(_registeredExpenses.isNotEmpty){
      mainContent = ExpensesList(
              expenses: _registeredExpenses,
              onRemoveExpense: _removeExpense,
            );
    }
    
    return Scaffold(
      //Tool bar with the 'ADD Button +', ex- appbar
      appBar: AppBar(
        title: const Text('Flutter ExpenseTracker'),
        actions: [
          IconButton(
              onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _registeredExpenses),
          Expanded(
            child: mainContent,
          ),
        ],
      ),
    );
  }
}
