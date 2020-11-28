import 'package:flutter/material.dart';
import '../bloc.navigation_bloc/navigation_bloc.dart';

 class Profile extends StatelessWidget with NavigationStates {
  const Profile({
    Key key
  }) : super(key: key);

   @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Profile Page",
        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),
      ),
    );
  }
}