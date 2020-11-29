import 'package:flutter/material.dart';
import 'package:frontend/Screens/Signup/components/body.dart';
import 'package:frontend/Screens/Signup/components/body_farmer.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyFarmer(),
    );
  }
}
