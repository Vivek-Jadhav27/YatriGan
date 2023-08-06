import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:yatrigan/main.dart';
import 'package:yatrigan/screen/buses.dart';
import 'datePicker.dart';
import '../widget/fromBox.dart';
import 'personCount.dart';
import '../widget/toBox.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final TextEditingController _fromtextEditingController =
      TextEditingController();
  final TextEditingController _totextEditingController =
      TextEditingController();

  @override
  void dispose() {
    _fromtextEditingController.dispose();
    _totextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'Find a route,',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'Lets make a journey',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
          Column(
            children: [
              Row(children: [
                Container(
                  margin: EdgeInsets.only(top: 10, right: 25, left: 35),
                  child: Text(
                    'From',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ]),
              FromBox()
            ],
          ),
          Column(
            children: [
              Row(children: [
                Container(
                  margin: EdgeInsets.only(top: 10, right: 25, left: 35),
                  child: Text(
                    'To',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ]),
              ToBox(),
              SizedBox(
                height: 15,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DatePicker(),
              PersonCount(),
            ],
          ),
          submitButton(),
        ],
      ),
    );
  }

  Widget submitButton() {
    return GestureDetector(
      onTap: () {
        if (fromLocationAll == null || toLocationAll == null) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text('Please fill all the details'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Ok'),
                  ),
                ],
              );
            },
          );
          return;
        } else if (fromLocationAll == toLocationAll) {
          return;
        } else {
          busItem.clear();
          _addbus();
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Buses()));
        }
      },
      child: Container(
        height: 40,
        width: 120,
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(255, 250, 114, 17),
        ),
        child: const Text(
          'Search',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _addbus() async {
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref('Buses');
    List<String> buses = [];
    List<int> bookedSeats = [2, 3, 4, 6];
    List<String> from = [], to = [];
    List<DateTime> dates = [];

    Map<String, dynamic> toJson(int index) {
      return {
        'From': fromLocationAll,
        'To': toLocationAll,
        'Depart': '8:00 AM',
        'Arrival': '11:00 Am',
        'Price': '${120 + index * 100}',
        'BookedSeat': bookedSeats,
      };
    }

    for (int i = 0; i < 6; i++) {
      dates.add(selectedDateAll.add(Duration(days: i)));
          DatabaseEvent event = await databaseReference
          .child('${fromLocationAll}To$toLocationAll')
            .child('${dates[i].day}-${dates[i].month}-${dates[i].year}').once();
            if (event.snapshot.value == null) {
              await databaseReference
            .child('${fromLocationAll}To$toLocationAll')
            .child('${dates[i].day}-${dates[i].month}-${dates[i].year}')
            .child('BUS${i + 2}${i + 1}')
            .set(toJson(i)); 
            }
            else{
              
            }
            
    }
  }
}
