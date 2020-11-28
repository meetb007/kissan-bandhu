import 'package:flutter/material.dart';
import '../bloc.navigation_bloc/navigation_bloc.dart';

 class Sell extends StatelessWidget with NavigationStates{
  const Sell({
    Key key
  }) : super(key: key);

   @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Home / Sell Page",
        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),
      ),
    );
  }
}