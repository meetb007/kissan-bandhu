import 'package:flutter/material.dart';
import 'package:frontend/Screens/Login/login_screen.dart';
import 'package:frontend/Screens/Signup/components/background.dart';
import 'package:frontend/Screens/Signup/components/or_divider.dart';
import 'package:frontend/Screens/Signup/components/social_icon.dart';
import 'package:frontend/components/already_have_an_account_acheck.dart';
import 'package:frontend/components/role_button.dart';
import 'package:frontend/components/rounded_button.dart';
import 'package:frontend/components/rounded_input_field.dart';
import 'package:frontend/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  set password(String password) {}

  set address(String address) {}

  set mobile(String mobile) {}

  set name(String name) {}

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
            RoleButton(),
            RoundedButton(
              text: "SIGNUP",
              press: () {
                // SignUp();
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
}
