import 'package:flutter/material.dart';
import 'package:frontend/Screens/Buyer/bloc.navigation_bloc/navigation_bloc.dart';

class Buy extends StatefulWidget with NavigationStates {
  @override
  _BuyState createState() => _BuyState();
}

class _BuyState extends State<Buy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("INDHOLD"),
        elevation: .1,
        backgroundColor: Color.fromRGBO(49, 87, 110, 1.0),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
        child: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(3.0),
          children: <Widget>[
            makeBuyItem("Ordbog", Icons.book),
            makeBuyItem("Alphabet", Icons.alarm),
            makeBuyItem("Alphabet", Icons.alarm),
            makeBuyItem("Alphabet", Icons.alarm),
            makeBuyItem("Alphabet", Icons.alarm),
            makeBuyItem("Alphabet", Icons.alarm)
          ],
        ),
      ),
    );
  }

  Card makeBuyItem(String title, IconData icon) {
    return Card(
        elevation: 1.0,
        margin: new EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
          child: new InkWell(
            onTap: () {},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                SizedBox(height: 50.0),
                Center(
                    child: Icon(
                  icon,
                  size: 40.0,
                  color: Colors.black,
                )),
                SizedBox(height: 20.0),
                new Center(
                  child: new Text(title,
                      style:
                          new TextStyle(fontSize: 18.0, color: Colors.black)),
                )
              ],
            ),
          ),
        ));
  }
}


// import 'package:flutter/material.dart';
// import 'package:frontend/Screens/Buyer/components/categories.dart';
// //import 'package:frontend/Screens/Buyer/components/discount_banner.dart';
// import 'package:frontend/Screens/Buyer/components/home_header.dart';
// import 'package:frontend/Screens/Buyer/components/popular_product.dart';
// import 'package:frontend/Screens/Buyer/components/special_offers.dart';
// import '../../../constants.dart';
// import 'package:frontend/Screens/Buyer/bloc.navigation_bloc/navigation_bloc.dart';

// class Buy extends StatefulWidget with NavigationStates {
//   @override
//   _BuyState createState() => _BuyState();
// }

// class _BuyState extends State<Buy> {
//   @override
//   Widget build(BuildContext context) {
//     // Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(height: getProportionateScreenHeight(20,context)),
//             // SizedBox(height: size.height * 0.02),
//             HomeHeader(),
//             SizedBox(height: getProportionateScreenWidth(10,context)),
//             // SizedBox(height: size.height * 0.01),
//             //DiscountBanner(),
//             Categories(),
//             SpecialOffers(),
//             SizedBox(height: getProportionateScreenWidth(30,context)),
//             // SizedBox(height: size.height * 0.03),
//             PopularProducts(),
//             SizedBox(height: getProportionateScreenWidth(30,context)),
//             // SizedBox(height: size.height * 0.03),
//           ],
//         ),
//       ),
//     );
//   }
// }
