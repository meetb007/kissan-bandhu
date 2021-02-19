import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:frontend/Screens/Driver/components/profile_animations/animations.dart';
import 'package:frontend/Screens/Driver/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:frontend/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/url.dart';

class Profile extends StatefulWidget with NavigationStates {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool getData = false;
  var profileData;
  _ProfileState() {
    getProfile();
  }

  final Color color = kPrimaryLightColor;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    if (!getData) {
      return Text("no profile fetch");
    }
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(20, 9, 50, 1),
                Color.fromRGBO(150, 95, 171, 0.5),
              ],
              begin: FractionalOffset.bottomCenter,
              end: FractionalOffset.topCenter,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 73),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Icon(
                      //   AntDesign.arrowleft,
                      //   color: Colors.white,
                      // ),
                      // Icon(
                      //   AntDesign.logout,
                      //   color: Colors.white,
                      // ),
                    ],
                  ),
                  Text(
                    'My\nProfile',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontFamily: 'Nisebuschgardens',
                    ),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Container(
                    height: height * 0.43,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double innerHeight = constraints.maxHeight;
                        double innerWidth = constraints.maxWidth;
                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: innerHeight * 0.72,
                                width: innerWidth,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 80,
                                    ),
                                    Text(
                                      profileData["name"],
                                      style: TextStyle(
                                        color: Color.fromRGBO(39, 105, 171, 1),
                                        fontFamily: 'Nunito',
                                        fontSize: 37,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              'Orders',
                                              style: TextStyle(
                                                color: Colors.grey[700],
                                                fontFamily: 'Nunito',
                                                fontSize: 25,
                                              ),
                                            ),
                                            Text(
                                              '10',
                                              style: TextStyle(
                                                color: Color.fromRGBO(
                                                    39, 105, 171, 1),
                                                fontFamily: 'Nunito',
                                                fontSize: 25,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 25,
                                            vertical: 8,
                                          ),
                                          child: Container(
                                            height: 50,
                                            width: 3,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              'Pending',
                                              style: TextStyle(
                                                color: Colors.grey[700],
                                                fontFamily: 'Nunito',
                                                fontSize: 25,
                                              ),
                                            ),
                                            Text(
                                              '1',
                                              style: TextStyle(
                                                color: Color.fromRGBO(
                                                    39, 105, 171, 1),
                                                fontFamily: 'Nunito',
                                                fontSize: 25,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: Container(
                                  child: Image.asset(
                                    'assets/images/profile.png',
                                    width: innerWidth * 0.45,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: height * 0.5,
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'My Details',
                              style: TextStyle(
                                color: Color.fromRGBO(39, 105, 171, 1),
                                fontSize: 27,
                                fontFamily: 'Nunito',
                              ),
                            ),
                            Divider(
                              thickness: 2.5,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            FadeAnimation(
                                1.6,
                                Text(
                                  "Mobile Number",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            FadeAnimation(
                                1.6,
                                Text(
                                  profileData["mobile"],
                                  style: TextStyle(color: Colors.black),
                                )),
                            SizedBox(
                              height: 20,
                            ),
                            FadeAnimation(
                                1.6,
                                Text(
                                  "Address",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            FadeAnimation(
                                1.6,
                                Text(
                                  profileData["address"].toString().toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      height: 2,
                                      fontWeight: FontWeight.bold),
                                )),
                                SizedBox(
                              height: 10,
                            ),
                            Positioned.fill(
                              bottom: 50,
                              child: Container(
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: FadeAnimation(
                                    2,
                                    Container(
                                      margin: EdgeInsets.symmetric(horizontal: 30),
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(50),
                                          color: Colors.deepPurple),
                                      child: Align(
                                          child: Text(
                                        "Edit Profile",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        // Positioned.fill(
        //   bottom: 50,
        //   child: Container(
        //     child: Align(
        //       alignment: Alignment.bottomCenter,
        //       child: FadeAnimation(
        //         2,
        //         Container(
        //           margin: EdgeInsets.symmetric(horizontal: 30),
        //           height: 50,
        //           decoration: BoxDecoration(
        //               borderRadius: BorderRadius.circular(50),
        //               color: Colors.deepPurple),
        //           child: Align(
        //               child: Text(
        //             "Edit Profile",
        //             style: TextStyle(color: Colors.white),
        //           )),
        //         ),
        //       ),
        //     ),
        //   ),
        // )
      ],
    );
  }

  void getProfile() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    print(storage.getString("token"));
    String token = storage.getString("token");
    var response = await http.get(
      driver_profile,
      headers: {HttpHeaders.authorizationHeader: token},
    );
    print(response.statusCode);
    var res = jsonDecode(response.body);
    print(res);
    profileData = res["response"];
    setState(() {
      getData = true;
    });
    print(profileData);
  }
}
