import 'package:flutter/material.dart';
import '../main.dart';
import '../screen/selectseat.dart';

class BuildGridItems1 extends StatefulWidget {
  const BuildGridItems1({super.key, required this.index});
  final int index;

  @override
  State<BuildGridItems1> createState() => _BuildGridItem1State();
}

class _BuildGridItem1State extends State<BuildGridItems1> {
  
  int newIndex = 0;

  @override
  initState() {
    super.initState();
    newIndex = ((widget().index ~/ 3) * 5) + (widget().index % 3) + 1;
    setTrueIndices();
  }

  void setTrueIndices() {
    for (int i = 0; i < isBooked1.length; i++) {
      if (trueIndices1.contains(i)) {
        isBooked1[i] = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isBooked1[widget().index] == true) {
          } else if (selected == maxPassengerAll) {
            if (isSelected1[widget().index]) {
              selected--;
              isSelected1[widget().index] = !isSelected1[widget().index];
            }
          } else {
            if (isSelected1[widget().index]) {
              selected--;
            } else {
              selected++;
            }
            isSelected1[widget().index] = !isSelected1[widget().index];
          }
        });
      },
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          color: !isBooked1[widget().index]
              ? (isSelected1[widget().index] ? Color(0xFF499D95) : Colors.white)
              : Color(0xFF138675),
          border: Border.all(color: Color(0xFF138675), width: 2),
          borderRadius: BorderRadius.circular(5),
        ),
        margin: EdgeInsets.only(right: 10, top: 10),
        child: Center(
          child: Text(
            newIndex.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
