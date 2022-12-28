import 'dart:ffi';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mini_proj_expense_2/controllers/db_helper.dart';
import 'package:mini_proj_expense_2/pages/addTransaction.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DbHelper dbHelper = new DbHelper();
  int totalBalance = 0;
  int totalIncome = 0;
  int totalExpense = 0;
  List<FlSpot> dataSet = [];
  DateTime today = DateTime.now();

  List<FlSpot> getPlotPoints(Map entireData) {
    dataSet = [];
    entireData.forEach((key, value) {
      if (value['type'] == 'expense' &&
          (value['date'] as DateTime).month == today.month) {
        dataSet.add(
          FlSpot((value['date'] as DateTime).month.toDouble(),
              (value['amount'] as int).toDouble()),
        );
      }
    });
    return dataSet;
  }

  getTotalBalance(Map entireData) {
    totalExpense = 0;
    totalIncome = 0;
    totalBalance = 0;
    entireData.forEach((key, value) {
      print(value);
      print("Total Balance $totalBalance");
      print("Total Expense $totalExpense");
      print("Total Income $totalIncome");
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
      appBar: AppBar(toolbarHeight: 0.0),
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
                child: Text("No Values Found"),
              );
            } else {
              getTotalBalance(snapshot.data!);
              return ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              child: Text(
                                "Hi There!",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(12)),
                          child: Icon(
                            size: 32,
                            Icons.settings,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    margin: EdgeInsets.all(12.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                          gradient: LinearGradient(
                              colors: [Colors.black, Colors.blueAccent])),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 8),
                        child: Column(
                          children: [
                            Text(
                              "Total Balance",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 22, color: Colors.white),
                            ),
                            SizedBox(height: 12),
                            Text(
                              "Rs. $totalBalance",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 26,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
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
                  const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      "Expenses",
                      style: TextStyle(
                          fontSize: 32,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  //
                  //
                  //
                  Container(
                    margin: EdgeInsets.all(12),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 5,
                            blurRadius: 6,
                            offset: Offset(0, 4),
                          )
                        ]),
                    height: 400,
                    child: LineChart(
                      LineChartData(
                          borderData: FlBorderData(show: false),
                          lineBarsData: [
                            LineChartBarData(
                              spots: getPlotPoints(snapshot.data!),
                              isCurved: false,
                              barWidth: 2.5,
                              color: Colors.orange,
                            ),
                          ]),
                    ),
                  ),
                  //
                  //
                  const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      "Recent Expense",
                      style: TextStyle(
                          fontSize: 32,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Map dataAtIndex = snapshot.data![index];
                        if (dataAtIndex['type'] == 'Income')
                          return incomeTile(
                              dataAtIndex['amount'], dataAtIndex['note']);
                        else
                          return expenseTile(
                              dataAtIndex['amount'], dataAtIndex['note']);
                      })
                ],
              );
            }
          } else {
            return Center(
              child: Text("Unexpected Error"),
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
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
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
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            Text(
              value,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ],
        )
      ],
    );
  }

  Widget cardExpense(String value) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "Expense",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            Text(
              value,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
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
    );
  }

  Widget expenseTile(int value, String note) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color(0xffced4eb),
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
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          Text(
            "-$value",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget incomeTile(int value, String note) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color(0xffced4eb),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.arrow_circle_down_rounded,
                size: 28,
                color: Colors.green,
              ),
              SizedBox(
                width: 4.0,
              ),
              Text(
                "$note",
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          Text(
            "+$value",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
//53:33
//https://www.youtube.com/watch?v=VOWy5-zTeWk&t=2462s
