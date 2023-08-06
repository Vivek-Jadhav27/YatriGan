import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:yatrigan/main.dart';
import 'package:yatrigan/screen/passengerDetails.dart';
import 'package:yatrigan/widget/buildGridItem1.dart';
import 'package:yatrigan/widget/buildGridItem2.dart';

int selected = 0;
List<bool> isSelected1 = List<bool>.filled(24, false);
List<bool> isSelected2 = List<bool>.filled(16, false);
List<bool> isBooked1 = List<bool>.filled(24, false);
List<bool> isBooked2 = List<bool>.filled(16, false);
List<int> trueIndices1 = [];
List<int> trueIndices2 = [];
List<int> bookingseat = [];


class SelectSeat extends StatefulWidget {
  const SelectSeat({
    super.key,
  });

  @override
  State<SelectSeat> createState() => _SelectSeatState();
}

class _SelectSeatState extends State<SelectSeat> {
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  DatabaseReference databaseReference = FirebaseDatabase.instance
      .ref('Buses')
      .child('${fromLocationAll}To$toLocationAll')
      .child(
          '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}')
      .child('$busNameAll');

  @override
  void initState() {
    super.initState();
    
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF499D95),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Select Seat',
          style: TextStyle(fontFamily: "Hellix", color: Color(0xFF499D95)),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(left: 20, right: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$busNameAll',
                      style: TextStyle(
                        color: Color(0xFF499D95),
                        fontSize: 16,
                        fontFamily: "Hellix",
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '$fromLocationAll',
                          style: TextStyle(
                            color: Color(0xFF499D95),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Hellix",
                          ),
                        ),
                        Text(
                          '$toLocationAll',
                          style: TextStyle(
                            color: Color(0xFF499D95),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Hellix",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 460,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 210,
                      height: 490,
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1.0,
                          crossAxisSpacing: 1.0,
                          mainAxisSpacing: 1.0,
                        ),
                        padding: EdgeInsets.only(top: 0, left: 20, right: 20),
                        itemCount: 24,
                        itemBuilder: (context, index) {
                          return BuildGridItems1(
                            index: index,
                          );
                        },
                      ),
                    ),
                    Container(
                      width: 145,
                      height: 490,
                      margin: EdgeInsets.only(top: 0, right: 5),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.0,
                          crossAxisSpacing: 1.0,
                          mainAxisSpacing: 1.0,
                        ),
                        padding: EdgeInsets.only(left: 16, right: 16, top: 0),
                        itemBuilder: (context, index) {
                          return BuildGridItem2(index: index);
                        },
                        itemCount: 16,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 25,
                    width: 25,
                    margin: EdgeInsets.only(left: 20, top: 10),
                    decoration: BoxDecoration(
                      color: Color(0xFF138675),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Booked',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    height: 25,
                    width: 25,
                    margin: EdgeInsets.only(left: 20, top: 10),
                    decoration: BoxDecoration(
                      color: Color(0xFF499D95),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Selected',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    height: 25,
                    width: 25,
                    margin: EdgeInsets.only(left: 20, top: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Color(0xFF138675), width: 2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Available',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.center,
                child: MaterialButton(
                  height: 35,
                  onPressed: () {
                    if (selected == maxPassengerAll) {
                      selectedSeat.clear();
                      for (int i = 0; i < isSelected1.length; i++) {
                        if (isSelected1[i]) {
                          selectedSeat.add(((i ~/ 3) * 5) + (i % 3) + 1);
                        }
                      }
                      for (int i = 0; i < isSelected2.length; i++) {
                        if (isSelected2[i]) {
                          selectedSeat.add(((i ~/ 2) * 5) + (i % 2) + 4);
                        }
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Passenger(
                                  maxPassenger: maxPassengerAll,
                                )),
                      );
                    }
                  },
                  child: Text('Continue',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Hellix",
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  color: Color(0xFFff7259),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
