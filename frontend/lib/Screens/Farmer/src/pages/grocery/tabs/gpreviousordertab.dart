import 'package:flutter/material.dart';
import 'package:frontend/Screens/Farmer/src/pages/grocery/animations.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';
import '../../../../../../constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/url.dart';
import 'dart:convert';
import 'dart:io';

class PreviousOrder extends StatefulWidget {
  @override
  _PreviousOrderState createState() => _PreviousOrderState();
}

class _PreviousOrderState extends State<PreviousOrder> {
  _PreviousOrderState() {
    getDetails();
  }

  bool getData = false, exist = false;
  var product, jsonData;
  void getDetails() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    print(storage.getString("token"));
    String token = storage.getString("token");
    var response = await http.get(
      sell_product + '/history',
      headers: {HttpHeaders.authorizationHeader: token},
    );
    print(response.statusCode);
    var res = jsonDecode(response.body);
    print(res);
    if (res['statusCode'] == 200 && res['length'] > 0) {
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
      print("Some error occured");
    }
  }

  Widget getContainer(int index) {
    double height = MediaQuery.of(context).size.height;
    return Container(
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
                              'Order ' + (index + 1).toString(),
                              style: TextStyle(
                                color: Color.fromRGBO(39, 105, 171, 1),
                                fontFamily: 'Nunito',
                                fontSize: 20,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      jsonData[index]['name'],
                                      style: TextStyle(
                                        color: Colors.grey[700],
                                        fontFamily: 'Nunito',
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      jsonData[index]['category'],
                                      style: TextStyle(
                                        color: Color.fromRGBO(39, 105, 171, 1),
                                        fontFamily: 'Nunito',
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      jsonData[index]['date']
                                          .toString()
                                          .split("T")[0],
                                      style: TextStyle(
                                        color: Color.fromRGBO(39, 105, 171, 1),
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
                                      borderRadius: BorderRadius.circular(100),
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                //Column(
                                Positioned.fill(
                                  //bottom: 50,
                                  child: Container(
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: FadeAnimation(
                                        2,
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 5),
                                          height: 50,
                                          width: 150,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(90),
                                              color: Colors.deepPurple),
                                          child: FlatButton(
                                              onPressed: () {
                                                showAlertDialog(context, index);
                                              },
                                              child: Text(
                                                "View",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // )
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
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  final Color color = kPrimaryLightColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
              // gradient: LinearGradient(
              //   colors: [
              //     Color.fromRGBO(20, 9, 50, 0.5),
              //     Color.fromRGBO(150, 95, 171, 0.5),
              //   ],
              //   begin: FractionalOffset.bottomCenter,
              //   end: FractionalOffset.topCenter,
              // ),
              ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: getData
                  ? (exist
                      ? Column(
                          children: [
                            ListView.builder(
                              itemCount: jsonData.length,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return getContainer(index);
                              },
                            ),
                          ],
                        )
                      : Container(
                          child: Center(
                            child: Text("No previous order",style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0)),
                          ),
                        ))
                  : Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }

  showAlertDialog(BuildContext context, int index) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("More Details"),
      content: Container(
        child: Column(
          children: <Widget>[
            Container(
              // width: MediaQuery.of(context).size.width,
              child: Image(
                image: NetworkImage(upload_url + jsonData[index]['imageUrl']),
                height: 200,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name : " + jsonData[index]['name'],
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Description : " + jsonData[index]['description'],
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Cost : ₹" + jsonData[index]['cost'],
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Quantity : " + jsonData[index]['quantity'],
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Date of Order : " +
                        jsonData[index]['date'].toString().split("T")[0],
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Status of Order: " + jsonData[index]['status'],
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ],
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
