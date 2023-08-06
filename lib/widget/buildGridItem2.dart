
import 'package:flutter/material.dart';
import '../main.dart';
import '../screen/selectseat.dart';

class BuildGridItem2 extends StatefulWidget {
  const BuildGridItem2({super.key, required this.index});
  final int index;

  @override
  State<BuildGridItem2> createState() => _BuildGridItem2State();
}

class _BuildGridItem2State extends State<BuildGridItem2> {
   int newIndex = 0;

  @override
  initState() {
    super.initState();
   newIndex = ((widget().index ~/ 2) * 5) + (widget().index % 2) + 4;
    setTrueIndices();
  }

  void setTrueIndices() {
     for (int i = 0; i < isBooked2.length; i++) {
      if (trueIndices2.contains(i)) {
        isBooked2[i] = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isBooked2[widget().index] == true) {
          } else if (selected == maxPassengerAll) {
            if (isSelected2[widget().index]) {
              selected--;
              isSelected2[widget().index] = !isSelected2[widget().index];
            }
          } else {
            if (isSelected2[widget().index]) {
              selected--;
            } else {
              selected++;
            }
            isSelected2[widget().index] = !isSelected2[widget().index];
          }
        });
      },
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          color: !isBooked2[widget().index]
              ? (isSelected2[widget().index] ? Color(0xFF499D95) : Colors.white)
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
