import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_proj_expense_2/controllers/db_helper.dart';
import 'package:pie_chart/pie_chart.dart';

class CategoryDisplay extends StatefulWidget {
  const CategoryDisplay({super.key});

  @override
  State<CategoryDisplay> createState() => _CategoryDisplayState();
}

class _CategoryDisplayState extends State<CategoryDisplay> {
  //
  final dataMap = <String, double>{
    "Flutter": 5,
    "React": 3,
    "Xamarin": 2,
    "Ionic": 2,
  };
  int totExp = 0;
  int foodAmt = 0;
  int rentAmt = 0;
  int clothingAmt = 0;
  int travelAmt = 0;
  int miscAmt = 0;
  double perFood = 0;
  double perTravel = 0;
  double perRent = 0;
  double perClothing = 0;
  double perMisc = 0;
  DbHelper dbHelper = new DbHelper();
  //
  getCategoryBalance(Map entireData) {
    foodAmt = 0;
    rentAmt = 0;
    clothingAmt = 0;
    travelAmt = 0;
    miscAmt = 0;
    entireData.forEach((key, value) {
      if (value['category'] == 'Food' && value['type'] == "Expense") {
        foodAmt += (value['amount'] as int);
      } else if (value['category'] == 'Travel' && value['type'] == "Expense") {
        travelAmt += (value['amount'] as int);
      } else if (value['category'] == 'Clothing' &&
          value['type'] == "Expense") {
        clothingAmt += (value['amount'] as int);
      } else if (value['category'] == 'Rent' && value['type'] == "Expense") {
        rentAmt += (value['amount'] as int);
      } else if (value['category'] == 'Misc' && value['type'] == "Expense") {
        miscAmt += (value['amount'] as int);
      }
    });
  }

  Map<String, double> getPieSection(Map entireData) {
    perFood = 0;
    perTravel = 0;
    perRent = 0;
    perClothing = 0;
    perMisc = 0;
    totExp = 0;
    entireData.forEach((key, value) {
      if (value['category'] == 'Food' && value['type'] == "Expense") {
        foodAmt += (value['amount'] as int);
        totExp += (value['amount'] as int);
      } else if (value['category'] == 'Travel' && value['type'] == "Expense") {
        travelAmt += (value['amount'] as int);
        totExp += (value['amount'] as int);
      } else if (value['category'] == 'Clothing' &&
          value['type'] == "Expense") {
        clothingAmt += (value['amount'] as int);
        totExp += (value['amount'] as int);
      } else if (value['category'] == 'Rent' && value['type'] == "Expense") {
        rentAmt += (value['amount'] as int);
        totExp += (value['amount'] as int);
      } else if (value['category'] == 'Misc' && value['type'] == "Expense") {
        miscAmt += (value['amount'] as int);
        totExp += (value['amount'] as int);
      }
    });
    perFood = (foodAmt / totExp) * 50;
    perTravel = (travelAmt / totExp) * 50;
    perClothing = (clothingAmt / totExp) * 50;
    perRent = (rentAmt / totExp) * 50;
    perMisc = (miscAmt / totExp) * 50;

    return {
      "Food": perFood,
      "Shopping": perClothing,
      "Travel": perTravel,
      "Rent": perRent,
      "Misc": perMisc
    };
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            "C",
                            style: GoogleFonts.roboto(
                                fontSize: 42,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                        ),
                        Container(
                          child: Text(
                            "ategories",
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
                  child: Text("Please Add Some Values"),
                );
              } else {
                getCategoryBalance(snapshot.data!);
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        width: double.infinity,
                        height: 360,
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      boxShadow: [
                                        new BoxShadow(
                                          color: Color.fromARGB(
                                              255, 137, 137, 137),
                                          blurRadius: 20.0,
                                          offset: Offset(6, 6),
                                        ),
                                      ],
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(24)),
                                    ),
                                    padding: EdgeInsets.all(12),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.fastfood_outlined,
                                          color: Colors
                                              .deepPurple, //change icon color here
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Food ",
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.deepPurple,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    )),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "$foodAmt",
                                  style: TextStyle(fontSize: 25),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      boxShadow: [
                                        new BoxShadow(
                                          color: Color.fromARGB(
                                              255, 137, 137, 137),
                                          blurRadius: 20.0,
                                          offset: Offset(6, 6),
                                        ),
                                      ],
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(24)),
                                    ),
                                    padding: EdgeInsets.all(12),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.shopping_bag_outlined,
                                          color: Colors
                                              .deepPurple, //change icon color here
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Shopping ",
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.deepPurple,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    )),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "$clothingAmt",
                                  style: TextStyle(fontSize: 25),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      boxShadow: [
                                        new BoxShadow(
                                          color: Color.fromARGB(
                                              255, 137, 137, 137),
                                          blurRadius: 20.0,
                                          offset: Offset(6, 6),
                                        ),
                                      ],
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(24)),
                                    ),
                                    padding: EdgeInsets.all(12),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.train_outlined,
                                          color: Colors
                                              .deepPurple, //change icon color here
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Travels",
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.deepPurple,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    )),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "$travelAmt",
                                  style: TextStyle(fontSize: 25),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      boxShadow: [
                                        new BoxShadow(
                                          color: Color.fromARGB(
                                              255, 137, 137, 137),
                                          blurRadius: 20.0,
                                          offset: Offset(6, 6),
                                        ),
                                      ],
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(24)),
                                    ),
                                    padding: EdgeInsets.all(12),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.house_outlined,
                                          color: Colors
                                              .deepPurple, //change icon color here
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Rent ",
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.deepPurple,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    )),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "$rentAmt",
                                  style: TextStyle(fontSize: 25),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      boxShadow: [
                                        new BoxShadow(
                                          color: Color.fromARGB(
                                              255, 137, 137, 137),
                                          blurRadius: 20.0,
                                          offset: Offset(6, 6),
                                        ),
                                      ],
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(24)),
                                    ),
                                    padding: EdgeInsets.all(12),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.miscellaneous_services_outlined,
                                          color: Colors
                                              .deepPurple, //change icon color here
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Misc.",
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.deepPurple,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    )),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "$miscAmt",
                                  style: TextStyle(fontSize: 25),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    //PIE CHART
                    //
                    //
                    //
                    Container(
                      child: PieChart(dataMap: getPieSection(snapshot.data!)),
                    ),
                  ],
                );
              }
            } else {
              return Container();
            }
          }),
    );
  }
}
