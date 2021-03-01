import 'package:flutter/material.dart';
import 'package:frontend/Screens/Buyer/src/pages/grocery/gwidgets/gtypography.dart';
import 'package:frontend/logout.dart';
import 'package:frontend/Screens/Buyer/components/profile.dart';
import 'package:frontend/Screens/Buyer/components/track.dart';

class GroceryProfileTabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF1E6FF),
      child: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Track();
                  },
                ),
              );
            },
            leading: Icon(Icons.favorite_border,color: Colors.indigo[900]),
            title: GroceryTitle(text: "My Previous Orders"),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Profile();
                  },
                ),
              );
            },
            leading: Icon(Icons.settings,color: Colors.indigo[900]),
            title: GroceryTitle(text: "My Account"),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Logout();
                  },
                ),
              );
            },
            leading: Icon(Icons.logout,color: Colors.indigo[900]),
            title: GroceryTitle(text: "Logout"),
          ),
        ],
      ),
    );
  }
}
