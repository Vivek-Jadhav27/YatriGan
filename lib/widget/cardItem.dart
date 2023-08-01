import 'package:flutter/material.dart';
import '../screen/creditCard.dart';
import '../screen/debitCard.dart';
import '../screen/mobileWallet.dart';

class CardItem extends StatefulWidget {
  const CardItem({super.key, required this.index});
  final int index;

  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  final List<String> title = ['Credit Card', 'Debit Card', 'Mobile Wallet'];
  final List list = [ CreditCard(), DebitCard() , MobileWallet()];
  final List<Icon> icons = [
    Icon(
      Icons.credit_card,
      color: Color(0xFF499D95),
      size: 30,
    ),
    Icon(
      Icons.credit_card,
      color: Color(0xFF499D95),
      size: 30,
    ),
    Icon(
      Icons.wallet,
      color: Color(0xFF499D95),
      size: 30,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.only(left: 30, right: 30, top: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return list[widget().index];
              },
            ),
          );
        },
        child: Container(
          width: double.infinity,
          height: 60,
          margin: EdgeInsets.only(top: 10, right: 30, left: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Icon(
                  icons[widget().index].icon,
                  color: Color(0xFF499D95),
                  size: 30,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title[widget().index],
                    style: TextStyle(
                      color: Color(0xFF499D95),
                      fontSize: 18,
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
