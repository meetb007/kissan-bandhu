import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF6F35A5);
const kPrimaryLightColor = Color(0xFFF1E6FF);
const kSideBarColor = Color(0xFFA884DA);
const kTextColor = Color(0xFF757575);
const kSecondaryColor = Color(0xFF979797);
// const kSideBarColor = Color(0xFFF1E6FF);

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth = 0;
  static double screenHeight = 0;
  static double defaultSize = 0;
  static Orientation orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;
    orientation = _mediaQueryData.orientation;
  }
}

// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight,BuildContext context) {
  //MediaQueryData _mediaQueryData = MediaQuery.of(context);
  Size size = MediaQuery.of(context).size;
  double screenHeight = size.height;
  //Orientation orientation = _mediaQueryData.orientation;
  // 812 is the layout height that designer use
  return (inputHeight / 812.0) * screenHeight;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth,BuildContext context) {
  //MediaQueryData _mediaQueryData = MediaQuery.of(context);
  Size size = MediaQuery.of(context).size;
  double screenWidth = size.width;
  //Orientation orientation = _mediaQueryData.orientation;
  // 375 is the layout width that designer use
  return (inputWidth / 375.0) * screenWidth;
}
