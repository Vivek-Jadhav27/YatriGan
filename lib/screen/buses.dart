import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:yatrigan/component/busItem.dart';
import 'package:intl/intl.dart';
import 'package:yatrigan/main.dart';

List<bool> isSelected = [true, false, false, false, false, false];
String selectedTimeFormatted = '';
int selectedIndex = 0;
List<BusItem> busItem = [];
DateTime newSelectedDate = selectedDateAll;

class Buses extends StatefulWidget {
  const Buses({super.key});
  @override
  State<Buses> createState() => _BusesState();
}

class _BusesState extends State<Buses> {
  StreamController<DatabaseEvent> streamController =
      StreamController<DatabaseEvent>();
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  DatabaseReference databaseReference = FirebaseDatabase.instance
      .ref('Buses')
      .child('${fromLocationAll}To$toLocationAll')
      .child(
          '${selectedDateAll.day}-${selectedDateAll.month}-${selectedDateAll.year}');

  @override
  void initState() {
    super.initState();
    selectedDateAllString = formatDate(selectedDateAll);
    databaseReference.onValue.listen((event) {
      if (event.snapshot.value != null) {
        streamController.add(event);
      }
    });
  }

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }

  Future<void> updateDatabase(DateTime dateTime) async {
    databaseReference = FirebaseDatabase.instance
        .ref('Buses')
        .child('${fromLocationAll}To$toLocationAll')
        .child('${dateTime.day}-${dateTime.month}-${dateTime.year}');
    databaseReference.onValue.listen((event) {
      if (event.snapshot.value != null) {
        streamController.add(event);
      }
    });
  }

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
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xFF499D95),
            )),
        title: const Text(
          'Select Bus',
          style: TextStyle(
            color: Color(0xFF499D95),
          ),
        ),
      ),
      backgroundColor: const Color(0xFF138675),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 150,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0)),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 25, left: 35),
                        child: Text(
                          fromLocationAll.toString(),
                          style: const TextStyle(
                            color: Color(0xFF499D95),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(top: 10, right: 25, left: 35),
                        child: Text(
                          toLocationAll.toString(),
                          style: const TextStyle(
                            color: Color(0xFF499D95),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: 6,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return dateBox(
                              selectedDateAll.add(Duration(days: index)),
                              index,
                            );
                          })),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder<DatabaseEvent>(
                  stream: streamController.stream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      Map<dynamic, dynamic> map = snapshot.data!.snapshot.value
                          as Map<dynamic, dynamic>;
                      List<BusItem> busItems = [];
                      busItems.clear();
                      map.forEach((key, values) {
                        busItems.add(BusItem(
                          busId: key,
                          from: values['From'],
                          to: values['To'],
                          depart: values['Depart'],
                          arrive: values['Arrival'],
                          price: int.parse(values['Price']),
                          maxSeats: values['BookedSeat'].length,
                          seat: values['BookedSeat'].cast<int>(),
                        ));
                        // bookedSeat = values['BookedSeat'].cast<int>();
                      });

                      return ListView.builder(
                        itemCount: busItems.length,
                        itemBuilder: (context, index) {
                          return BusItem(
                            busId: busItems[index].busId,
                            from: busItems[index].from,
                            depart: busItems[index].depart,
                            to: busItems[index].to,
                            maxSeats: busItems[index].maxSeats,
                            price: busItems[index].price,
                            arrive: busItems[index].arrive,
                            seat: busItems[index].seat,
                          );
                        },
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  void formatSelectedDate(DateTime depart) {
    String format = "MMMM d";
    DateFormat dateFormat = DateFormat(format);
    String formattedDate = dateFormat.format(depart);
    newSelectedDate = depart;
    setState(() {
      selectedDateAllString = formattedDate;
    });
  }

  String formatDate(DateTime depart) {
    String formate = "MMM d";
    DateFormat dateFormat = DateFormat(formate);
    return dateFormat.format(depart);
  }

  Widget dateBox(DateTime depart, int index) {
    return GestureDetector(
      onTap: () {
        selectedSeat.clear();
        setState(() {
          isSelected[selectedIndex] = false;
          selectedIndex = index;
          isSelected[selectedIndex] = true;
          formatSelectedDate(selectedDateAll.add(Duration(days: index)));
          updateDatabase(selectedDateAll.add(Duration(days: index)));
        });
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: isSelected[index] ? const Color(0xFF499D95) : Colors.white,
        elevation: 10,
        margin: const EdgeInsets.only(top: 10, left: 12, bottom: 20, right: 12),
        child: Container(
          height: 60,
          width: 70,
          alignment: Alignment.center,
          child: Text(
            formatDate(depart),
            textAlign: TextAlign.center,
            style: TextStyle(
              color:
                  !isSelected[index] ? const Color(0xFF499D95) : Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
