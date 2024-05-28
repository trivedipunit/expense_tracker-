import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense(
      {super.key, required this.onAddExpense}); //constructor function

  final void Function(Expense expense)
      onAddExpense; //at the end when we saving new expense

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  //2nd method to stre data
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    //async is used to store the value
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context, //await is used because it yield as a future
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    // this line's only executed when the value is available , lines after pickedDate
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  //checks the validity of data
  void _submitExpenseData() {
    //tryparse('Hello') => null, tryparse('1.12') => 1.12
    final enteredAmount = double.tryParse(_amountController
        .text); //double.tryParse takes string as input and returns double(number) as output and if doesn't convert in double then returns NULL
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text
            .trim()
            .isEmpty || //trim = remove white space at beginning and ending
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          //showDialog show some info or error dialogue on the screen
          title: const Text('Invalid Input'),
          content: const Text(
              'Please make sure a valid title, amount, date and category was entered.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    } //u can get access to properties of widget class that belongs to state class by using special "widget" property provided by flutter
    widget.onAddExpense(
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!, // ! it shows that it can't be null
        category: _selectedCategory,
      ),
    );
    Navigator.pop(context);//it close the overlay automatically when we entered valid data
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  /*'dispose' like'initstate' & 'build' is part of statefulwidget lifecycle, it's called automatically by flutter
   when the widget & it's state are about to destroyed(removed from ui), only 'state' class implement dispose method not 
   statelessWidget, so you must use statefulwidget*/

  /* one way to store
 var _enteredTitle='';

  void _saveTitleInput(String inputValue) {
    _enteredTitle = inputValue;
  }*/
  @override
  Widget build(BuildContext context) {
    return Padding(
      // to add new expense
      padding: const EdgeInsets.fromLTRB(16,48,16,16),//due to isscrolled some title is obscured with the camera so we change from all to fromLTRB
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            // onChanged: _saveTitleInput,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  //we use expanded because it can get as much as horizontal space as it can get on the screen , otherwise it takes all the space
                  controller: _amountController,
                  // onChanged: _saveTitleInput,
                  keyboardType: TextInputType
                      .number, //due to this keyboard changes,as in title it is 'alphabet keyboard' and in amount it changes to 'number keyboard'
                  decoration: const InputDecoration(
                    prefixText: '\$', // amount is in dollar
                    label: Text('Amount'),
                  ),
                ),
              ),
              const SizedBox(
                  width:
                      16), //row k anadr row use nhi kr sakte isliye expanded use kiya h
              Expanded(
                child: Row(
                  //this row is used to grp two others widgets which then together form the date input together
                  mainAxisAlignment:
                      MainAxisAlignment.end, //it put the date icon at the end
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _selectedDate == null
                          ? 'no date selected'
                          : formatter.format(_selectedDate!),
                    ),
                    // ! it tells flutter that it won't null
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(
                        Icons.calendar_month,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Category.values
                    .map(
                      //map is used to transform value from one type to another type
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(
                          category.name.toUpperCase(),
                          //category.name.toString(),
                        ),
                      ),
                    )
                    .toList(), //we call toList on the result of map
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
              const Spacer(),
              //name already yields string value, so calling " toString()" here is redundant. but we wwill replace it with another later anyways
              TextButton(
                onPressed: () {
                  Navigator.pop(context); //switch b/t different screens
                  //when we press cancel then it close the screen
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: _submitExpenseData,
                child: const Text('Save Expense'),
              )
            ],
          ),
        ],
      ),
    );
    /*for storing we used 2 main approaches- add another parameter to text field =onChanged parameter, in this updating
    and storing the current value of text field in some variable _enterdTitle.*/
  }
}
