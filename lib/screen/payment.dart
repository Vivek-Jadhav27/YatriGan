import 'package:flutter/material.dart';
import 'package:yatrigan/screen/mobileWallet.dart';
import 'package:yatrigan/widget/cardItem.dart';

import 'creditCard.dart';
import 'debitCard.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Color(0xFF499D95),
            )),
        title: Text(
          'Payment',
          style: TextStyle(
            color: Color(0xFF499D95),
          ),
        ),
      ),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: 3,
            itemBuilder: (context, index) {
              return CardItem(index: index);
            },
          ),
        ],
      )),
    );
  }
}
