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

// class Body extends StatelessWidget {
//   // Body() {
//   //   get_location();
//   // }

//   // void get_location() async {
//   //   Position position = await Geolocator.getCurrentPosition(
//   //       desiredAccuracy: LocationAccuracy.high);
//   //   log('data: ${position.latitude.toString()}');
//   // }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     //get_location();
//     return Background(
//       child: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               "SIGNUP",
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: size.height * 0.03),
//             SvgPicture.asset(
//               "assets/icons/signup.svg",
//               height: size.height * 0.35,
//             ),
//             RoundedInputField(
//               hintText: "Name",
//               onChanged: (value) {},
//             ),
//             RoundedInputField(
//               hintText: "Mobile Number",
//               onChanged: (value) {},
//             ),
//             RoundedInputField(
//               hintText: "Address",
//               onChanged: (value) {},
//             ),
//             RoundedPasswordField(
//               onChanged: (value) {},
//             ),
//             RoundedButton(
//               text: "SIGNUP",
//               press: () {},
//             ),
//             SizedBox(height: size.height * 0.03),
//             AlreadyHaveAnAccountCheck(
//               login: false,
//               press: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) {
//                       return LoginScreen();
//                     },
//                   ),
//                 );
//               },
//             ),
//             OrDivider(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 SocialIcon(
//                   iconSrc: "assets/icons/facebook.svg",
//                   press: () {},
//                 ),
//                 SocialIcon(
//                   iconSrc: "assets/icons/twitter.svg",
//                   press: () {},
//                 ),
//                 SocialIcon(
//                   iconSrc: "assets/icons/google-plus.svg",
//                   press: () {},
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

class BodyFarmer extends StatefulWidget {
  BodyFarmer({Key key}) : super(key: key);

  @override
  _BodyFarmerState createState() => _BodyFarmerState();
}

class _BodyFarmerState extends State<BodyFarmer> {
  String name = "", address = "", latitude = "", longitude = "", mobile = "", password = "";
  @override
  Widget build(BuildContext context) {
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
            RoleButton(),
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
    print(farmer_register);
    print(role);

    if (role == "Farmer") {
      url = farmer_register;
    } else if (role == "Buyer") {
      url = buyer_register;
    }
    else{
      url = driver_register;
    }

    var response = await http.post(url, body: {
      'name': name,
      'address': address,
      'mobile': mobile,
      'latitude': latitude,
      'longitude': longitude,
      'password': password
    });
    print(response.statusCode);
    var res = jsonDecode(response.body);
    print(res);
    var status = res["statusCode"];
    if(status == 200){
      Toast.show(res["message"], context, duration : Toast.LENGTH_SHORT);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return LoginScreen();
          },
        ),
      );
    }
    else{
     Toast.show("Error in signup", context, duration : Toast.LENGTH_LONG);
    }
  }
}