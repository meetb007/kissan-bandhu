import 'package:flutter/material.dart';

/// This is the stateful widget that the main application instantiates.
// ignore: must_be_immutable
class RoleButton extends StatefulWidget {
  var fun1;

  RoleButton({Key key, this.fun1}) : super(key: key);
  static String value = 'Farmer';

  @override
  _RoleButtonState createState() => _RoleButtonState(fun1);
}

/// This is the private State class that goes with RoleButton.
class _RoleButtonState extends State<RoleButton> {
  _RoleButtonState(var fun1) {
    this.fun1 = fun1;
  }
  // String dropdownValue = 'Farmer';
  var fun1;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: RoleButton.value,
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
          // dropdownValue = newValue;
          RoleButton.value = newValue;
          fun1();
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
