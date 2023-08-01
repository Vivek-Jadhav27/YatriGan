import 'package:flutter/material.dart';
import 'package:ticketapp/main.dart';
import '../screen/selectseat.dart';

class BusItem extends StatelessWidget {
  const BusItem(
      {super.key,
      required this.from,
      required this.to,
      required this.depart,
      required this.maxSeats,
      required this.busId,
      required this.arrive,
      required this.price});

  final String busId;
  final String from;
  final String to;
  final String depart;
  final String arrive;
  final int maxSeats;
  final int price;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        busNameAll = busId;
        fromLocationAll = from;
        toLocationAll = to;
        departAll = depart;
        arrivalAll = arrive;
        priceAll = price;
        maxPassengerAll = maxSeats;
        isSelected1 = List<bool>.filled(24, false);
        isSelected2 = List<bool>.filled(16, false);
        selected = 0;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SelectSeat(),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin: EdgeInsets.only(right: 30, left: 30, bottom: 10, top: 10),
        elevation: 10,
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(busId,
                      style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFF499D95),
                          fontFamily: "Hellix")),
                ),
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(from,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF499D95),
                            fontFamily: "Hellix")),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      to,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF499D95),
                          fontFamily: "Hellix"),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text('Depart',
                        style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 172, 172, 172),
                            fontFamily: "Hellix")),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      'Arrive',
                      style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 172, 172, 172),
                          fontFamily: "Hellix"),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(depart,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontFamily: "Hellix")),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      arrive,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: "Hellix"),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(price.toString() + ' Rs',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFff7259),
                            fontFamily: "Hellix")),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      '10 Seats',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFff7259),
                          fontFamily: "Hellix"),
                      textAlign: TextAlign.end,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
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
                    },
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        'View Details',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFff7259),
                            fontFamily: "Hellix"),
                        textAlign: TextAlign.end,
                      ),
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
