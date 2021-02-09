import 'package:flutter/material.dart';
import 'package:frontend/Screens/Farmer/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:frontend/Screens/Welcome/welcome_screen.dart';

class Logout extends StatelessWidget with NavigationStates{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WelcomeScreen(),
    );
  }
}
