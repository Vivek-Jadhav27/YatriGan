import 'package:flutter/material.dart';
import 'package:ticketapp/Utilitis/service.dart';
import 'package:ticketapp/main.dart';
import 'package:ticketapp/screen/payment.dart';

import '../widget/passengerCard.dart';

class Passenger extends StatefulWidget {
  const Passenger({super.key, required this.maxPassenger});
  final int maxPassenger;

  @override
  State<Passenger> createState() => _PassengerState();
}

class _PassengerState extends State<Passenger> {
  
  final TextEditingController _emailtextEditingController =TextEditingController();
  final TextEditingController _phonetextEditingController = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Passenger Details',
          style: TextStyle(color: Color(0xFF499D95)),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xFF499D95),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            margin: EdgeInsets.only(left: 30, right: 20, top: 20),
            child: ListView.builder(
              itemCount: maxPassengerAll,
              itemBuilder: (context, index) {
                return PassengerCard(context: context,index: index);
              },
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.only(left: 30, right: 30, top: 20),
            child: TextField(
              controller: _emailtextEditingController,
              onChanged: (value) {
                setState(() {
                  emailAll = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Email',
                hintStyle: TextStyle(color: Colors.grey),
                icon: Icon(
                  Icons.email,
                  color: Color(0xFF499D95),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 30, right: 30, top: 20),
            child: TextField(
              keyboardType: TextInputType.number,
              controller: _phonetextEditingController,
              onChanged: (value) {
                setState(() {
                  phoneAll = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Phone Number',
                hintStyle: TextStyle(color: Colors.grey),
                icon: Icon(
                  Icons.phone,
                  color: Color(0xFF499D95),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 30, right: 30, top: 20),
            child: MaterialButton(
              onPressed: () {
                if (Service().validateContinue(context)) {
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Payment()),
                  );
                }
              },
              child: Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFF499D95),
                ),
                child: Center(
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
 }
