import 'package:flutter/material.dart';
import 'package:frontend/Screens/Buyer/core/presentation/res/assets.dart';
import 'package:frontend/Screens/Buyer/src/pages/grocery/gdetails.dart';
import 'package:frontend/Screens/Buyer/src/pages/grocery/gwidgets/glistitem1.dart';

class HomeTabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        // _buildCategories(),
        // SizedBox(height: 10.0,),
        // _buildListHeader("NEW ARRIVALS","SEE ALL"),
        _buildNewArrivalsRow(context, "Rice", "Strawberry"),
        _buildNewArrivalsRow(context, "LadyFinger", "Tomato"),
        _buildNewArrivalsRow(context, "Potato", "brocoli"),
      ],
    );
  }

  Widget _buildNewArrivalsRow(BuildContext context, String pro1, String pro2) {
    return Container(
      color: Color(0xFFF1E6FF),
      padding: EdgeInsets.all(10.0),
      height: 290.0,
      child: Row(
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: () => _openDetailPage(context, pro1),
              child: GroceryListItemOne(
                image: 'assets/images/'+pro1+'.jpg',
                // subtitle: "1 kg",
                title: pro1,
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () =>
                  {if (pro2.compareTo("brocoli") != 0) _openDetailPage(context, pro2)},
              child: GroceryListItemOne(
                image: 'assets/images/'+pro2+'.jpg',
                // subtitle: "6 in a pack",
                title: pro2,
              ),
            ),
          ),
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
