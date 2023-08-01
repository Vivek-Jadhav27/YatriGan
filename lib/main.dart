import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ticketapp/screen/home.dart';

final locations = [
  'Ahmedabad',
  'Mumbai',
  'Surat',
  'Vadodara',
  'Rajkot',
  'Gandhinagar',
  'Bhavnagar',
  'Jamnagar',
];
List<String> personAll = [];
List<int> selectedSeat = [];
List<int> ageAll = [];
List<String> genderAll = [];
String emailAll = '';
String phoneAll = '';
String? fromLocationAll;
String? toLocationAll;
String? dateAll;
String? departAll;
String? arrivalAll;
String? busNameAll;
String? selectedDateAllString;
DateTime selectedDateAll = DateTime.now();
int priceAll = 0;
int maxPassengerAll = 1;
int totalfareAll = 0;
int resevationChargeAll = 0;
int tollTaxAll = 0;
int serviceTaxAll = 0;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
  
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return MaterialApp(
      title: 'MyApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}
