import 'package:flutter/material.dart';
import 'package:frontend/Screens/Driver/src/pages/grocery/gwidgets/gtypography.dart';


class GroceryListItemTwo extends StatelessWidget {
  const GroceryListItemTwo({
    Key key,
    @required this.title,
    @required this.subtitle,
    @required this.image,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String image;

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
        ],
      ),
    );
  }
}
