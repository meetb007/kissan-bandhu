import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/Screens/Driver/src/pages/grocery/ghome.dart';
import 'package:frontend/Screens/Farmer/src/pages/grocery/ghome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend/Screens/Buyer/src/pages/grocery/ghome.dart';
import 'package:frontend/Screens/Login/components/background.dart';
import 'package:frontend/Screens/Signup/signup_screen.dart';
import 'package:frontend/components/already_have_an_account_acheck.dart';
import 'package:frontend/components/rounded_button.dart';
import 'package:frontend/components/rounded_input_field.dart';
import 'package:frontend/components/rounded_password_field.dart';
import 'package:toast/toast.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/url.dart';
import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String mobile, password;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Mobile number",
              onChanged: (value) {
                this.mobile = value;
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                this.password = value;
              },
            ),
            RoundedButton(
              text: "LOGIN",
              press: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) {
                //       return SideBarLayout();
                //     },
                //   ),
                // );
                login();
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void login() async {
    //  if (mobile.length != 10) {
    //   Toast.show("Pls enter correct mobile number of length 10", context,
    //       duration: Toast.LENGTH_LONG);
    //   return;
    // }
    // if (password.length < 7) {
    //   Toast.show("Pls enter valid password of length greater than 7", context,
    //       duration: Toast.LENGTH_LONG);
    //   return;
    // }
    var response = await http
        .post(login_url, body: {'mobile': mobile, 'password': password});

    print(response.statusCode);
    var res = jsonDecode(response.body);
    print(res);
    var status = res["statusCode"];
    if (status == 200) {
      String role = res["role"];
      print(role);
      SharedPreferences storage = await SharedPreferences.getInstance();
      await storage.setString("token", res["token"]);
      if (role == "farmer") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return FarmerHomePage();
            },
          ),
        );
      } else if (role == "buyer") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              // return BuyerSideBarLayout();
              return GroceryHomePage();
            },
          ),
        );
      } else if (role == "driver") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return DriverHomePage();
            },
          ),
        );
      } else {
        Toast.show("User not found", context,
          duration: Toast.LENGTH_LONG);
      }
    } else {
      Toast.show("User not found", context,
          duration: Toast.LENGTH_LONG);
    }
  }
}