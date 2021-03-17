import 'package:flutter/material.dart';
import 'package:frontend/Screens/Farmer/src/pages/grocery/gwidgets/gtypography.dart';
import 'package:frontend/Screens/Farmer/src/widgets/network_image.dart';
import 'package:frontend/Screens/Farmer/src/pages/grocery/gdetails.dart';

class GroceryListItemOne extends StatelessWidget {
  final String image, title, price;
  const GroceryListItemOne({
    Key key,
    @required this.image,
    @required this.title,
    // @required this.subtitle,
    this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5.0), topRight: Radius.circular(5.0)),
          boxShadow: [
            BoxShadow(
                blurRadius: 10.0,
                color: Colors.grey.shade200,
                spreadRadius: 2.0)
          ]),
      margin: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                      child: PNetworkImage(
                    image,
                    height: 150.0,
                  )),
                  new GroceryTitle(text: title),
                  // new GrocerySubtitle(text: subtitle),
                ],
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: InkWell(
                  onTap: () => 
                    {if (title.compareTo("") != 0) _openDetailPage(context, title)},
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(5.0),
                            bottomRight: Radius.circular(5.0))),
                    child: Text(
                      "See more",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void _openDetailPage(BuildContext context, String product) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                GroceryDetailsPage(product: product)));
  }
}
