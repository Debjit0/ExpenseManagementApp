import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
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
        ],
      ),
    );
  }
}
