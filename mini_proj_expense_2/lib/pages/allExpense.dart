import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../controllers/db_helper.dart';
import 'package:flutter/material.dart';

class AllExpense extends StatefulWidget {
  const AllExpense({super.key});

  @override
  State<AllExpense> createState() => _AllExpenseState();
}

class _AllExpenseState extends State<AllExpense> {
  DbHelper dbHelper = DbHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(24, 24, 24, 1.0),
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
                    style: GoogleFonts.lato(color: Colors.grey, fontSize: 18),
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
                                "All Expenses",
                                style: GoogleFonts.roboto(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
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
                            itemCount: snapshot.data!.length + 1,
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
                                if (dataAtIndex['type'] == 'Expense')
                                  return expenseTile(
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
          BoxShadow(
            offset: Offset(5, 5),
            color: Colors.black,
            blurRadius: 20,
          ),
          BoxShadow(
              offset: Offset(-4, -4),
              color: Color.fromARGB(255, 49, 49, 49),
              blurRadius: 20)
        ],
        color: Color.fromRGBO(24, 24, 24, 1.0),
        borderRadius: BorderRadius.circular(8),
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
                    color: Colors.white,
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
        color: Color.fromRGBO(24, 24, 24, 1.0),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            offset: Offset(5, 5),
            color: Colors.black,
            blurRadius: 10,
          ),
          BoxShadow(
              offset: Offset(-4, -4),
              color: Color.fromARGB(255, 49, 49, 49),
              blurRadius: 20)
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
                    color: Colors.white,
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
