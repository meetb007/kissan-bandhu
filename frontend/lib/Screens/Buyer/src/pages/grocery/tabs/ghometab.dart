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
        _buildNewArrivalsRow(context, "lady Finger", "Tomato"),
        _buildNewArrivalsRow(context, "Cotton", ""),
        // SizedBox(height: 10.0,),
        // _buildListHeader("DAILY NEEDS","SEE ALL"),
        // SizedBox(height: 10.0,),
        // InkWell(
        //   onTap: ()=> _openDetailPage(context),
        //   child: GroceryListItemTwo(title: "Cabbage", image: cabbage, subtitle: "1 kg")),
        // InkWell(
        //   onTap: ()=> _openDetailPage(context),
        //   child: GroceryListItemTwo(title: "Red/yellow Capsicum", image: capsicum, subtitle: "1 kg")),
        // InkWell(
        //   onTap: ()=> _openDetailPage(context),
        //   child: GroceryListItemTwo(title: "Pineapple", image: pineapple, subtitle: "4 in a pack")),
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
              // onTap: () => _openDetailPage(context, pro1),
              child: GroceryListItemOne(
                image: mango,
                // subtitle: "1 kg",
                title: pro1,
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              // onTap: () =>
                  // {if (pro2.compareTo("") != 0) _openDetailPage(context, pro2)},
              child: GroceryListItemOne(
                image: brocoli,
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
