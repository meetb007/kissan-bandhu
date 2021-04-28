import 'package:flutter/material.dart';
import 'package:frontend/Screens/Buyer/src/pages/grocery/gwidgets/gtypography.dart';

// ignore: must_be_immutable
class CurrentOrderListIndividual extends StatefulWidget {
  var product;
  CurrentOrderListIndividual({Key key, this.product}) : super(key: key);

  @override
  _CurrentOrderListIndividualState createState() =>
      _CurrentOrderListIndividualState(product);
}

class _CurrentOrderListIndividualState
    extends State<CurrentOrderListIndividual> {
  var jsonData;

  _CurrentOrderListIndividualState(var product) {
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
        title: Text("Product Details"),
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
                margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                padding: EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    GroceryTitle(text: jsonData['name']),
                    SizedBox(
                      height: 10.0,
                    ),
                    GrocerySubtitle(text: "₹" + jsonData['cost']),
                    SizedBox(
                      height: 10.0,
                    ),
                    GrocerySubtitle(text: jsonData['quantity']),
                    SizedBox(
                      height: 10.0,
                    ),
                    GrocerySubtitle(
                      text: jsonData['description'],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
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
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Image(
                    image: NetworkImage(jsonData['imageUrl']),
                    height: 200,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
