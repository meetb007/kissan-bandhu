import 'package:flutter/material.dart';
import 'package:frontend/Screens/Driver/src/pages/grocery/animations.dart';
import 'package:frontend/Screens/Driver/src/pages/grocery/tabs/track_map.dart';
import '../../../../../../constants.dart';
import 'package:frontend/Screens/Buyer/src/pages/grocery/gwidgets/glistitem2.dart';
import 'package:frontend/url.dart';

class HomeTabView extends StatefulWidget {
  @override
  _HomeTabViewState createState() => _HomeTabViewState();
}

class _HomeTabViewState extends State<HomeTabView> {
  final Color color = kPrimaryLightColor;
  var jsonData;

  @override
  Widget build(BuildContext context) {
    //double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      fit: StackFit.expand,
      children: [
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                children: [
                  Container(
                    height: height * 0.20,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double innerHeight = constraints.maxHeight;
                        double innerWidth = constraints.maxWidth;
                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: innerHeight * 1,
                                width: innerWidth,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Order1',
                                      style: TextStyle(
                                        color: Color.fromRGBO(39, 105, 171, 1),
                                        fontFamily: 'Nunito',
                                        fontSize: 20,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              'Product1',
                                              style: TextStyle(
                                                color: Colors.grey[700],
                                                fontFamily: 'Nunito',
                                                fontSize: 15,
                                              ),
                                            ),
                                            Text(
                                              '#121542',
                                              style: TextStyle(
                                                color: Color.fromRGBO(
                                                    39, 105, 171, 1),
                                                fontFamily: 'Nunito',
                                                fontSize: 15,
                                              ),
                                            ),
                                            Text(
                                              '20/1/2020',
                                              style: TextStyle(
                                                color: Color.fromRGBO(
                                                    39, 105, 171, 1),
                                                fontFamily: 'Nunito',
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 25,
                                            vertical: 15,
                                          ),
                                          child: Container(
                                            height: 30,
                                            width: 3,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        //Column(
                                        Positioned.fill(
                                          bottom: 50,
                                          child: Container(
                                            child: Align(
                                              alignment: Alignment.bottomCenter,
                                              child: FadeAnimation(
                                                2,
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 15),
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      color: Colors.deepPurple),
                                                  child: FlatButton(
                                                    minWidth: innerWidth * 0.45,
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) {
                                                            return trackMap();
                                                          },
                                                        ),
                                                      );
                                                    },
                                                    child: Text("View",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // _buildPageContent(context),
      ],
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
                  image: jsonData[index]['imageUrl'],
                  subtitle: jsonData[index]['quantity'],
                  press: () {},
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
  }

  showAlertDialog(BuildContext context, String product) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Simple Alert"),
      content: Text(product),
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
