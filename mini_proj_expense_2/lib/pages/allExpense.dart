import 'package:google_fonts/google_fonts.dart';

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
      body: FutureBuilder(
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
                child: Text(
                  "Addawd",
                  style: TextStyle(fontSize: 40, color: Colors.white),
                ),
              );
            }
          } else {
            return Center(
              child: Text("error"),
            );
          }
        }),
      ),
    );
  }
}
