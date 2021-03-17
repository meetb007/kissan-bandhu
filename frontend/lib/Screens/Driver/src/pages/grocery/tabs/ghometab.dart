import 'package:flutter/material.dart';
// import 'package:frontend/Screens/Login/components/background.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeTabView extends StatelessWidget{
  const HomeTabView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    getToken();
    // return Background(
    return Container(
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
