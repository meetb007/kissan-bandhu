import 'package:flutter/material.dart';
import 'package:frontend/Screens/Buyer/src/pages/grocery/gwidgets/gtypography.dart';

class GroceryListItemThree extends StatelessWidget {
  const GroceryListItemThree({
    Key key,
    @required this.title,
    // @required this.subtitle,
    @required this.image,
    this.price,
  }) : super(key: key);

  final String title;
  // final String subtitle;
  final String image;
  final double price;

  @override
  Widget build(BuildContext context) {
    return Card(
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
            child: Container(
              height: 120.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new GroceryTitle(text: title),
                  // new GrocerySubtitle(text: subtitle)
                ],
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Divider(
            color: Colors.black,
          ),
          Column(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_forward_ios_rounded),
                color: Colors.green,
                onPressed: () {},
              ),
              Text('View item')
            ],
          ),
          VerticalDivider(
            color: Colors.black,
            thickness: 2,
            width: 20,),
          Column(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.update_rounded),
                color: Colors.green,
                onPressed: () {},
              ),
              Text('Update item')
            ],
          ),
          VerticalDivider(
            color: Colors.black,
            thickness: 2,
            width: 20,),
          Column(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.delete),
                color: Colors.green,
                onPressed: () {},
              ),
              Text('Delete Item')
              // ButtonBar(
              //   children: <Widget>[
              //     RaisedButton(child: Text("View"), onPressed: () {}),
              //     RaisedButton(child: Text("Update"), onPressed: () {}),
              //     RaisedButton(child: Text("Remove"), onPressed: () {}),
              //   ],
              // ),
            ],
          ),
          SizedBox(
            height:10.0,
          ),
          // Row(
          //   children: [
          //     RaisedButton(child: Text("View"), onPressed: () {}),
          //     RaisedButton(child: Text("Update"), onPressed: () {}),
          //     RaisedButton(child: Text("Remove"), onPressed: () {}),
          //   ],
          // ),
          const SizedBox(width: 10.0),
        ],
      ),
    );
  }
}
