import 'package:flutter/material.dart';
import 'components/body.dart';
import 'components/body_farmer.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyFarmer(),
      //body: Body(),
    );
  }
}
