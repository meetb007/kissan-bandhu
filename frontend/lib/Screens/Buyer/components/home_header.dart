import 'package:flutter/material.dart';
import 'package:frontend/Screens/Buyer/bloc.navigation_bloc/navigation_bloc.dart';
// import 'package:frontend/Screens/Buyer/cart/cart_screen.dart';
import '../../../constants.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class HomeHeader extends StatelessWidget with NavigationStates {
  const HomeHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenHeight(50.0, context),
          horizontal: getProportionateScreenWidth(75.0, context)),
      //EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(75.0,context)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SearchField(),
          SizedBox(
            width: 120,
          ),
          IconBtnWithCounter(
            svgSrc: "assets/icons/Cart Icon.svg",
            // press: () => Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) {
            //       return CartScreen();
            //     }
            //   ),
            // ),
            press: () {},
          ),
          IconBtnWithCounter(
            svgSrc: "assets/icons/Bell.svg",
            numOfitem: 1,
            press: () {},
          ),
        ],
      ),
    );
  }
}
