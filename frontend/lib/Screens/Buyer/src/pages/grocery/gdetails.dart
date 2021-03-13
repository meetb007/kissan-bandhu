import 'package:flutter/material.dart';
import 'package:frontend/Screens/Buyer/core/presentation/res/assets.dart';
import 'package:frontend/Screens/Buyer/src/pages/grocery/gwidgets/glistitem2.dart';
import 'package:frontend/Screens/Buyer/src/pages/grocery/gwidgets/gtypography.dart';
import 'package:frontend/Screens/Buyer/src/widgets/network_image.dart';
import 'package:frontend/Screens/Buyer/src/pages/grocery/gdetails_individual.dart';

class GroceryDetailsPage extends StatefulWidget {
  final String product;
  const GroceryDetailsPage({Key key, this.product}) : super(key: key);

  @override
  _GroceryDetailsPageState createState() =>
      _GroceryDetailsPageState(product: product);
}

class _GroceryDetailsPageState extends State<GroceryDetailsPage> {
  // static final String path = "lib/src/pages/grocery/gdetails.dart";
  final String product;
  _GroceryDetailsPageState({this.product});

  @override
  Widget build(BuildContext context) {
    // print(product);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xFF6F35A5),
        title: Text("List of "+product),
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
              // _buildItemCard(context, product),
              GroceryListItemTwo(
                title: "Broccoli",
                image: brocoli,
                subtitle: "1 kg",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return GroceryIndividualPage(product: "Broccoli");
                      },
                    ),
                  );
                },
              ),
              GroceryListItemTwo(
                title: "Cabbage",
                image: brocoli,
                subtitle: "1 kg",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return GroceryIndividualPage(product: "Cabbage");
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        // Row(
        //   children: <Widget>[
        //     Expanded(
        //       child: Container(
        //         color: Colors.green,
        //         child: FlatButton(
        //           color: Colors.green,
        //           onPressed: () {},
        //           child: Text("Add to Cart"),
        //         ),
        //       ),
        //     )
        //   ],
        // )
      ],
    );
  }

  Widget _buildItemCard(context, String product) {
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
                GroceryTitle(text: product),
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
