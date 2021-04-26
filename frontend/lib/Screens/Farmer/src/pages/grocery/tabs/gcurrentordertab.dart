import 'package:flutter/material.dart';
import 'package:frontend/Screens/Farmer/src/pages/grocery/animations.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';
import '../../../../../../constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend/components/rounded_input_field.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/url.dart';
import 'dart:convert';
import 'dart:io';

class CurrentOrder extends StatefulWidget {
  @override
  _CurrentOrderState createState() => _CurrentOrderState();
}

class _CurrentOrderState extends State<CurrentOrder> {
  _CurrentOrderState() {
    getDetails();
  }

  bool getData = false;
  var product, jsonData;
  String name, cost, quantity, description;
  bool exist = false;
  void getDetails() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    print(storage.getString("token"));
    String token = storage.getString("token");
    var response = await http.get(
      sell_product + '/current',
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
            height: height * 0.25,
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
                                      child: Column(
                                        children: [
                                          FadeAnimation(
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
                                                    showAlertDialog(
                                                        context, index);
                                                  },
                                                  child: Text(
                                                    "View",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          FadeAnimation(
                                            2,
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 5),
                                              height: 50,
                                              width: 150,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(90),
                                                  color: jsonData[index]
                                                              ['status'] ==
                                                          "Placed"
                                                      ? Colors.deepPurple
                                                      : Colors.grey),
                                              child: FlatButton(
                                                  onPressed: jsonData[index]
                                                              ['status'] ==
                                                          "Placed"
                                                      ? () {
                                                          this.name = jsonData[index]["name"];
                                                          this.description = jsonData[index]["description"];
                                                          this.cost = jsonData[index]["cost"];
                                                          this.quantity = jsonData[index]["quantity"];
                                                          showAlertDialog1(
                                                              context, index);
                                                        }
                                                      : () {
                                                          Toast.show(
                                                              "Edit option not available",
                                                              context,
                                                              duration: Toast
                                                                  .LENGTH_LONG);
                                                        },
                                                  child: Text(
                                                    "Edit",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                            ),
                                          ),
                                        ],
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
                            child: Text("No Current Order Found",
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
      title: Text("More Details"),
      content: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                // width: MediaQuery.of(context).size.width,
                child: Image(
                  image: NetworkImage(jsonData[index]['imageUrl']),
                  height: 200,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                // alignment: Alignment.bottomLeft,
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
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Description : ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          jsonData[index]['description'],
                          style: TextStyle(fontSize: 20),
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
                    Divider(color: Colors.black),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Status : ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          jsonData[index]['status'],
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

  editDetails(int index, BuildContext context) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    String token = storage.getString("token");
    String url = sell_product + "/" + jsonData[index]["_id"];
    var response = await http.put(url, body: {
      "name": this.name,
      "description": this.description,
      "cost": this.cost,
      "quantity": this.quantity
    }, headers: {
      HttpHeaders.authorizationHeader: token
    });
    print("Response -*********-" + response.statusCode.toString());
    var res = jsonDecode(response.body);
    print(res);
    if (res['statusCode'] == 200) {
      Toast.show("Product Updated successfully", context,
          duration: Toast.LENGTH_LONG);
      getDetails();
      Navigator.of(context).pop();
    } else {
      Toast.show("Some Error occured", context, duration: Toast.LENGTH_LONG);
      Navigator.of(context).pop();
    }
  }

  showAlertDialog1(BuildContext context, int index) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        editDetails(index, context);
        // Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Edit Details"),
      content: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                // width: MediaQuery.of(context).size.width,
                child: Image(
                  image: NetworkImage(jsonData[index]['imageUrl']),
                  height: 200,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                // alignment: Alignment.bottomLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name : ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    RoundedInputField(
                      hintText: "Name",
                      text: jsonData[index]['name'],
                      icon: Icons.edit,
                      onChanged: (value) {
                        this.name = value;
                      },
                    ),
                    Divider(color: Colors.black),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "Description : ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    RoundedInputField(
                      hintText: "Description",
                      text: jsonData[index]['description'],
                      icon: Icons.edit,
                      onChanged: (value) {
                        this.description = value;
                      },
                    ),
                    Divider(color: Colors.black),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "Cost in ₹ : ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    RoundedInputField(
                      hintText: "Cost in ₹",
                      text: jsonData[index]['cost'],
                      icon: Icons.edit,
                      onChanged: (value) {
                        this.cost = value;
                      },
                    ),
                    Divider(color: Colors.black),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "Quantity in kg : ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    RoundedInputField(
                      hintText: "Quantity in kg",
                      text: jsonData[index]['quantity'],
                      icon: Icons.edit,
                      onChanged: (value) {
                        this.quantity = value;
                      },
                    ),
                    Divider(color: Colors.black),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "Date of Order : " +
                          jsonData[index]['date'].toString().split("T")[0],
                      style: TextStyle(fontSize: 20),
                    ),
                    Divider(color: Colors.black),
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
