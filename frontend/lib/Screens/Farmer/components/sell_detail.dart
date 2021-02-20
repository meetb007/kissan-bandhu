import 'package:frontend/Screens/Farmer/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Screens/Farmer/components/sell.dart';
import 'package:frontend/Screens/Signup/components/background.dart';
import 'package:frontend/components/rounded_button.dart';
import 'package:frontend/components/rounded_input_field.dart';
import 'package:flutter_svg/svg.dart';

class SellDetail extends StatefulWidget with NavigationStates{
  SellDetail({Key key}) : super(key: key);

  @override
  _SellDetailState createState() => _SellDetailState();
}

class _SellDetailState extends State<SellDetail> {
  String name = "",
      address = "",
      quality = "";

  int quantity,cost;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //get_location();
    return Scaffold(
    body: Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
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
              hintText: "Cost",
              onChanged: (value) {
                this.cost = int.parse(value);
              },
            ),
            RoundedInputField(
              hintText: "Quality",
              onChanged: (value) {
                this.quality = value;
              },
            ),
            RoundedButton(
              text: "Submit",
              press: () {
                Submit();
              },
            ),
            RoundedButton(
              text: "Cancel",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Sell();
                    },
                  ),
                );
              },
            ),
            SizedBox(height: size.height * 0.03),
          ],
        ),
      ),
    )
    );
  }

  // ignore: non_constant_identifier_names
  void Submit() async {
    print("success");
  }
}
