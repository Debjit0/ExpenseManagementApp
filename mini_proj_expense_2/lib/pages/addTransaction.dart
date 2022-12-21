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
        padding: const EdgeInsets.all(20),
        children: [
          const Text("Add Transactions"),
          Row(
            children: const [
              Icon(Icons.attach_money),
            ],
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "0",
                border: InputBorder.none,
              ),
              style: TextStyle(
                fontSize: 24,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              keyboardType: TextInputType.number,
            ),
          )
        ],
      ),
    );
  }
}
