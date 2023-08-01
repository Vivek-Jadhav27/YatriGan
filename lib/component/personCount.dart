import 'package:flutter/material.dart';

import '../main.dart';

class PersonCount extends StatefulWidget {
  const PersonCount({super.key});

  @override
  State<PersonCount> createState() => _PersonCountState();
}

class _PersonCountState extends State<PersonCount> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 100,
        height: 40,
        margin: EdgeInsets.only(left: 30, right: 30),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(255, 225, 238, 254),
        ),
        child: TextField(
          onChanged: (value) {
            setState(() {
              maxPassengerAll = int.parse(value);
            });
          },
          keyboardType: TextInputType.number,
          textAlignVertical: TextAlignVertical.center,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintText: '$maxPassengerAll Person',
            hintStyle: TextStyle(fontFamily: "Hellix"),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  
  }
}