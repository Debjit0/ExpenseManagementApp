import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_proj_expense_2/pages/homepage.dart';

class SplashScreen extends StatefulWidget {
  @override
  Splash createState() => Splash();
}

class Splash extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => HomePage())));

    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Container(
        decoration: new BoxDecoration(color: Colors.white),
        child: new Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "A",
                    style: GoogleFonts.pacifico(
                        fontSize: 100,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple),
                  ),
                  Text(
                    "rise",
                    style: GoogleFonts.pacifico(
                        fontSize: 100,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                  /*Text(
                      "!",
                      style: GoogleFonts.pacifico(
                          letterSpacing: 2,
                          fontSize: 82,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple),
                    ),*/
                ],
              ),
              Text(
                "Take Action Now",
                style: TextStyle(
                    color: Color.fromARGB(255, 84, 84, 84),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                    fontSize: 20),
              ),
            ],
          ),
        ),
      ), //<- place where the image appears
    );
  }
}
