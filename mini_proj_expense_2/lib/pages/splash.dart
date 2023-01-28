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

    return MaterialApp(
      home: Scaffold(
        /* appBar: AppBar(
          title: Text("MyApp"),
          backgroundColor:
              Colors.blue, //<- background color to combine with the picture :-)
        ),*/
        body: Container(
          decoration: new BoxDecoration(color: Colors.white),
          child: new Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "A",
                  style: GoogleFonts.pacifico(
                      fontSize: 82,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple),
                ),
                Text(
                  "rise",
                  style: GoogleFonts.pacifico(
                      fontSize: 82,
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
          ),
        ), //<- place where the image appears
      ),
    );
  }
}
