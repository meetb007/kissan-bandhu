//Use this file for stateless widget of role button
import 'package:flutter/material.dart';
import '../constants.dart';

// ignore: must_be_immutable
class RoleButton extends StatelessWidget {
  final Color color, textColor;
  RoleButton({
    Key key,
    this.color = kPrimaryColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  String dropdownValue = 'Select your Role';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String newValue) {
        // setState(() {
        dropdownValue = newValue;
        // });
      },
      items: <String>['Select your Role', 'Buyer', 'Farmer', 'Transport']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: new Text(value),
        );
      }).toList(),
    );
  }
}
