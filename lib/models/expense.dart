import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

 final formatter = DateFormat.yMd();    //y=year,Mmonth,d=date

const uuid = Uuid();
//enum is a keyword that allows us to create a custom type; like category, which is combination of predefined allowed values
enum Category {food, travel, leisure, work} // this are not string beacause not write in quotes'', but dart is treat them sa string

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class Expense {
  Expense(                   //constructor function to build an expense object
      {required this.title,
      required this.amount, 
      required this.date,
      required this.category} 
      )                   //initializer list; in dart,"initializer list" can be used to initialize class properties(like-id) with values that are NOT received as constructor function argument  
      : id = uuid.v4(); //generate unique string id

// all this 4 property describe the single expense
  final String id;
  final String title;
  final double amount;
  final DateTime date; //DateTime a special data type that allow us to store date info. in a single value
  final Category category;

  String get formattedDate{
    return formatter.format(date);
  }
  // Getters are basically computed properties that are dynamically derived, based on other class properties
}
//building chart
//in is used to go through all the items in the list
class ExpenseBucket{
  ExpenseBucket({ required this.category,
  required this.expenses});
  //constructor function
  ExpenseBucket.forCategory(List<Expense> allExpenses,this.category):
  expenses = allExpenses.where((expense) => expense.category == category)
  .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses{
    double sum = 0;

    for(final expense in expenses){ //final = helper variable
    sum = sum+expense.amount;
    }

    return sum;

  }
}
