import 'package:flutter/material.dart';
import 'package:frontend/Screens/Buyer/src/pages/grocery/ghome.dart';
import 'package:frontend/Screens/Buyer/src/pages/grocery/gwidgets/gtypography.dart';
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/url.dart';
import 'dart:convert';
import 'dart:io';

class GroceryIndividualPage extends StatefulWidget {
  final String product;
  const GroceryIndividualPage({Key key, this.product}) : super(key: key);

  @override
  _GroceryIndividualPageState createState() =>
      _GroceryIndividualPageState(product);
}

class _GroceryIndividualPageState extends State<GroceryIndividualPage> {
  // static final String path = "lib/src/pages/grocery/gdetails.dart";
  String product;
  bool getData = false;
  var jsonData;
  // String url = "https://kissan-bandhu.herokuapp.com/uploads/";

  _GroceryIndividualPageState(String product) {
    this.product = product;
    getDetails();
  }

  void getDetails() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    print(storage.getString("token"));
    String token = storage.getString("token");
    var response = await http.get(
      product_list + '/' + product,
      headers: {HttpHeaders.authorizationHeader: token},
    );
    print(response.statusCode);
    var res = jsonDecode(response.body);
    print(res);
    if (res['statusCode'] == 200) {
      // getCard(res['response']);
      jsonData = res['response'];
      setState(() {
        getData = true;
      });
    } else {
      print("Product not found");
    }
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
      body: getData
          ? _buildPageContent(context)
          : Container(
              child: Center(
              child: CircularProgressIndicator(),
            )),
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
                  padding: EdgeInsets.all(30.0),
                  child: GrocerySubtitle(
                    text: jsonData['description'],
                  )),
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
                  onPressed: () => addToCart(context, product),
                  child: Text("Add to Cart"),
                ),
              ),
            )
          ],
        )
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
                SizedBox(
                  height: 10.0,
                ),
                GroceryTitle(text: jsonData['name']),
                SizedBox(
                  height: 5.0,
                ),
                GrocerySubtitle(text: "₹" + jsonData['cost']),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _openCartPage(BuildContext context) {
    Toast.show("Product added to cart", context, duration: Toast.LENGTH_LONG);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => GroceryHomePage()));
  }

  void addToCart(BuildContext context, String product) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    print(storage.getString("token"));
    String token = storage.getString("token");
    var response = await http.post(
      cart,
      body: {
        'product': product,
        'quantity': "1",
      },
      headers: {HttpHeaders.authorizationHeader: token},
    );
    print(response.statusCode);
    var res = jsonDecode(response.body);
    print(res);
    if (res['statusCode'] == 200) {
      _openCartPage(context);
    } else {
      print("Error in adding cart");
    }
  }
}
