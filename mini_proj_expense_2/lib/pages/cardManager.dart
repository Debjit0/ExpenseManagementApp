import 'package:flutter/material.dart';
import 'package:mini_proj_expense_2/pages/addCard.dart';
import 'package:awesome_card/awesome_card.dart';

class CardManager extends StatefulWidget {
  const CardManager({super.key});

  @override
  State<CardManager> createState() => _CardManagerState();
}

class _CardManagerState extends State<CardManager> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(24, 24, 24, 1.0),
      body: SafeArea(
        child: Column(
          children: [
            CreditCard(
              cardNumber: "1234 5678 5654 5666",
              cardExpiry: "25/26",
              cardHolderName: "Debjit Sarkar",
              cvv: "456",
              bankName: 'Axis Bank',
              showBackSide: false,
              frontBackground: CardBackgrounds.black,
              backBackground: CardBackgrounds.white,
              showShadow: true,
              // mask: getCardTypeMask(cardType: CardType.americanExpress),
            ),
          ],
        ),
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
