import 'package:flutter/material.dart';

/// This is the stateful widget that the main application instantiates.
class RoleButton extends StatefulWidget {
  RoleButton({Key key}) : super(key: key);
  static String value;

  @override
  _RoleButtonState createState() => _RoleButtonState();
}

/// This is the private State class that goes with RoleButton.
class _RoleButtonState extends State<RoleButton> {
  String dropdownValue = 'Farmer';

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
        setState(() {
          dropdownValue = newValue;
          RoleButton.value = newValue;
        });
      },
      items: <String>['Buyer', 'Farmer', 'Transport']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
