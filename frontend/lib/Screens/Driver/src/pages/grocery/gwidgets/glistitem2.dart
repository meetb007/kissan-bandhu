import 'package:flutter/material.dart';
import 'package:frontend/Screens/Driver/src/pages/grocery/gwidgets/gtypography.dart';


class GroceryListItemTwo extends StatelessWidget {
  const GroceryListItemTwo({
    Key key,
    @required this.title,
    @required this.subtitle,
    @required this.image,
    @required this.press,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String image;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      child: Row(
        children: <Widget>[
          const SizedBox(width: 10.0),
          Container(
              height: 80.0,
              child: Image(
                image: NetworkImage(image),
                height: 80.0,
              )
            ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new GroceryTitle(text: title),
                new GrocerySubtitle(text: subtitle)
              ],
            ),
          ),
          const SizedBox(width: 10.0),
          Column(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_forward_ios_rounded),
                onPressed: press,
              ),
              // IconButton(
              //   icon: Icon(
              //     Icons.add_shopping_cart_rounded
              //   ),
              //   color: Color(0xFF6F35A5),
              //   onPressed: () => _openCartPage(context, title),
              // )
            ],
          ),
          const SizedBox(width: 10.0),
        ],
      ),
    );
  }
}
