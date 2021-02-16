import 'package:flutter/material.dart';

/// This is the stateful widget that the main application instantiates.
class RoleButton extends StatefulWidget {
  RoleButton({Key key}) : super(key: key);

  @override
  _RoleButtonState createState() => _RoleButtonState();
}

/// This is the private State class that goes with RoleButton.
class _RoleButtonState extends State<RoleButton> {
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
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>['Select your Role','Buyer', 'Farmer', 'Transport']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
