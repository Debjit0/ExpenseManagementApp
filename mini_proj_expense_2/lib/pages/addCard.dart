import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_proj_expense_2/controllers/carddb_helper.dart';
import 'package:mini_proj_expense_2/controllers/db_helper.dart';

class AddCard extends StatefulWidget {
  const AddCard({super.key});

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  @override
  String cardno = "1111 1111 1111 1111";
  String bankname = "Not Mentioned";
  String exp = "111";
  String cvv = "Not Mentioned";
  String type = "Master";
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0.0),
      backgroundColor: Color.fromRGBO(24, 24, 24, 1.0),
      body: ListView(
        padding: EdgeInsets.all(12),
        children: [
          Row(
            children: [
              Text("Add Card",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.lato(
                      color: Colors.grey,
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
                    color: Color.fromARGB(255, 23, 23, 23),
                    boxShadow: [
                      new BoxShadow(
                        color: Color.fromARGB(255, 0, 0, 0),
                        blurRadius: 20.0,
                        offset: Offset(6, 6),
                      ),
                      new BoxShadow(
                        color: Color.fromARGB(255, 36, 36, 36),
                        blurRadius: 20.0,
                        offset: Offset(-6, -6),
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                  ),
                  padding: EdgeInsets.all(12),
                  child: Icon(
                    Icons.house,
                    color: Colors.amber, //change icon color here
                  )),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Bank Name",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                  onChanged: (val) {
                    bankname = val;
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
            height: 12,
          ),
          Row(
            children: [
              Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 23, 23, 23),
                    boxShadow: [
                      new BoxShadow(
                        color: Color.fromARGB(255, 0, 0, 0),
                        blurRadius: 20.0,
                        offset: Offset(6, 6),
                      ),
                      new BoxShadow(
                        color: Color.fromARGB(255, 36, 36, 36),
                        blurRadius: 20.0,
                        offset: Offset(-6, -6),
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                  ),
                  padding: EdgeInsets.all(12),
                  child: Icon(
                    Icons.credit_card,
                    color: Colors.green, //change icon color here
                  )),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    //fillColor: Colors.grey,
                    hintText: "Card Number",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                  onChanged: (val) {
                    try {
                      cardno = val;
                    } catch (e) {}
                  },
                  style: TextStyle(fontSize: 24, color: Colors.grey),
                  //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 23, 23, 23),
                    boxShadow: [
                      new BoxShadow(
                        color: Color.fromARGB(255, 0, 0, 0),
                        blurRadius: 20.0,
                        offset: Offset(6, 6),
                      ),
                      new BoxShadow(
                        color: Color.fromARGB(255, 36, 36, 36),
                        blurRadius: 20.0,
                        offset: Offset(-6, -6),
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                  ),
                  padding: EdgeInsets.all(12),
                  child: Icon(
                    Icons.lock,
                    color: Colors.deepPurple, //change icon color here
                  )),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    //fillColor: Colors.grey,
                    hintText: "CVV",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                  onChanged: (val) {
                    try {
                      cardno = val;
                    } catch (e) {}
                  },
                  style: TextStyle(fontSize: 24, color: Colors.grey),
                  //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 23, 23, 23),
                    boxShadow: [
                      new BoxShadow(
                        color: Color.fromARGB(255, 0, 0, 0),
                        blurRadius: 20.0,
                        offset: Offset(6, 6),
                      ),
                      new BoxShadow(
                        color: Color.fromARGB(255, 36, 36, 36),
                        blurRadius: 20.0,
                        offset: Offset(-6, -6),
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                  ),
                  padding: EdgeInsets.all(12),
                  child: Icon(
                    Icons.calendar_month,
                    color: Colors.deepOrange, //change icon color here
                  )),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    //fillColor: Colors.grey,
                    hintText: "Exp Date",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                  onChanged: (val) {
                    try {
                      cardno = val;
                    } catch (e) {}
                  },
                  style: TextStyle(fontSize: 24, color: Colors.grey),
                  //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          ElevatedButton(
              onPressed: () async {
                if (cardno != null || cvv != null) {
                  CardDbHelper cardDbHelper = new CardDbHelper();
                  await cardDbHelper.addData(cardno, cvv, exp, type, bankname);
                  Navigator.of(context).pop();
                }
              },
              child: Text("Add")),
          SizedBox(
            height: 12,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red[900]),
              onPressed: () {},
              child: Text("Delete All"))
        ],
      ),
    );
  }
}
