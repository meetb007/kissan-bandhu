import 'package:flutter/material.dart';
import 'package:frontend/Screens/Buyer/src/pages/grocery/gwidgets/gtypography.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/url.dart';
import 'dart:convert';
import 'dart:io';

class CartTabViewIndividual extends StatefulWidget {
  final String product;
  const CartTabViewIndividual({Key key, this.product}) : super(key: key);

  @override
  _CartTabViewIndividualState createState() =>
      _CartTabViewIndividualState(product);
}

class _CartTabViewIndividualState extends State<CartTabViewIndividual> {
  // static final String path = "lib/src/pages/grocery/gdetails.dart";
  String product;
  bool getData = false;
  var jsonData;
  // String url = "https://kissan-bandhu.herokuapp.com/uploads/";

  _CartTabViewIndividualState(String product) {
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
                margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                padding: EdgeInsets.all(30.0),
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    SizedBox(
                      height: 10.0,
                    ),
                    GroceryTitle(text: jsonData['name']),
                    SizedBox(
                      height: 10.0,
                    ),
                    GrocerySubtitle(text: "₹" + jsonData['cost']),
                    SizedBox(
                      height: 10.0,
                    ),
                    GrocerySubtitle(text:jsonData['quantity']),
                    SizedBox(
                      height: 10.0,
                    ),
                    GrocerySubtitle(
                      text: jsonData['description'],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
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
                    image: NetworkImage(upload_url + jsonData['imageUrl']),
                    height: 200,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
