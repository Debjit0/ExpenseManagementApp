import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mini_proj_expense_2/controllers/db_helper.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  int? amount;
  String note = "Some Expense";
  String type = "Income";
  DateTime selectedDate = DateTime.now();
  List<String> months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Nov",
    "Dec"
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2020, 12),
        lastDate: DateTime(2100, 12));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0.0),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Text("Add Transactions",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: Colors.amber),
                  padding: EdgeInsets.all(12),
                  child: Icon(
                    Icons.attach_money,
                    //color: Colors.white,//change icon color here
                  )),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "0",
                    border: InputBorder.none,
                  ),
                  onChanged: (val) {
                    try {
                      amount = int.parse(val);
                    } catch (e) {}
                  },
                  style: TextStyle(fontSize: 24),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: Colors.amber),
                  padding: EdgeInsets.all(12),
                  child: Icon(
                    Icons.description,
                    //color: Colors.white,//change icon color here
                  )),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Note",
                    border: InputBorder.none,
                  ),
                  onChanged: (val) {
                    note = val;
                  },
                  style: TextStyle(fontSize: 24),
                  //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  //keyboardType: TextInputType.number,
                  //maxLength: 24,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: Colors.amber),
                  padding: EdgeInsets.all(12),
                  child: Icon(
                    Icons.moving_sharp,
                    //color: Colors.white,//change icon color here
                  )),
              SizedBox(
                width: 12,
              ),
              ChoiceChip(
                selectedColor: Colors.amber,
                label: Text(
                  "Income",
                  style: TextStyle(
                      color: type == "Income" ? Colors.white : Colors.black),
                ),
                selected: type == "Income" ? true : false,
                onSelected: (val) {
                  if (val) {
                    setState(() {
                      type = "Income";
                    });
                  }
                },
              ),
              SizedBox(
                width: 12,
              ),
              ChoiceChip(
                selectedColor: Colors.amber,
                label: Text(
                  "Expense",
                  style: TextStyle(
                      color: type == "Expense" ? Colors.white : Colors.black),
                ),
                selected: type == "Expense" ? true : false,
                onSelected: (val) {
                  if (val) {
                    setState(() {
                      type = "Expense";
                    });
                  }
                },
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: Colors.amber),
                  padding: EdgeInsets.all(12),
                  child: Icon(
                    Icons.date_range_outlined,
                    //color: Colors.white,//change icon color here
                  )),
              TextButton(
                  onPressed: () {
                    _selectDate(context);
                  },
                  child: Text("${selectedDate.day} / ${selectedDate.month}")),
            ],
          ),
          ElevatedButton(
              onPressed: () async {
                if (amount != null && note.isNotEmpty) {
                  DbHelper dbHelper = new DbHelper();
                  await dbHelper.addData(amount!, selectedDate, note, type);
                  Navigator.of(context).pop();
                } else {
                  print("Not all Values provided");
                }
              },
              child: Text("Add")),
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red[700]),
              onPressed: () {
                DbHelper dbHelper = new DbHelper();
                dbHelper.deleteAll();
              },
              child: Text("Delete All Data")),
        ],
      ),
    );
  }
}
