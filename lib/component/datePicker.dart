import 'package:flutter/material.dart';

import '../main.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({super.key});

  @override
  State<DatePicker> createState() => _datePickerState();
}

class _datePickerState extends State<DatePicker> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDatePicker(
          context: context,
          initialDate: selectedDateAll,
          firstDate: DateTime.now(),
          lastDate: DateTime(2025),
        ).then((pickedDate) {
          if (pickedDate == null) {
            return;
          }
          setState(() {
            selectedDateAll = pickedDate;
          });
        });
      },
      child: Container(
        width: 100,
        height: 36,
        margin: EdgeInsets.only(left: 30, right: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(255, 225, 238, 254),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            selectedDateAll.day.toString() +
                '/' +
                selectedDateAll.month.toString() +
                '/' +
                selectedDateAll.year.toString(),
            style: TextStyle(
              color: Colors.black54,
              fontFamily: "Hellix",
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  
  }
}