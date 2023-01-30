import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../controllers/db_helper.dart';

class allIncome extends StatefulWidget {
  const allIncome({super.key});

  @override
  State<allIncome> createState() => _allIncomeState();
}

class _allIncomeState extends State<allIncome> {
  DbHelper dbHelper = DbHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: FutureBuilder(
          future: dbHelper.fetch(),
          builder: ((context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Unexpected Error"),
              );
            } else if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return Center(
                  child: Text(
                    "Press '+' to add values",
                    style: GoogleFonts.lato(
                        color: Color.fromARGB(255, 0, 0, 0), fontSize: 18),
                  ),
                );
              } else {
                return Padding(
                    padding: EdgeInsets.all(12),
                    child: ListView(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
                          child: Row(
                            children: [
                              Text(
                                "All Incomes",
                                style: GoogleFonts.roboto(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              ),
                              Container(
                                child: Text(
                                  ".",
                                  style: GoogleFonts.roboto(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepPurple),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListView.builder(
                            reverse: true,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.length + 100,
                            itemBuilder: (context, index) {
                              dbHelper.compactAll();
                              Map dataAtIndex;
                              try {
                                dataAtIndex = snapshot.data![index];
                              } catch (e) {
                                return Container();
                              }
                              //DateTime date1=dataAtIndex['date'];
                              if (dataAtIndex['amount'] != 0) {
                                if (dataAtIndex['type'] == 'Income')
                                  return incomeTile(
                                    dataAtIndex['amount'],
                                    dataAtIndex['note'],
                                    dataAtIndex['date'],
                                    dataAtIndex['type'],
                                  );
                                else
                                  return Container();
                              } else {
                                return Container();
                              }
                            })
                      ],
                    ));
              }
            } else {
              return Center(
                child: Text("error"),
              );
            }
          }),
        ),
      ),
    );
  }

  Widget expenseTile(int value, String note, DateTime date, String type) {
    String formattedDate = DateFormat.yMMMd().format(date);
    return Container(
      margin: EdgeInsets.fromLTRB(8, 12, 8, 12),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        boxShadow: [
          new BoxShadow(
            color: Color.fromARGB(255, 137, 137, 137),
            blurRadius: 20.0,
            offset: Offset(6, 6),
          ),
        ],
        color: Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.arrow_circle_up_rounded,
                size: 28,
                color: Colors.red,
              ),
              SizedBox(
                width: 4.0,
              ),
              Text(
                "$note",
                style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "$formattedDate",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
          Text(
            "-$value",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
          )
        ],
      ),
    );
  }

  Widget incomeTile(int value, String note, DateTime date, String type) {
    String formattedDate = DateFormat.yMMMd().format(date);
    return Container(
      margin: EdgeInsets.fromLTRB(8, 12, 8, 12),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          new BoxShadow(
            color: Color.fromARGB(255, 137, 137, 137),
            blurRadius: 20.0,
            offset: Offset(6, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Icons.arrow_circle_down_rounded,
                size: 28,
                color: Colors.green,
              ),
              const SizedBox(
                width: 4.0,
              ),
              Text(
                "$note",
                style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "$formattedDate",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
          Text(
            "+$value",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
          )
        ],
      ),
    );
  }
}
