import 'package:flutter/material.dart';
import 'package:frontend/Screens/Farmer/components/profile_animations/animations.dart';
import 'package:frontend/constants.dart';
import '../bloc.navigation_bloc/navigation_bloc.dart';

class Profile extends StatelessWidget with NavigationStates {
  const Profile({Key key}) : super(key: key);
  final Color color = kPrimaryLightColor;
  @override
  Widget build(BuildContext context) {
    // return Center(
    //   child: Text(
    //     "Profile Page",
    //     style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),
    //   ),
    // );
    return Scaffold(
      backgroundColor: color,
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                expandedHeight: 450,
                backgroundColor: color,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/download.png'),
                            fit: BoxFit.cover)),
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomRight,
                              colors: [
                            Colors.deepPurple[50],
                            Colors.black.withOpacity(.3)
                          ])),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            FadeAnimation(
                                1,
                                Text(
                                  "Farmer 1",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 40),
                                )),
                            // SizedBox(
                            //   height: 20,
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
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
                              "**********",
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
                              "Mumbai.",
                              style: TextStyle(
                                  color: Colors.black,
                                  //height: 1.4,
                                  fontWeight: FontWeight.bold),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  )
                ]),
              )
            ],
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
    );
  }
}
