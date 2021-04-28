import 'package:flutter/material.dart';
import 'package:frontend/Screens/Farmer/src/pages/grocery/animations.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';
import '../../../../../../constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/url.dart';
import 'dart:convert';
import 'dart:io';

class ContractView extends StatefulWidget {
  @override
  _ContractViewState createState() => _ContractViewState();
}

class _ContractViewState extends State<ContractView> {
  _ContractViewState() {
    getDetails();
  }

  bool getData = false, exist = false;
  var product, jsonData;
  void getDetails() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    print(storage.getString("token"));
    String token = storage.getString("token");
    var response = await http.get(
      contract,
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
                              'Contract ' + (index + 1).toString(),
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
                                      jsonData[index]['soil'],
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
          backgroundColor: Color(0xFFC5A9EC),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: getData
                  ? (exist
                      ? Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 30),
                              child: Text("List of Contracts",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 23.0)),
                            ),
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
                          padding: EdgeInsets.symmetric(vertical: 50),
                          child: Center(
                            child: Text("No Contracts available",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18.0)),
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
      title: Text("More Details about contract"),
      content: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              Container(
                alignment: Alignment.bottomLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: <Widget>[
                        Text(
                          "Name : ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          jsonData[index]['name'],
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    Divider(color: Colors.black),
                    SizedBox(
                      height: 10.0,
                    ),
                    Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "Description : ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            jsonData[index]['description'],
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    // Text(
                    //   "Description : " + jsonData[index]['description'],
                    //   style: TextStyle(fontSize: 20),
                    // ),
                    Divider(color: Colors.black),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Cost : ₹",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          jsonData[index]['cost'],
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    Divider(color: Colors.black),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Quantity : ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          jsonData[index]['quantity'],
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    Divider(color: Colors.black),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Soil : ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          jsonData[index]['soil'],
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    Divider(color: Colors.black),
                    SizedBox(
                      height: 10.0,
                    ),
                    Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "Resources Provided",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            jsonData[index]['resource'],
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    Divider(color: Colors.black),
                    SizedBox(
                      height: 10.0,
                    ),
                    Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  "Contact Details : ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  "Name : " +
                                      jsonData[index]['contact']['name'],
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  "Contact : " +
                                      jsonData[index]['contact']['mobile'],
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(color: Colors.black),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Date : ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          jsonData[index]['date'].toString().split("T")[0],
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
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
