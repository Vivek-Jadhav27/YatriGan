import 'package:flutter/material.dart';
import 'package:ticketapp/component/busItem.dart';
import 'package:intl/intl.dart';
import 'package:ticketapp/main.dart';

List<bool> isSelected = [true, false, false, false, false, false];
String selectedTimeFormatted = '';
int selectedIndex = 0;
List<BusItem> busItem = [];
List<String> timing = [];
List<BusItem> requiredBusItem = [];

class Buses extends StatefulWidget {
  const Buses({
    Key? key,
  });
  @override
  State<Buses> createState() => _BusesState();
}

class _BusesState extends State<Buses> {
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < locations.length; i++) {
      formatTiming(DateTime.now().add(Duration(hours: i)));
      timing.add(selectedTimeFormatted);
    }

    for (int i = 0; i < locations.length; i++) {
      for (int j = 0; j < locations.length; j++) {
        if (locations[i] != locations[j]) {
          busItem.add(BusItem(
            busId: 'BUS${i + j + 1}${i + j + 2}',
            from: locations[i],
            to: locations[j],
            depart: timing[i],
            arrive: timing[j],
            price: 700 + i * 100,
            maxSeats: 10,
          ));
        }
      }
    }
    for (int i = 0; i < busItem.length; i++) {
      if (busItem[i].from == fromLocationAll &&
          busItem[i].to == toLocationAll) {
        requiredBusItem.add(busItem[i]);
      }
    }
  }

  void formatTiming(DateTime timevalue) {
    String format = "h:mm a";
    DateFormat dateFormat = DateFormat(format);
    String formattedDate = dateFormat.format(timevalue);
    setState(() {
      selectedTimeFormatted = formattedDate;
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
            icon: Icon(
              Icons.arrow_back,
              color: Color(0xFF499D95),
            )),
        title: Text(
          'Select Bus',
          style: TextStyle(
            color: Color(0xFF499D95),
          ),
        ),
      ),
      backgroundColor: Color(0xFF138675),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
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
                        margin: EdgeInsets.only(right: 25, left: 35),
                        child: Text(
                          fromLocationAll.toString(),
                          style: TextStyle(
                            color: Color(0xFF499D95),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10, right: 25, left: 35),
                        child: Text(
                          toLocationAll.toString(),
                          style: TextStyle(
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
              child: ListView.builder(
                itemCount: requiredBusItem.length,
                itemBuilder: (context, index) {
                  return BusItem(
                    busId: requiredBusItem[index].busId +
                        index.toString() +
                        requiredBusItem.length.toString(),
                    from: requiredBusItem[index].from,
                    depart: requiredBusItem[index].depart,
                    to: requiredBusItem[index].to,
                    maxSeats: maxPassengerAll,
                    price: requiredBusItem[index].price,
                    arrive: requiredBusItem[index].arrive,
                  );
                },
              ),
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
    return  GestureDetector(
      onTap: () {
        selectedSeat.clear();
        setState(() {
          isSelected[selectedIndex] = false;
          selectedIndex = index;
          isSelected[selectedIndex] = true;
          formatSelectedDate(
              selectedDateAll.add(Duration(days: index)));
        });
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: isSelected[index] ? Color(0xFF499D95) : Colors.white,
        elevation: 10,
        margin: EdgeInsets.only(top: 10, left: 12, bottom: 20, right: 12),
        child: Container(
          height: 60,
          width: 70,
          alignment: Alignment.center,
          child: Text(
            formatDate(depart),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: !isSelected[index]
                  ? Color(0xFF499D95)
                  : Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  ;
  }
}
