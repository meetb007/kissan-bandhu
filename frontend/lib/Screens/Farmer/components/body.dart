import 'package:flutter/material.dart';
import 'package:frontend/Screens/Farmer/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:frontend/Screens/Login/components/background.dart';
//import 'package:get_storage/get_storage.dart';

class Body extends StatelessWidget with NavigationStates {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    //print(GetStorage().read("token"));
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Dashboard",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
