import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//import 'package:frontend/Screens/Login/components/body.dart';
//import 'package:frontend/Screens/Farmer/components/background.dart';
import 'package:frontend/Screens/Farmer/sidebar/sidebar_layout.dart';
// import 'package:frontend/components/rounded_button.dart';
// import 'package:frontend/Screens/Farmer/components/my_orders.dart';
// import 'package:frontend/Screens/Farmer/components/profile.dart';
// import 'package:frontend/Screens/Farmer/components/sell.dart';
// import 'package:frontend/Screens/Farmer/components/track.dart';
// import 'package:flutter_svg/svg.dart';

class MainScreen extends StatelessWidget{
    Widget build(BuildContext context) {
    return Scaffold(
      body: SideBarLayout(),
    );
  }
}
// class MainScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     //body: Body(),
//     Size size = MediaQuery.of(context).size;
//     return Background(
//       child: SingleChildScrollView(
//         child: Column(
//           //mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             SizedBox(height: size.height * 0.03),
//             // SvgPicture.asset(
//             //   "assets/icons/login.svg",
//             //   height: size.height * 0.2,
//             // ),
//             SizedBox(height: size.height * 0.03),
//             makeDashboardItemProfile("Profile", Icons.account_box, context),
//             makeDashboardItemHistory("History", Icons.list, context),
//             makeDashboardItemSell("Sell", Icons.shopping_cart, context),
//             makeDashboardItemTrack("Track", Icons.local_shipping, context),
//           ],
//         ),
//       ),
//     );
//   }
// }

// Card makeDashboardItemProfile(String title, IconData icon, BuildContext context) {
//   return Card(
//       elevation: 1.0,
//       margin: new EdgeInsets.all(8.0),
//       child: Container(
//         decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
//         child: new InkWell(
//           onTap: () {},
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisSize: MainAxisSize.min,
//               verticalDirection: VerticalDirection.down,
//               children: <Widget>[
//                 SizedBox(height: 40.0),
//                 Center(
//                     child: Icon(
//                   icon,
//                   size: 40.0,
//                   color: Colors.black,
//                 )),
//                 new Center(
//                     child: RoundedButton(
//                   text: "Profile",
//                   press: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) {
//                           return Profile();
//                         },
//                       ),
//                     );
//                   },
//                 )),
//               ],
//             ),
//           ),
//         ),
//       ));
// }

// Card makeDashboardItemHistory(String title, IconData icon, BuildContext context) {
//   return Card(
//       elevation: 1.0,
//       margin: new EdgeInsets.all(8.0),
//       child: Container(
//         decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
//         child: new InkWell(
//           onTap: () {},
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisSize: MainAxisSize.min,
//               verticalDirection: VerticalDirection.down,
//               children: <Widget>[
//                 SizedBox(height: 40.0),
//                 Center(
//                     child: Icon(
//                   icon,
//                   size: 40.0,
//                   color: Colors.black,
//                 )),
//                 new Center(
//                     child: RoundedButton(
//                   text: "My Orders",
//                   press: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) {
//                           return MyOrders();
//                         },
//                       ),
//                     );
//                   },
//                 )),
//               ],
//             ),
//           ),
//         ),
//       ));
// }

// Card makeDashboardItemSell(String title, IconData icon, BuildContext context) {
//   return Card(
//       elevation: 1.0,
//       margin: new EdgeInsets.all(8.0),
//       child: Container(
//         decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
//         child: new InkWell(
//           onTap: () {},
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisSize: MainAxisSize.min,
//               verticalDirection: VerticalDirection.down,
//               children: <Widget>[
//                 SizedBox(height: 40.0),
//                 Center(
//                     child: Icon(
//                   icon,
//                   size: 40.0,
//                   color: Colors.black,
//                 )),
//                 new Center(
//                     child: RoundedButton(
//                   text: "Sell",
//                   press: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) {
//                           return Sell();
//                         },
//                       ),
//                     );
//                   },
//                 )),
//               ],
//             ),
//           ),
//         ),
//       ));
// }

// Card makeDashboardItemTrack(String title, IconData icon, BuildContext context) {
//   return Card(
//       elevation: 1.0,
//       margin: new EdgeInsets.all(8.0),
//       child: Container(
//         decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
//         child: new InkWell(
//           onTap: () {},
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisSize: MainAxisSize.min,
//               verticalDirection: VerticalDirection.down,
//               children: <Widget>[
//                 SizedBox(height: 40.0),
//                 Center(
//                     child: Icon(
//                   icon,
//                   size: 40.0,
//                   color: Colors.black,
//                 )),
//                 new Center(
//                     child: RoundedButton(
//                   text: "Track",
//                   press: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) {
//                           return Track();
//                         },
//                       ),
//                     );
//                   },
//                 )),
//               ],
//             ),
//           ),
//         ),
//       ));
// }
