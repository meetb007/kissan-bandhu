// /**
//  * Author: Damodar Lohani
//  * profile: https://github.com/lohanidamodar
//   */

// import 'package:flutter/material.dart';
// import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
// import 'package:frontend/Screens/Buyer/core/presentation/res/assets.dart';
// import 'package:frontend/Screens/Buyer/src/pages/grocery/gwidgets/glistitem3.dart';

// class GroceryDetailsPage extends StatelessWidget {
//   @override
//     Widget build(BuildContext context) {
//       return Column(
//         children: <Widget>[
//           Expanded(
//             child: ListView(
//               padding: EdgeInsets.all(10.0),
//               children: <Widget>[
//                 GroceryListItemThree(
//                   image: pineapple,
//                   subtitle: "4 in a pack",
//                   title: "Pineapple",
//                 ),
//                 GroceryListItemThree(
//                   image: cabbage,
//                   subtitle: "1 kg",
//                   title: "cabbage",
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 10.0,),
//           // _buildTotals()
//         ],
//       );
//     }

//   Widget _buildTotals() {
//     return ClipPath(
//       clipper: OvalTopBorderClipper(),
//       child: Container(
//             height: 180,
//             decoration: BoxDecoration(
//               boxShadow: [
//                 BoxShadow(blurRadius: 5.0,color: Colors.grey.shade700,spreadRadius: 80.0),
//               ],
//               color: Colors.white,
//             ),
//             padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0, bottom: 10.0),
//             child: Column(
//               children: <Widget>[
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Text("Subtotal"),
//                     Text("Rs. 1500"),
//                   ],
//                 ),
//                 SizedBox(height: 10.0,),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Text("Delivery fee"),
//                     Text("Rs. 100"),
//                   ],
//                 ),
//                 SizedBox(height: 10.0,),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Text("Total"),
//                     Text("Rs. 1600"),
//                   ],
//                 ),
//                 SizedBox(height: 10.0,),
//                 RaisedButton(
//                   color: Colors.green,
//                   onPressed: (){},
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: <Widget>[
//                       Text("Continue to Checkout", style: TextStyle(color: Colors.white)),
//                       Text("Rs. 1600", style: TextStyle(color: Colors.white)),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//     );
//   }
// }

// /**
//  * Author: Damodar Lohani
//  * profile: https://github.com/lohanidamodar
//   */

import 'package:flutter/material.dart';
import 'package:frontend/Screens/Buyer/core/presentation/res/assets.dart';
import 'package:frontend/Screens/Buyer/src/pages/grocery/gwidgets/glistitem2.dart';
import 'package:frontend/Screens/Buyer/src/pages/grocery/gwidgets/gtypography.dart';
import 'package:frontend/Screens/Buyer/src/widgets/network_image.dart';

class GroceryDetailsPage extends StatelessWidget {
  static final String path = "lib/src/pages/grocery/gdetails.dart";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.green,
        title: Text("Details"),
      ),
      body: _buildPageContent(context),
    );
  }

  Widget _buildPageContent(context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView(
            children: <Widget>[
              _buildItemCard(context),
              Container(
                  padding: EdgeInsets.all(30.0),
                  child: GrocerySubtitle(
                      text:
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras scelerisque nibh ut eros suscipit, vel cursus dolor imperdiet. Proin volutpat ligula eget purus maximus tristique. Pellentesque ullamcorper libero vitae metus feugiat fringilla. Ut luctus neque sed tortor placerat, faucibus mollis risus ullamcorper. Cras at nunc et odio ultrices tempor et.")),
              // Container(
              //     padding: EdgeInsets.only(left: 20.0, bottom: 10.0),
              //     child: GroceryTitle(text: "Related Items")),
              // GroceryListItemTwo(
              //     title: "Broccoli", image: brocoli, subtitle: "1 kg"),
              // GroceryListItemTwo(
              //     title: "Cabbage", image: cabbage, subtitle: "1 kg"),
            ],
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                color: Colors.green,
                child: FlatButton(
                  color: Colors.green,
                  onPressed: () {},
                  child: Text("Add to Cart"),
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  Widget _buildItemCard(context) {
    return Stack(
      children: <Widget>[
        Card(
          margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.favorite_border),
                    )
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: PNetworkImage(
                    cabbage,
                    height: 200,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                GroceryTitle(text: "Local Cabbage"),
                SizedBox(
                  height: 5.0,
                ),
                GrocerySubtitle(text: "1 kg")
              ],
            ),
          ),
        ),
      ],
    );
  }
}
