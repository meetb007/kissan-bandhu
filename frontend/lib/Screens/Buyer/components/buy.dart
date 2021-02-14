import 'package:flutter/material.dart';
import 'package:frontend/Screens/Buyer/components/categories.dart';
//import 'package:frontend/Screens/Buyer/components/discount_banner.dart';
import 'package:frontend/Screens/Buyer/components/home_header.dart';
import 'package:frontend/Screens/Buyer/components/popular_product.dart';
import 'package:frontend/Screens/Buyer/components/special_offers.dart';
import '../../../constants.dart';
import 'package:frontend/Screens/Buyer/bloc.navigation_bloc/navigation_bloc.dart';

class Buy extends StatefulWidget with NavigationStates {
  @override
  _BuyState createState() => _BuyState();
}

class _BuyState extends State<Buy> {
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(20,context)),
            // SizedBox(height: size.height * 0.02),
            HomeHeader(),
            SizedBox(height: getProportionateScreenWidth(10,context)),
            // SizedBox(height: size.height * 0.01),
            //DiscountBanner(),
            Categories(),
            SpecialOffers(),
            SizedBox(height: getProportionateScreenWidth(30,context)),
            // SizedBox(height: size.height * 0.03),
            PopularProducts(),
            SizedBox(height: getProportionateScreenWidth(30,context)),
            // SizedBox(height: size.height * 0.03),
          ],
        ),
      ),
    );
  }
}
