import 'dart:convert';
import 'package:frontend/components/role_button.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Screens/Login/login_screen.dart';
import 'package:frontend/Screens/Signup/components/background.dart';
import 'package:frontend/Screens/Signup/components/or_divider.dart';
import 'package:frontend/Screens/Signup/components/social_icon.dart';
import 'package:frontend/components/already_have_an_account_acheck.dart';
import 'package:frontend/components/rounded_button.dart';
import 'package:frontend/components/rounded_input_field.dart';
import 'package:frontend/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:frontend/url.dart';
import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
  Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String name = "",
      address = "",
      latitude = "",
      longitude = "",
      mobile = "",
      password = "",
      capacity = "";

  // ignore: non_constant_identifier_names
  String driver_licence = "";
  @override
  Widget build(BuildContext context) {
    // print(RoleButton.value);
    Size size = MediaQuery.of(context).size;
    //get_location();
    return Background(
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
              hintText: "Mobile Number",
              onChanged: (value) {
                this.mobile = value;
              },
            ),
            RoundedInputField(
              hintText: "Address",
              onChanged: (value) {
                this.address = value;
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                this.password = value;
              },
            ),
            RoleButton(fun1: fun1),
            RoleButton.value == "Transport"
                ? Column(
                    children: [
                      RoundedInputField(
                        hintText: "Capacity",
                        onChanged: (value) {
                          this.capacity = value;
                        },
                      ),
                      RoundedInputField(
                        hintText: "Driver Licence",
                        onChanged: (value) {
                          this.driver_licence = value;
                        },
                      ),
                    ],
                  )
                : Text(""),
            RoundedButton(
              text: "SIGNUP",
              press: () {
                SignUp();
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocialIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocialIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  press: () {},
                ),
                SocialIcon(
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void fun1() {
    setState(() {});
  }

  // ignore: non_constant_identifier_names
  void SignUp() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // print(
    //     position.latitude.toString() + "****" + position.longitude.toString());
    latitude = position.latitude.toString();
    longitude = position.longitude.toString();
    String role = RoleButton.value;
    String url = "";
    print(name +
        "***" +
        address +
        "**" +
        mobile +
        "**" +
        password +
        "**" +
        latitude +
        "**" +
        longitude);
    // print(farmer_register);
    print(role);
    var body;
    if (role == "Farmer") {
      url = farmer_register;
    } else if (role == "Buyer") {
      url = buyer_register;
    } else {
      url = driver_register;
    }

    if (role == "Transport") {
      body = {
        'name': name,
        'address': address,
        'mobile': mobile,
        'latitude': latitude,
        'longitude': longitude,
        'password': password,
        'capacity': capacity,
        'driverLicence': driver_licence
      };
    } else {
      body = {
        'name': name,
        'address': address,
        'mobile': mobile,
        'latitude': latitude,
        'longitude': longitude,
        'password': password
      };
    }

    var response = await http.post(url, body:body);
    print(response.statusCode);
    var res = jsonDecode(response.body);
    print(res);
    var status = res["statusCode"];
    if (status == 200) {
      Toast.show(res["message"], context, duration: Toast.LENGTH_SHORT);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return LoginScreen();
          },
        ),
      );
    } else {
      Toast.show("Error in signup", context, duration: Toast.LENGTH_LONG);
    }
  }
}
