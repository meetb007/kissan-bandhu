import 'package:frontend/Screens/Farmer/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:frontend/components/role_button.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Screens/Signup/components/background.dart';
import 'package:frontend/components/rounded_button.dart';
import 'package:frontend/components/rounded_input_field.dart';

class SellDetail extends StatefulWidget with NavigationStates {
  SellDetail({Key key}) : super(key: key);

  @override
  _SellDetailState createState() => _SellDetailState();
}

class _SellDetailState extends State<SellDetail> {
  String name = "", address = "", quality = "";
  int quantity, cost;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.03),
            // SvgPicture.asset(
            //   "assets/icons/signup.svg",
            //   height: size.height * 0.35,
            // ),
            RoundedInputField(
              hintText: "Name",
              onChanged: (value) {
                this.name = value;
              },
            ),
            RoundedInputField(
              hintText: "Quantity",
              onChanged: (value) {
                this.quantity = int.parse(value);
              },
            ),
            RoundedInputField(
              hintText: "Address",
              onChanged: (value) {
                this.address = value;
              },
            ),
            RoundedInputField(
              hintText: "quality",
              onChanged: (value) {
                this.quality = value;
              },
            ),
            RoundedInputField(
              hintText: "cost",
              onChanged: (value) {
                this.cost = int.parse(value);
              },
            ),
            RoleButton(),
            RoundedButton(
              text: "Submit",
              press: () {
                Submit();
              },
            ),
            SizedBox(height: size.height * 0.03),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  void Submit() async {
    print("Submit successfully");
  }
}
