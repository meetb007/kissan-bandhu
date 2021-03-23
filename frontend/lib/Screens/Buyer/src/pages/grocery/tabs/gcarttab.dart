import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:frontend/Screens/Buyer/src/pages/grocery/gwidgets/glistitem3.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/url.dart';
import 'dart:io';
import 'dart:convert';

class CartTabView extends StatefulWidget {
  @override
  _CartTabViewState createState() => _CartTabViewState();
}

class _CartTabViewState extends State<CartTabView> {
  String product;
  bool getData = false, exist = false;
  var jsonData;
  // String url =

  _CartTabViewState() {
    getDetails();
  }

  void getDetails() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    print(storage.getString("token"));
    String token = storage.getString("token");
    var response = await http.get(
      cart,
      headers: {HttpHeaders.authorizationHeader: token},
    );
    print(response.statusCode);
    var res = jsonDecode(response.body);
    print(res);
    if (res['statusCode'] == 200 && res['length'] > 0) {
      // getCard(res['response']);
      jsonData = res['response'];
      setState(() {
        getData = true;
        exist = true;
      });
    } else {
      setState(() {
        getData = true;
        exist = false;
      });
      print("Product not found");
    }
  }

  @override
  Widget build(BuildContext context) {
    // return Column(
    //   children: <Widget>[
    //     Expanded(
    //       child: ListView(
    //         padding: EdgeInsets.all(10.0),
    //         children: <Widget>[
    //           GroceryListItemThree(
    //             image: pineapple,
    //             // subtitle: "4 in a pack",
    //             title: "Pineapple",
    //           ),
    //           GroceryListItemThree(
    //             image: cabbage,
    //             // subtitle: "1 kg",
    //             title: "cabbage",
    //           ),
    //         ],
    //       ),
    //     ),
    //     SizedBox(
    //       height: 10.0,
    //     ),
    //     _buildTotals()
    //   ],
    // );
    if (!getData) {
      return Container(
          child: Center(
        child: CircularProgressIndicator(),
      ));
    }
    if (!exist) {
      return Container(
          child: Center(
        child: Text("No objects in cart",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0)),
      ));
    }
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            child: ListView.builder(
              itemCount: jsonData.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: GroceryListItemThree(
                      title: jsonData[index]["product"]['name'],
                      image: jsonData[index]["product"]['imageUrl'],
                      subtitle: jsonData[index]["quantity"],
                      id: jsonData[index]["_id"],
                      productId: jsonData[index]["product"]["_id"],
                      quantity: jsonData[index]["quantity"],
                      func1:f1,
                      // press: () {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) {
                      //         return GroceryIndividualPage(
                      //             product: jsonData[index]['_id']);
                      //       },
                      //     ),
                      //   );
                      // },
                      ),
                );
              },
            ), // ),
          ),
          SizedBox(
            height: 20.0,
          ),
          _buildTotals(),
        ],
      ),
    );
  }

  Future<void> f1() async{
    // ignore: await_only_futures
    await getDetails();
    setState(() {});
  }

  Widget _buildTotals() {
    return ClipPath(
      clipper: OvalTopBorderClipper(),
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                blurRadius: 5.0,
                color: Colors.grey.shade700,
                spreadRadius: 80.0),
          ],
          color: Colors.white,
        ),
        padding:
            EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0, bottom: 10.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Subtotal"),
                Text("Rs. 1500"),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Delivery fee"),
                Text("Rs. 100"),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Total"),
                Text("Rs. 1600"),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            RaisedButton(
              color: Colors.green,
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text("Continue to Checkout",
                      style: TextStyle(color: Colors.white)),
                  Text("Rs. 1600", style: TextStyle(color: Colors.white)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
