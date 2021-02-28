import 'package:flutter/material.dart';
import '../components/text_field_container.dart';
import '../constants.dart';

class ReadRoundedInputField extends StatelessWidget {
  final String hintText,text;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const ReadRoundedInputField({
    Key key,
    this.hintText,
    this.text,
    this.icon = Icons.person,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //print("rounded input text button"+this.text);
    return TextFieldContainer(
      child: TextFormField(
        onChanged: onChanged,
        enabled: false,
        cursorColor: kPrimaryColor,
        initialValue: this.text,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
