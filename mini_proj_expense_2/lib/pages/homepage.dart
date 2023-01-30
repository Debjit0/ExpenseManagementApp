import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mini_proj_expense_2/controllers/db_helper.dart';
import 'package:mini_proj_expense_2/pages/addTransaction.dart';
import 'package:mini_proj_expense_2/pages/allExpense.dart';
import 'package:mini_proj_expense_2/pages/allIncome.dart';
import 'package:mini_proj_expense_2/pages/categoryDisplay.dart';

import 'package:mini_proj_expense_2/pages/search.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int del = 0;
  DbHelper dbHelper = DbHelper();
  int totalBalance = 0;
  int totalIncome = 0;
  int totalExpense = 0;
  List<FlSpot> dataSet = [];
  DateTime today = DateTime.now();

  List<FlSpot> getPlotPoints(Map entireData) {
    dataSet = [];
    entireData.forEach((key, value) {
      if (value['type'] == "Expense" &&
          (value['date'] as DateTime).month == today.month) {
        dataSet.add(FlSpot((value['date'] as DateTime).day.toDouble(),
            (value['amount'] as int).toDouble()));
      }
    });
    return dataSet;
  }

  getTotalBalance(Map entireData) {
    totalExpense = 0;
    totalIncome = 0;
    totalBalance = 0;
    entireData.forEach((key, value) {
      //print(value);
      //print("Total Balance $totalBalance");
      //print("Total Expense $totalExpense");
      //print("Total Income $totalIncome");
      if (value['type'] == 'Income') {
        totalBalance += (value['amount'] as int);
        totalIncome += (value['amount'] as int);
      } else if (value['type'] == 'Expense') {
        totalBalance -= (value['amount'] as int);
        totalExpense += (value['amount'] as int);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        //toolbarHeight: 80,
        flexibleSpace: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
                    //color: Colors.red,
                    child: Row(
                      children: [
                        Container(
                          child: Text(
                            "A",
                            style: GoogleFonts.roboto(
                                fontSize: 42,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                        ),
                        Container(
                          child: Text(
                            "rise",
                            style: GoogleFonts.roboto(
                                fontSize: 42,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                        ),
                        Container(
                          child: Text(
                            ".",
                            style: GoogleFonts.roboto(
                                letterSpacing: 5,
                                fontSize: 42,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => Search()));
                    },
                    child: Container(
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
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        Icons.search,
                        size: 28,
                        color: Colors.deepPurple,
                      ),
                      margin: EdgeInsets.only(right: 8),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => (CategoryDisplay())));
                    },
                    child: Container(
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
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        Icons.category,
                        size: 28,
                        color: Colors.deepPurple,
                      ),
                      margin: EdgeInsets.only(right: 8),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      body: FutureBuilder<Map>(
        future: dbHelper.fetch(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Unexpected Error"),
            );
          } else if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return Center(
                child: Container(
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
                  child: Text(
                    "Press '+' to add values",
                    style: GoogleFonts.lato(
                        color: Color.fromARGB(255, 0, 0, 0), fontSize: 18),
                  ),
                ),
              );
            } else {
              getTotalBalance(snapshot.data!);
              getPlotPoints(snapshot.data!);
              return ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                    /*
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Row(
                              children: [
                                Container(
                                  child: Text(
                                    "A",
                                    style: GoogleFonts.pacifico(
                                        fontSize: 42,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.deepPurple),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "rise",
                                    style: GoogleFonts.pacifico(
                                        fontSize: 42,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    ".",
                                    style: GoogleFonts.pacifico(
                                        letterSpacing: 5,
                                        fontSize: 42,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.deepPurple),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => Search()));
                          },
                          child: Container(
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
                            padding: EdgeInsets.all(8),
                            child: Icon(
                              Icons.search,
                              size: 28,
                              color: Colors.deepPurple,
                            ),
                            margin: EdgeInsets.only(right: 8),
                          ),
                        ),
                      ],
                    ),*/
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    margin: EdgeInsets.all(12.0),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color.fromARGB(255, 156, 250, 255),
                            Color.fromARGB(255, 218, 166, 255),
                          ],
                        ),
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 8),
                        child: Column(
                          children: [
                            Text(
                              "Total Balance",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                  fontSize: 26,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 6),
                            Text(
                              "Rs. $totalBalance",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 26,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  cardIncome(totalIncome.toString()),
                                  cardExpense(totalExpense.toString()),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  //
                  Container(
                    height: 200.0,
                    padding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 10.0,
                    ),
                    margin: EdgeInsets.all(
                      12.0,
                    ),
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
                    child: LineChart(
                      LineChartData(
                        //maxX: 30,
                        //minX: 1,
                        borderData: FlBorderData(
                          show: false,
                        ),
                        lineBarsData: [
                          LineChartBarData(
                            // spots: getPlotPoints(snapshot.data!),
                            spots: getPlotPoints(snapshot.data!),
                            isCurved: false,
                            barWidth: 3,
                            color: Colors.deepPurple,
                            showingIndicators: [200, 200, 90, 10],
                            dotData: FlDotData(
                              show: true,
                            ),
                            belowBarData: BarAreaData(
                              show: true,
                              color: Color.fromARGB(255, 201, 182, 255),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  //*//`
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(12, 12, 0, 12),
                        child: Text(
                          "Recent",
                          style: GoogleFonts.roboto(
                              fontSize: 32,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 12, 12, 12),
                        child: Text(
                          ".",
                          style: GoogleFonts.roboto(
                              fontSize: 32,
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  ListView.builder(
                      reverse: true,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length + 100,
                      itemBuilder: (context, index) {
                        //dbHelper.compactAll();
                        Map dataAtIndex;
                        try {
                          dataAtIndex = snapshot.data![index];
                        } catch (e) {
                          return Container();
                        }

                        //DateTime date1=dataAtIndex['date'];

                        if (dataAtIndex['type'] == 'Income')
                          return incomeTile(
                              dataAtIndex['amount'],
                              dataAtIndex['note'],
                              dataAtIndex['date'],
                              dataAtIndex['type'],
                              index,
                              dataAtIndex['category']);
                        else
                          return expenseTile(
                            dataAtIndex['amount'],
                            dataAtIndex['note'],
                            dataAtIndex['date'],
                            dataAtIndex['type'],
                            index,
                            dataAtIndex['category'],
                          );
                      })
                ],
              );
            }
          } else {
            return Center(
              child: Text("Loading"),
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => AddTransaction()))
              .whenComplete(() {
            setState(() {});
          });
        },
        child: Icon(
          Icons.add,
          size: 32.0,
        ),
      ),
    );
  }

  Widget cardIncome(String value) {
    return Container(
      width: 140,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 162, 249, 165),
          borderRadius: BorderRadius.circular(10)),
      //color: Colors.green,
      child: InkWell(
        onTap: (() {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => allIncome()));
        }),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 45, 45, 45),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.all(6),
              child: Icon(
                Icons.arrow_downward,
                size: 28,
                color: Colors.green,
              ),
              margin: EdgeInsets.only(right: 8),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Income",
                  style: TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  value,
                  style: TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.bold),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget cardExpense(String value) {
    return Container(
      width: 140,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 250, 150, 142),
          borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: (() {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => AllExpense()));
        }),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Expense",
                  style: GoogleFonts.roboto(
                      fontSize: 18,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  value,
                  style: TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 45, 45, 45),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.all(6),
              child: Icon(
                Icons.arrow_upward,
                size: 28,
                color: Colors.red,
              ),
              margin: EdgeInsets.only(left: 8),
            ),
          ],
        ),
      ),
    );
  }

  Widget expenseTile(int value, String note, DateTime date, String type,
      int index, String category) {
    print("index $index");
    String formattedDate = DateFormat.yMMMd().format(date);
    return InkWell(
      onLongPress: () async {
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text("Are you sure?"),
                  content: Text("This record will be deleted."),
                  actions: [
                    TextButton(
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                        child: Text("Cancel")),
                    TextButton(
                        onPressed: () async {
                          Fluttertoast.showToast(msg: "Record Deleted");
                          await dbHelper.deleteOne(index);
                          del = del + 1;
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => HomePage()));
                          setState(() {});
                        },
                        child: Text("Ok")),
                  ],
                ));
        /*Fluttertoast.showToast(msg: "All Data deleted");
                DbHelper dbHelper = new DbHelper();
                dbHelper.deleteAll();
                Navigator.pop(context);*/
      },
      child: Container(
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
          children: <Widget>[
            Row(
              children: [
                if (category == "Food")
                  Icon(
                    Icons.fastfood_outlined,
                    size: 28,
                    color: Colors.red,
                  ),
                if (category == "Travel")
                  Icon(
                    Icons.train_outlined,
                    size: 28,
                    color: Colors.red,
                  ),
                if (category == "Clothing")
                  Icon(
                    Icons.shopping_bag_outlined,
                    size: 28,
                    color: Colors.red,
                  ),
                if (category == "Rent")
                  Icon(
                    Icons.house_outlined,
                    size: 28,
                    color: Colors.red,
                  ),
                if (category == "Misc")
                  Icon(
                    Icons.miscellaneous_services_outlined,
                    size: 28,
                    color: Colors.red,
                  ),
                /*
                Icon(
                  Icons.arrow_circle_up_rounded,
                  size: 28,
                  color: Colors.red,
                ),
                */
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
            ),
          ],
        ),
      ),
    );
  }

  Widget incomeTile(int value, String note, DateTime date, String type,
      int index, String category) {
    print("index $index");
    String formattedDate = DateFormat.yMMMd().format(date);
    //container
    return InkWell(
      onLongPress: () async {
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text("Are you sure?"),
                  content: Text("This record will be deleted"),
                  actions: [
                    TextButton(
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                        child: Text("Cancel")),
                    TextButton(
                        onPressed: () async {
                          Fluttertoast.showToast(msg: "Record Deleted");
                          await dbHelper.deleteOne(index);

                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => HomePage()));
                        },
                        child: Text("Ok")),
                  ],
                ));
        /*Fluttertoast.showToast(msg: "All Data deleted");
                DbHelper dbHelper = new DbHelper();
                dbHelper.deleteAll();
                Navigator.pop(context);*/
      },
      /*onLongPress: () async {
        print("Income tile");
        await dbHelper.deleteOne(index);
        //dbHelper.addData(0, DateTime.now(), "", "");
        dbHelper.addData(0, DateTime.now(), "", "");
        setState(() {});
      },*/
      child: Container(
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
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
