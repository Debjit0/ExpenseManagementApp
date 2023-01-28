import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_proj_expense_2/controllers/db_helper.dart';
import 'package:mini_proj_expense_2/pages/homepage.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  int? amount;
  String note = "No info";
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
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Row(
            children: [
              Text("Add Transactions",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.lato(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 32,
                      fontWeight: FontWeight.bold)),
              Text(".",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.lato(
                      color: Colors.deepPurple,
                      fontSize: 32,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    boxShadow: [
                      new BoxShadow(
                        color: Color.fromARGB(255, 137, 137, 137),
                        blurRadius: 20.0,
                        offset: Offset(6, 6),
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                  ),
                  padding: EdgeInsets.all(12),
                  child: Icon(
                    Icons.currency_rupee_outlined,
                    color: Colors.green, //change icon color here
                  )),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    //fillColor: Colors.grey,
                    hintText: "0",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                  onChanged: (val) {
                    try {
                      amount = int.parse(val);
                    } catch (e) {}
                  },
                  style: TextStyle(fontSize: 24, color: Colors.grey),
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
                    color: Color.fromARGB(255, 255, 255, 255),
                    boxShadow: [
                      new BoxShadow(
                        color: Color.fromARGB(255, 137, 137, 137),
                        blurRadius: 20.0,
                        offset: Offset(6, 6),
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                  ),
                  padding: EdgeInsets.all(12),
                  child: Icon(
                    Icons.description,
                    color: Colors.amber, //change icon color here
                  )),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Note",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                  onChanged: (val) {
                    note = val;
                  },
                  style: TextStyle(fontSize: 24, color: Colors.grey),
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
                    color: Color.fromARGB(255, 255, 255, 255),
                    boxShadow: [
                      new BoxShadow(
                        color: Color.fromARGB(255, 137, 137, 137),
                        blurRadius: 20.0,
                        offset: Offset(6, 6),
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                  ),
                  padding: EdgeInsets.all(12),
                  child: Icon(
                    Icons.moving_sharp,
                    color: Colors.deepPurple, //change icon color here
                  )),
              SizedBox(
                width: 12,
              ),
              ChoiceChip(
                selectedColor: Colors.deepPurple,
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
                selectedColor: Colors.deepPurple,
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
                    color: Color.fromARGB(255, 255, 255, 255),
                    boxShadow: [
                      new BoxShadow(
                        color: Color.fromARGB(255, 137, 137, 137),
                        blurRadius: 20.0,
                        offset: Offset(6, 6),
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                  ),
                  padding: EdgeInsets.all(12),
                  child: Icon(
                    Icons.date_range_outlined,
                    color: Colors.blueAccent, //change icon color here
                  )),
              TextButton(
                  onPressed: () {
                    _selectDate(context);
                  },
                  child: Text(
                    "${selectedDate.day} / ${selectedDate.month}",
                    style: TextStyle(color: Colors.blueAccent),
                  )),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () async {
                if (type == "Expense") {
                  if (amount == null || amount == 0) {
                    Fluttertoast.showToast(
                        msg: "Enter valid data", textColor: Colors.green);
                  } else {
                    Fluttertoast.showToast(
                        msg: "Income Added", textColor: Colors.green);
                  }
                } else if (type == "Income") {
                  if (amount == null || amount == 0) {
                    Fluttertoast.showToast(
                      msg: "Enter valid data",
                      textColor: Colors.green,
                    );
                  } else {
                    Fluttertoast.showToast(
                        msg: "Income Added", textColor: Colors.green);
                  }
                }
                if (amount != null && note.isNotEmpty) {
                  DbHelper dbHelper = new DbHelper();
                  await dbHelper.addData(amount!, selectedDate, note, type);
                  Navigator.of(context).pop();
                } else {
                  print("Not all Values provided");
                }
              },
              child: Text("Add")),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red[900]),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                          title: Text("Are you sure?"),
                          content: Text("This Will delete all the records."),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Cancel")),
                            TextButton(
                                onPressed: () {
                                  Fluttertoast.showToast(
                                      msg: "All Data deleted");
                                  DbHelper dbHelper = new DbHelper();
                                  dbHelper.deleteAll();
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => HomePage()));
                                },
                                child: Text("Yes")),
                          ],
                        ));
                /*Fluttertoast.showToast(msg: "All Data deleted");
                DbHelper dbHelper = new DbHelper();
                dbHelper.deleteAll();
                Navigator.pop(context);*/
              },
              child: Text("Delete All Data")),
        ],
      ),
    );
  }
}
