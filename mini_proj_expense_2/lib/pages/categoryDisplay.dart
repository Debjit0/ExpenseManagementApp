import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryDisplay extends StatefulWidget {
  const CategoryDisplay({super.key});

  @override
  State<CategoryDisplay> createState() => _CategoryDisplayState();
}

class _CategoryDisplayState extends State<CategoryDisplay> {
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
    );
  }
}
