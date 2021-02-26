import 'dart:convert';
import 'dart:io';
//import 'package:frontend/components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Screens/Farmer/sidebar/sidebar_layout.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import '../bloc.navigation_bloc/navigation_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/url.dart';
import 'package:path/path.dart';
import 'package:frontend/Screens/Signup/components/background.dart';
import 'package:frontend/components/rounded_button.dart';
import 'package:frontend/components/rounded_input_field.dart';

class Sell extends StatefulWidget with NavigationStates {
  @override
  _SellState createState() => _SellState();
}

class _SellState extends State<Sell> {
  //backup
  File selectedImage;
  String name = "";
  bool viewVisible = false;
  String quantity = "", cost = "", latitude = "", longitude = "";

  // void showWidget() {
  //   setState(() {
  //     viewVisible = true;
  //   });
  // }

  // void hideWidget() {
  //   setState(() {
  //     viewVisible = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: FutureBuilder(
                      future: _getImage(context),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                            return Text('Please wait');
                          case ConnectionState.waiting:
                            return Center(child: CircularProgressIndicator());
                          default:
                            if (snapshot.hasError)
                              return Text('Error: ${snapshot.error}');
                            else {
                              return selectedImage != null
                                  ? Image.file(selectedImage)
                                  : Center(
                                      child: Text("Please Get the Image"),
                                    );
                            }
                        }
                      },
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[500])),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.cyan,
                    onPressed: () {
                      // print("selected image" + selectedImage.path);
                      // flag = true;
                      // ignore: unnecessary_statements
                      // showWidget;
                      // testCompressAndGetFile(selectedImage, selectedImage.path);
                      upload(true, context);
                      //  setState(() {
                      //     viewVisible = true;
                      //   });
                      // flag = true;
                    },
                    child: Text("Upload"),
                  ),
                  RaisedButton(
                    onPressed: getImage,
                    child: Icon(Icons.add_a_photo),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Visibility(
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    visible: viewVisible,
                    // child: Container(
                    // child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: size.height * 0.03),
                        viewVisible
                            ? RoundedInputField(
                                hintText: "Name",
                                text: name,
                                onChanged: (value) {
                                  this.name = value;
                                },
                              )
                            : Text(""),
                        RoundedInputField(
                          hintText: "Quantity",
                          onChanged: (value) {
                            this.quantity = value;
                          },
                        ),
                        // RoundedInputField(
                        //   hintText: "Address",
                        //   onChanged: (value) {
                        //     this.address = value;
                        //   },
                        // ),
                        RoundedInputField(
                          hintText: "Cost",
                          onChanged: (value) {
                            this.cost = value;
                          },
                        ),
                        RoundedButton(
                          text: "Submit",
                          press: () {
                            submit(context);
                          },
                        ),
                        RoundedButton(
                          text: "Reset",
                          press: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) {
                            //       return Sell();
                            //     },
                            //   ),
                            // );
                            // hideWidget;
                            setState(() {
                              name = "";
                              quantity = "";
                              cost = "";
                              latitude = "";
                              longitude = "";
                              selectedImage = null;
                              viewVisible = false;
                            });
                          },
                        ),
                        SizedBox(height: size.height * 0.03),
                      ],
                    ),
                  ),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

// ignore: non_constant_identifier_names
  void submit(BuildContext context) async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    latitude = position.latitude.toString();
    longitude = position.longitude.toString();
    SharedPreferences storage = await SharedPreferences.getInstance();
    String token = storage.getString("token");

    var response = await http.post(
      sell_product,
      body: {
        'name': name,
        'quantity': quantity,
        'latitude': latitude,
        'longitude': longitude,
        'cost': cost
      },
      headers: {HttpHeaders.authorizationHeader: token},
    );
    print(response.statusCode);
    var res = jsonDecode(response.body);
    print(res);
    var status = res["statusCode"];
    if (status == 200) {
      Toast.show("Order placed successfully", context, duration : Toast.LENGTH_LONG);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return FarmerSideBarLayout();
            },
          ),
        );
    } else {
      Toast.show("Order was not placed successfully", context, duration : Toast.LENGTH_LONG);
      setState(() {
        name = "";
        quantity = "";
        cost = "";
        latitude = "";
        longitude = "";
        selectedImage = null;
        viewVisible = false;
      });
    }
  }

  void upload(bool flag, BuildContext context) async {
    var request = http.MultipartRequest(
      'GET',
      Uri.parse(cnn_model),
    );
    Map<String, String> headers = {"Content-type": "multipart/form-data"};
    request.files.add(
      http.MultipartFile(
        'file',
        selectedImage.readAsBytes().asStream(),
        selectedImage.lengthSync(),
        filename: basename(selectedImage.path),
        //contentType: MediaType('image', 'jpeg'),
      ),
    );
    request.headers.addAll(headers);
    print("request: " + request.toString());
    var res = await request.send();
    print("This is response:" + res.toString());
    final respStr = await res.stream.bytesToString();
    print(respStr);
    final body1 = json.decode(respStr);
    if (body1["statusCode"] == 200) {
      print(body1["data"]);
      setState(() {
        name = body1["data"];
        viewVisible = true;
      });
    } else {
      Toast.show("Please try again with a clear image", context,
          duration: Toast.LENGTH_LONG);
    }
    // var res1 = jsonDecode(res);
    // print(res1);
  }

  //get image from camera
  Future getImage() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      selectedImage = image;
    });
    //return image;
  }

  //resize the image
  Future<void> _getImage(BuildContext context) async {
    if (selectedImage != null) {
      var imageFile = selectedImage;
      /*var image = imageLib.decodeImage(imageFile.readAsBytesSync());
      fileName = basename(imageFile.path);
      image = imageLib.copyResize(image,
          width: (MediaQuery.of(context).size.width * 0.8).toInt(),
          height: (MediaQuery.of(context).size.height * 0.7).toInt());
      _image = image;*/
    }
  }
}
