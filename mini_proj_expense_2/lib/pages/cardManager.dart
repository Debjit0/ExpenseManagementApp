import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_proj_expense_2/controllers/carddb_helper.dart';
import 'package:mini_proj_expense_2/pages/addCard.dart';
import 'package:awesome_card/awesome_card.dart';

class CardManager extends StatefulWidget {
  const CardManager({super.key});

  @override
  State<CardManager> createState() => _CardManagerState();
}

class _CardManagerState extends State<CardManager> {
  CardDbHelper cardDbHelper = new CardDbHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(24, 24, 24, 1.0),
      body: FutureBuilder<Map>(
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
                    color: Color.fromARGB(255, 45, 45, 45),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "Press '+' to add values",
                    style: GoogleFonts.lato(color: Colors.grey, fontSize: 18),
                  ),
                ),
              );
            } else {
              return ListView(
                children: [
                  ListView.builder(
                      reverse: true,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length + 1,
                      itemBuilder: (context, index) {
                        cardDbHelper.compactAll();
                        Map dataAtIndex;
                        try {
                          dataAtIndex = snapshot.data![index];
                        } catch (e) {
                          return Container();
                        }
                        if (dataAtIndex['cardno'] != 0) {
                          return CreditCard(
                            cardNumber: "122",
                            cardExpiry: "122",
                            cardHolderName: "122",
                            cvv: "121",
                            bankName: 'Axis Bank',
                            showBackSide: false,
                            frontBackground: CardBackgrounds.black,
                            backBackground: CardBackgrounds.white,
                            showShadow: true,
                            // mask: getCardTypeMask(cardType: CardType.americanExpress),
                          );
                        } else {
                          return Container();
                        }
                      }),
                ],
              );
            }
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => AddCard()));
        }),
        child: Icon(Icons.add),
      ),
    );
  }
}
