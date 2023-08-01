import 'package:flutter/material.dart';
import '../main.dart';

class PassengerCard extends StatefulWidget {
  const PassengerCard({super.key, required this.context, required this.index});
  final BuildContext context;
  final int index;

  @override
  State<PassengerCard> createState() => _PassengerCardState();
}

class _PassengerCardState extends State<PassengerCard> {
  final List<TextEditingController> _nametextEditingController = [];
  final List<TextEditingController> _agetextEditingController = [];
  final List<TextEditingController> _gendertextEditingController = [];


  @override
  void initState() {
    super.initState();
    personAll = List<String>.filled(maxPassengerAll , '');
    ageAll = List<int>.filled(maxPassengerAll, 0);
    genderAll = List<String>.filled(maxPassengerAll, '');
    for (int i = 0; i < maxPassengerAll; i++) {
      _nametextEditingController.add(TextEditingController());
      _agetextEditingController.add(TextEditingController());
      _gendertextEditingController.add(TextEditingController());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextField(
            controller: _nametextEditingController[widget().index],
            decoration: InputDecoration(
              hintText: 'Passenger Name',
              hintStyle: TextStyle(color: Colors.grey),
              icon: Icon(
                Icons.person,
                color: Color(0xFF499D95),
              ),
            ),
            onChanged: (value) {
              setState(() {
                if (value.isEmpty) {
                  personAll[widget().index] = '';
                } else {
                  personAll[widget().index] = value;
                }
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 120,
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _agetextEditingController[widget().index],
                  onChanged: (value) {
                    setState(() {
                      if (value.isEmpty) {
                        ageAll[widget().index] = 0;
                      } else {
                        ageAll[widget().index] = int.parse(value);
                      }
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Age',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              Container(
                width: 120,
                child: TextField(
                  controller: _gendertextEditingController[widget().index],
                  onChanged: (value) {
                    setState(() {
                      if (value.isEmpty) {
                        genderAll[widget().index] = '';
                      } else {
                        genderAll[widget().index] = value;
                      }
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Male',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
