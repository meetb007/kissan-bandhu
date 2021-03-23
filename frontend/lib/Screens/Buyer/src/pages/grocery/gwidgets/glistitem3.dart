import 'package:flutter/material.dart';
import 'package:frontend/Screens/Buyer/src/pages/grocery/gwidgets/gtypography.dart';
import 'package:frontend/Screens/Buyer/src/pages/grocery/ghome.dart';
import 'package:frontend/Screens/Buyer/src/pages/grocery/tabs/gcarttab_view.dart';
import 'package:frontend/components/rounded_input_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/url.dart';
import 'dart:io';
import 'package:toast/toast.dart';
import 'dart:convert';

// ignore: must_be_immutable
class GroceryListItemThree extends StatelessWidget {
  GroceryListItemThree({
    Key key,
    @required this.title,
    @required this.subtitle,
    @required this.image,
    @required this.id,
    @required this.productId,
    @required this.quantity,
    @required this.func1,
    this.price,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String image;
  final double price;
  final String id, productId;
  var func1;
  String quantity;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 45,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 10.0),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(
                  //   width: 10,
                  // ),
                  Container(
                      height: 80.0,
                      child: Image(
                        image: NetworkImage(image),
                        height: 80.0,
                        width: 80.0,
                        fit: BoxFit.fill,
                      )),
                  const SizedBox(width: 20.0),
                  Container(
                    child: Container(
                      // height: 120.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new GroceryTitle(text: title),
                          new GrocerySubtitle(text: "Quantity : " + subtitle)
                        ],
                      ),
                    ),
                  ),
                ]),
            const SizedBox(width: 10.0),
            // Divider(
            //   color: Colors.black,
            // ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios_rounded),
                      color: Colors.green,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return CartTabViewIndividual(product: productId);
                            },
                          ),
                        );
                      },
                    ),
                    Text('View item')
                  ],
                ),
                VerticalDivider(
                  color: Colors.black,
                  thickness: 2,
                  width: 20,
                ),
                Column(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.update_rounded),
                      color: Colors.green,
                      onPressed: () {
                        showAlertDialog(context, id, quantity);
                      },
                    ),
                    Text('Update item')
                  ],
                ),
                VerticalDivider(
                  color: Colors.black,
                  thickness: 2,
                  width: 20,
                ),
                Column(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.delete),
                      color: Colors.green,
                      onPressed: () {
                        delete(context, id);
                      },
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
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            // Row(
            //   children: [
            //     RaisedButton(child: Text("View"), onPressed: () {}),
            //     RaisedButton(child: Text("Update"), onPressed: () {}),
            //     RaisedButton(child: Text("Remove"), onPressed: () {}),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  void delete(BuildContext context, String id) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    print(storage.getString("token"));
    String token = storage.getString("token");
    var response = await http.delete(
      cart + '/' + id,
      headers: {HttpHeaders.authorizationHeader: token},
    );
    print(response.statusCode);
    var res = jsonDecode(response.body);
    print(res);
    if (res["statusCode"] == 200) {
      print("Deleted successfully");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return GroceryHomePage();
          },
        ),
      );
    } else {
      print("error");
    }
  }

  void update(BuildContext context) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    print(storage.getString("token"));
    String token = storage.getString("token");
    var response = await http.put(
      cart + '/' + id,
      body: {
        'quantity': quantity,
      },
      headers: {HttpHeaders.authorizationHeader: token},
    );
    print(response.statusCode);
    var res = jsonDecode(response.body);
    print(res);
    if (res['statusCode'] == 200) {
      Toast.show("Quantity updated successfully", context,
          duration: Toast.LENGTH_LONG);
      Navigator.of(context).pop();
      func1();
    }
    else{
      Toast.show("Error!! Quantity updated falied", context,
          duration: Toast.LENGTH_LONG);
      Navigator.of(context).pop();
      func1();
    }
  }

  showAlertDialog(BuildContext context, String index, String quantity) async {
    // Create button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        update(context);
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Enter quatity value"),
      content: Container(
        child: RoundedInputField(
          hintText: "Quantity in kg",
          text: quantity,
          icon: Icons.edit,
          onChanged: (value) {
            this.quantity = value;
          },
        ),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
