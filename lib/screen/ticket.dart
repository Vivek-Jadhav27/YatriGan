import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:yatrigan/Utilitis/firebaseServise.dart';
import 'package:yatrigan/Utilitis/pdfservice.dart';
import 'package:yatrigan/main.dart';

String tickdetID = '';
class Ticket extends StatefulWidget {
  const Ticket({super.key});

  @override
  State<Ticket> createState() => _TicketState();
}

class _TicketState extends State<Ticket> {
  String characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  int idLength = 8;
  

  String generateRandomTicketId(String allowedChars, int idLength) {
    final Random random = Random();
    final int charsLength = allowedChars.length;

    String id = '';
    for (int i = 0; i < idLength; i++) {
      id += allowedChars[random.nextInt(charsLength)];
    }
    return id;
  }

  @override
  void initState() {
    super.initState();
    tickdetID = generateRandomTicketId(characters, idLength);
    FirebaseService().addTicket(tickdetID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Ticket',
          style: TextStyle(color: Color(0xFF499D95)),
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Are you sure?'),
              content: const Text('Do you want to exit the app?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => exit(0))),
                  child: const Text('Yes'),
                ),
              ],
            ),
          );
          return false;
        },
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFF499D95),
            borderRadius: BorderRadius.circular(15),
          ),
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 60),
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'E - Ticket',
                      style: TextStyle(
                        color: Color(0xFFff7259),
                        fontSize: 20,
                        fontFamily: "Hellix",
                      ),
                    ),
                    Text(tickdetID.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: "Hellix",
                        ))
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Bus Id : $busNameAll',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: "Hellix",
                      ),
                    ),
                    Text(
                      'Date : ' + selectedDateAllString.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: "Hellix",
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'From : $fromLocationAll',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: "Hellix",
                      ),
                    ),
                    Text(
                      'To : $toLocationAll',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: "Hellix",
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      departAll.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: "Hellix",
                      ),
                    ),
                    Text(
                      arrivalAll.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: "Hellix",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'No of Seats : $maxPassengerAll',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: "Hellix",
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Passenger Details : ',
                  style: TextStyle(
                    color: Color(0xFFff7259),
                    fontSize: 20,
                    fontFamily: "Hellix",
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: "Hellix",
                      ),
                    ),
                    Text('Age',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: "Hellix",
                        )),
                    Text(
                      'Gender',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: "Hellix",
                      ),
                    ),
                    Text(
                      'Seat',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: "Hellix",
                      ),
                    )
                  ],
                ),
                ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: maxPassengerAll,
                  itemBuilder: (context, index) {
                    return passengerdetails(index);
                  },
                ),
                SizedBox(height: 20),
                Text(
                  'Total Fare : ',
                  style: TextStyle(
                    color: Color(0xFFff7259),
                    fontSize: 20,
                    fontFamily: "Hellix",
                  ),
                ),
                SizedBox(height: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Basic Fare : ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: "Hellix",
                          ),
                        ),
                        Text(
                          (maxPassengerAll * priceAll).toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: "Hellix",
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Reservation Charges :',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: "Hellix",
                            )),
                        Text(
                          resevationChargeAll.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: "Hellix",
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Toll Charges : ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: "Hellix",
                          ),
                        ),
                        Text(
                          tollTaxAll.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: "Hellix",
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Service Charges : ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: "Hellix",
                          ),
                        ),
                        Text(
                          serviceTaxAll.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: "Hellix",
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Fare : ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: "Hellix",
                          ),
                        ),
                        Text(
                          (maxPassengerAll * priceAll +
                                  resevationChargeAll +
                                  tollTaxAll +
                                  serviceTaxAll)
                              .toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: "Hellix",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Color(0xFFff7259),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                    ),
                    onPressed: () async {
                      Pdf().createPDF();
                    },
                    child: Text(
                      'Print Ticket',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: "Hellix",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget passengerdetails(int index) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            personAll[index],
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: "Hellix",
            ),
          ),
          Text(ageAll[index].toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: "Hellix",
              )),
          Text(
            genderAll[index],
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: "Hellix",
            ),
          ),
          Text(
            selectedSeat[index].toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: "Hellix",
            ),
          )
        ],
      ),
    );
  }
}
