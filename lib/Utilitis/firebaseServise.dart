
import 'package:firebase_database/firebase_database.dart';
import 'package:yatrigan/screen/selectseat.dart';
import '../main.dart';
import '../screen/buses.dart';

class FirebaseService {
  void addBookedSeat() async {
    selectedSeat.addAll(bookingseat);
    DatabaseReference ref = FirebaseDatabase.instance.ref('Buses');
    for (int i = 0; i < selectedSeat.length; i++) {
      await ref
          .child('${fromLocationAll}To$toLocationAll')
          .child(
              '${newSelectedDate.day}-${newSelectedDate.month}-${newSelectedDate.year}')
          .child('$busNameAll')
          .child('BookedSeat')
          .set(
            selectedSeat,
          );
    }
  }

  void addTicket(String ticketId) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref('Tickets');
    await ref.child(ticketId).child('BusDetails').set({
      'BusId': busNameAll,
      'From': fromLocationAll,
      'To': toLocationAll,
      'Depart': departAll,
      'Arrival': arrivalAll,
      'Price': priceAll,
      'Date': selectedDateAllString,
    });
    for (int i = 0; i < selectedSeat.length; i++) {
      await ref.child(ticketId).child('PassengerDetails')
      .child('${i+1}').
      set({
        'Name': personAll[i],
        'Age' : ageAll[i],
        'Gender' : genderAll[i],
        'Phone' : phoneAll,
        'Email' : emailAll,
        'Seat' : selectedSeat[i],
      });
    }
  }

  
}

