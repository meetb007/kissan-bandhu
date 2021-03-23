import 'package:flutter/material.dart';
import 'package:frontend/Screens/Buyer/src/pages/grocery/gwidgets/glistitem2.dart';
import 'package:frontend/Screens/Buyer/src/pages/grocery/tabs/gcurrentorder_list_individual.dart';
import 'package:frontend/url.dart';

// ignore: must_be_immutable
class CurrentOrderList extends StatefulWidget {
  var product;
  CurrentOrderList({Key key, this.product}) : super(key: key);

  @override
  _CurrentOrderListState createState() => _CurrentOrderListState(product);
}

class _CurrentOrderListState extends State<CurrentOrderList> {
  var jsonData;

  _CurrentOrderListState(var product) {
    this.jsonData = product;
  }

  @override
  Widget build(BuildContext context) {
    // print(product);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xFF6F35A5),
        title: Text("List of Items in your order"),
      ),
      body: _buildPageContent(context),
    );
  }

  Widget _buildPageContent(context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            child: ListView.builder(
              itemCount: jsonData.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return GroceryListItemTwo(
                  title: jsonData[index]['name'],
                  image: jsonData[index]['imageUrl'],
                  subtitle: jsonData[index]['quantity'],
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return CurrentOrderListIndividual(
                              product: jsonData[index]);
                        },
                      ),
                    );
                  },
                );
              },
            ),
            // child: ListView(
            //   children: <Widget>[
            // _buildItemCard(context, product),

            // GroceryListItemTwo(
            //   title: "Broccoli",
            //   image: brocoli,
            //   subtitle: "1 kg",
            //   press: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) {
            //           return GroceryIndividualPage(product: "Broccoli");
            //         },
            //       ),
            //     );
            //   },
            // ),
            // GroceryListItemTwo(
            //   title: "Cabbage",
            //   image: brocoli,
            //   subtitle: "1 kg",
            //   press: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) {
            //           return GroceryIndividualPage(product: "Cabbage");
            //         },
            //       ),
            //     );
            //   },
            // ),
            //   ],
            // ),
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
      ),
    );
  }
}
