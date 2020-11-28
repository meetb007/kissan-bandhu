import 'package:flutter/material.dart';
import '../bloc.navigation_bloc/navigation_bloc.dart';

 class Track extends StatelessWidget with NavigationStates {
  const Track({
    Key key
  }) : super(key: key);

 @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Track Page",
        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),
      ),
    );
  }
}