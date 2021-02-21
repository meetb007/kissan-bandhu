import 'package:flutter/material.dart';
import 'package:frontend/Screens/Welcome/welcome_screen.dart';

class Logout extends StatefulWidget {
  @override
  _LogoutState createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WelcomeScreen(),
    );
  }
}
