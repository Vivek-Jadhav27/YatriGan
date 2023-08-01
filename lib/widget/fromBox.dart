import 'package:flutter/material.dart';

import '../main.dart';

class FromBox extends StatefulWidget {
  const FromBox({super.key});

  @override
  State<FromBox> createState() => _FromBoxState();
}

class _FromBoxState extends State<FromBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 10, right: 25, bottom: 10, left: 25),
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 225, 238, 254),
          borderRadius: BorderRadius.circular(20),
        ),
        child: DropdownButton(
            isExpanded: true,
            hint: Text('From', style: TextStyle(fontFamily: "Hellix")),
            value: fromLocationAll,
            style: TextStyle(
                color: Colors.black54, fontSize: 16, fontFamily: "Hellix"),
            items: locations.map(buildMenuItem).toList(),
            onChanged: (value) {
              setState(() {
                fromLocationAll = value;
              });
            }));
  
  }
  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(item),
      );

}