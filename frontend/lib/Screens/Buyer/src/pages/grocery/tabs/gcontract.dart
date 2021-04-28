import 'dart:convert';
import 'dart:io';
import 'package:frontend/components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/url.dart';
import 'package:frontend/components/rounded_input_field.dart';

class ContractView extends StatefulWidget {
  @override
  _ContractViewState createState() => _ContractViewState();
}

class _ContractViewState extends State<ContractView> {
  //backup
  String name = "",
      soil = "",
      description = "",
      quantity = "",
      cost = "",
      resource = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
            // decoration: BoxDecoration(
            //     gradient: LinearGradient(
            //       colors: [
            //         Color.fromRGBO(20, 9, 50, 1),
            //         Color.fromRGBO(150, 95, 171, 0.5),
            //       ],
            //       begin: FractionalOffset.bottomCenter,
            //       end: FractionalOffset.topCenter,
            //     ),
            //     ),
            ),
        Scaffold(
          backgroundColor: Color(0xFFC5A9EC),
          // body: Background(
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Contract Farming Form",
                    style:
                        TextStyle(fontWeight: FontWeight.w800, fontSize: 25.0),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          SizedBox(height: size.height * 0.03),
                          RoundedInputField(
                            hintText: "Name",
                            onChanged: (value) {
                              this.name = value;
                            },
                          ),
                          RoundedInputField(
                            hintText: "Soil type",
                            onChanged: (value) {
                              this.soil = value;
                            },
                          ),
                          RoundedInputField(
                            hintText: "Description",
                            onChanged: (value) {
                              this.description = value;
                            },
                          ),
                          RoundedInputField(
                            hintText: "Cost",
                            text: cost,
                            onChanged: (value) {
                              this.cost = value;
                            },
                          ),
                          RoundedInputField(
                            hintText: "Quantity",
                            text: quantity,
                            onChanged: (value) {
                              this.quantity = value;
                            },
                          ),
                          RoundedInputField(
                            hintText:
                                "Resources Provided ( Eg: seeds,pesticide etc)",
                            onChanged: (value) {
                              this.resource = value;
                            },
                          ),
                          RoundedButton(
                              text: "Submit",
                              press: () {
                                submit(context);
                              }),
                          RoundedButton(
                            text: "Reset",
                            press: () {
                              print("Reset button");
                              setState(() {
                                name = "";
                                description = "";
                                resource = "";
                                quantity = "";
                                cost = "";
                                soil = "";
                              });
                            },
                          ),
                          SizedBox(height: size.height * 0.03),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

// ignore: non_constant_identifier_names
  void submit(BuildContext context) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    String token = storage.getString("token");
    var response = await http.post(
      contract,
      body: {
        'name': name,
        'quantity': quantity,
        'description': description,
        'cost': cost,
        'soil': soil,
        'resource': resource,
      },
      headers: {HttpHeaders.authorizationHeader: token},
    );
    print(response.statusCode);
    var res = jsonDecode(response.body);
    print(res);
    if (res['statusCode'] == 200) {
      Toast.show("Contract Placed Successfully", context,
          duration: Toast.LENGTH_LONG);
      Navigator.pop(context);
    } else {
      Toast.show("Some Error Occured! Pls try again", context,
          duration: Toast.LENGTH_LONG);
    }
  }
}
