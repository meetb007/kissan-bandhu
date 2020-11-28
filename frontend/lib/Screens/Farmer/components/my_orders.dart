import 'package:flutter/material.dart';
import '../bloc.navigation_bloc/navigation_bloc.dart';

 class MyOrders extends StatelessWidget with NavigationStates{
  const MyOrders({
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "My Orders",
        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),
      ),
    );
  }
}