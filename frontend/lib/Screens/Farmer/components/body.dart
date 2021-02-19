import 'package:flutter/material.dart';
import 'package:frontend/Screens/Farmer/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:frontend/Screens/Login/components/background.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatelessWidget with NavigationStates {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    getToken();
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

  void getToken() async{
    SharedPreferences storage = await SharedPreferences.getInstance();
    print(storage.getString("token"));
  }
}
