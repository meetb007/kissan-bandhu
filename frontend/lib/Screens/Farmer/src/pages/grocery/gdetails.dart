import 'package:flutter/material.dart';
import 'package:frontend/Screens/Buyer/core/presentation/res/assets.dart';
import 'package:frontend/Screens/Buyer/src/pages/grocery/gwidgets/glistitem2.dart';
import 'package:frontend/Screens/Buyer/src/pages/grocery/gwidgets/gtypography.dart';
import 'package:frontend/Screens/Buyer/src/widgets/network_image.dart';
import 'package:frontend/Screens/Buyer/src/pages/grocery/gdetails_individual.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/url.dart';
import 'dart:io';
import 'dart:convert';

class GroceryDetailsPage extends StatefulWidget {
  final String product;
  const GroceryDetailsPage({Key key, this.product}) : super(key: key);

  @override
  _GroceryDetailsPageState createState() => _GroceryDetailsPageState(product);
}

class _GroceryDetailsPageState extends State<GroceryDetailsPage> {
  // static final String path = "lib/src/pages/grocery/gdetails.dart";
  String product;
  bool getData = false;
  var jsonData;
  // String url = "https://kissan-bandhu.herokuapp.com/uploads/";

  _GroceryDetailsPageState(String product) {
    this.product = product;
    getDetails();
  }

  void getDetails() async {
    print("***********************************" + product);
    SharedPreferences storage = await SharedPreferences.getInstance();
    print(storage.getString("token"));
    String token = storage.getString("token");
    var response = await http.get(
      product_list + '/?category=' + product,
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
        title: Text("List of " + product),
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
                return GroceryListItemTwo(
                  title: jsonData[index]['name'],
                  image: upload_url + jsonData[index]['imageUrl'],
                  subtitle: jsonData[index]['quantity'],
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return GroceryIndividualPage(
                              product: jsonData[index]['name']);
                        },
                      ),
                    );
                  },
                );
              },
            ),
            // child: ListView(
            //   children: <Widget>[
            // _buildItemCard(context, product),

            // GroceryListItemTwo(
            //   title: "Broccoli",
            //   image: brocoli,
            //   subtitle: "1 kg",
            //   press: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) {
            //           return GroceryIndividualPage(product: "Broccoli");
            //         },
            //       ),
            //     );
            //   },
            // ),
            // GroceryListItemTwo(
            //   title: "Cabbage",
            //   image: brocoli,
            //   subtitle: "1 kg",
            //   press: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) {
            //           return GroceryIndividualPage(product: "Cabbage");
            //         },
            //       ),
            //     );
            //   },
            // ),
            //   ],
            // ),
          ),
          // Row(
          //   children: <Widget>[
          //     Expanded(
          //       child: Container(
          //         color: Colors.green,
          //         child: FlatButton(
          //           color: Colors.green,
          //           onPressed: () {},
          //           child: Text("Add to Cart"),
          //         ),
          //       ),
          //     )
          //   ],
          // )
        ],
      ),
    );
    // return Column(
    //   children: <Widget>[
    //     Expanded(
    //       child: ListView.builder(
    //         itemCount: jsonData.length,
    //         itemBuilder: (BuildContext context, int index) {
    //           return GroceryListItemTwo(
    //             title: jsonData[index]['name'],
    //             image: upload_url + jsonData[index]['imageUrl'],
    //             subtitle: jsonData[index]['quantity'],
    //             press: () {
    //               Navigator.push(
    //                 context,
    //                 MaterialPageRoute(
    //                   builder: (context) {
    //                     return GroceryIndividualPage(
    //                         product: jsonData[index]['name']);
    //                   },
    //                 ),
    //               );
    //             },
    //           );
    //         },
    //       ),
    //       // child: ListView(
    //       //   children: <Widget>[
    //       // _buildItemCard(context, product),

    //       // GroceryListItemTwo(
    //       //   title: "Broccoli",
    //       //   image: brocoli,
    //       //   subtitle: "1 kg",
    //       //   press: () {
    //       //     Navigator.push(
    //       //       context,
    //       //       MaterialPageRoute(
    //       //         builder: (context) {
    //       //           return GroceryIndividualPage(product: "Broccoli");
    //       //         },
    //       //       ),
    //       //     );
    //       //   },
    //       // ),
    //       // GroceryListItemTwo(
    //       //   title: "Cabbage",
    //       //   image: brocoli,
    //       //   subtitle: "1 kg",
    //       //   press: () {
    //       //     Navigator.push(
    //       //       context,
    //       //       MaterialPageRoute(
    //       //         builder: (context) {
    //       //           return GroceryIndividualPage(product: "Cabbage");
    //       //         },
    //       //       ),
    //       //     );
    //       //   },
    //       // ),
    //       //   ],
    //       // ),
    //     ),
    //     // Row(
    //     //   children: <Widget>[
    //     //     Expanded(
    //     //       child: Container(
    //     //         color: Colors.green,
    //     //         child: FlatButton(
    //     //           color: Colors.green,
    //     //           onPressed: () {},
    //     //           child: Text("Add to Cart"),
    //     //         ),
    //     //       ),
    //     //     )
    //     //   ],
    //     // )
    //   ],
    // );
  }

  // List<Widget> getCard(var response) {
  //   List<Widget> card = List<Widget>();
  //   String url = "https://kissan-bandhu.herokuapp.com/uploads/";
  //   response.forEach((tempProduct) => {
  //         card.add(
  //           GroceryListItemTwo(
  //             title: tempProduct['name'],
  //             image: url + tempProduct['imageUrl'],
  //             subtitle: tempProduct['quantity'],
  //             press: () {
  //               Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                   builder: (context) {
  //                     return GroceryIndividualPage(
  //                         product: tempProduct['name']);
  //                   },
  //                 ),
  //               );
  //             },
  //           ),
  //         )
  //       });
  //   return card;
  // }
}
