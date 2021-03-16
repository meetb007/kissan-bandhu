import 'package:flutter/material.dart';
import 'package:frontend/Screens/Buyer/core/presentation/res/assets.dart';
import 'package:frontend/Screens/Buyer/src/pages/grocery/ghome.dart';
import 'package:frontend/Screens/Buyer/src/pages/grocery/gwidgets/gtypography.dart';
import 'package:frontend/Screens/Buyer/src/widgets/network_image.dart';
import 'package:toast/toast.dart';

class GroceryIndividualPage extends StatefulWidget {
  final String product;
  const GroceryIndividualPage({Key key, this.product}) : super(key: key);

  @override
  _GroceryIndividualPageState createState() =>
      _GroceryIndividualPageState(product: product);
}

class _GroceryIndividualPageState extends State<GroceryIndividualPage> {
  // static final String path = "lib/src/pages/grocery/gdetails.dart";
  final String product;
  _GroceryIndividualPageState({this.product});

  @override
  Widget build(BuildContext context) {
    // print(product);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xFF6F35A5),
        title: Text(product),
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
              _buildItemCard(context, product),
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
                  onPressed: () => _openCartPage(context, product),
                  child: Text("Add to Cart"),
                ),
              ),
            )
          ],
        )
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

   void _openCartPage(BuildContext context, String product) {
    Toast.show(product+" added to cart", context, duration : Toast.LENGTH_LONG);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                GroceryHomePage()));
  }
}
