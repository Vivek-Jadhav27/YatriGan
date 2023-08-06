import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:yatrigan/component/details.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference databaseReference = FirebaseDatabase.instance.ref("Buses");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF138675),
      ),
      body: WillPopScope(
        onWillPop: () async {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Are you sure?'),
              content: Text('Do you want to exit the app?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('No'),
                ),
                TextButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => exit(0))),
                  child: Text('Yes'),
                ),
              ],
            ),
          );
          return false;
        },
        child: Stack(
          children: <Widget>[
            Container(
              height: 350.0,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(45.0),
                    bottomRight: Radius.circular(45.0)),
                color: Color(0xFF138675),
              ),
            ),
            Details(),
          ],
        ),
      ),
    );
  }
}
