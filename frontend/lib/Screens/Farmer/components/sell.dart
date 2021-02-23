import 'dart:io';
//import 'package:frontend/components/rounded_button.dart';
import 'package:flutter/material.dart';
import '../bloc.navigation_bloc/navigation_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
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
  String name = "", address = "", quality = "";
  bool viewVisible = false;
  int quantity = 0, cost = 0;

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
                        setState(() {
                          viewVisible = true;
                        });
                      upload(true, context);
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
                            RoundedInputField(
                              hintText: "Name",
                              onChanged: (value) {
                                this.name = value;
                              },
                            ),
                            RoundedInputField(
                              hintText: "Quantity",
                              onChanged: (value) {
                                this.quantity = int.parse(value);
                              },
                            ),
                            RoundedInputField(
                              hintText: "Address",
                              onChanged: (value) {
                                this.address = value;
                              },
                            ),
                            RoundedInputField(
                              hintText: "Cost",
                              onChanged: (value) {
                                this.cost = int.parse(value);
                              },
                            ),
                            RoundedInputField(
                              hintText: "Quality",
                              onChanged: (value) {
                                this.quality = value;
                              },
                            ),
                            RoundedButton(
                              text: "Submit",
                              press: () {
                                submit();
                              },
                            ),
                            RoundedButton(
                              text: "Reset",
                              press: () {
                                reset();
                              },
                            ),
                            RoundedButton(
                              text: "Cancel",
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
                                  viewVisible = false;
                                });
                              },
                            ),
                            // RaisedButton(
                            //   color: Colors.cyan,
                            //   onPressed: () {
                            //     // print("selected image" + selectedImage.path);
                            //     // flag = true;
                            //     // ignore: unnecessary_statements
                            //     hideWidget;
                            //   },
                            //   child: Text("Reset"),
                            // ),
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
  submit() async {
    print("success");
  }

  reset() async {
    print("reser");
  }

  void upload(bool flag, BuildContext context) async {
    var request = http.MultipartRequest(
      'GET',
      Uri.parse("https://kissan-bandhu.govindapatel61.repl.co/predictItem"),
    );
    Map<String, String> headers = {"Content-type": "multipart/form-data"};
    request.files.add(
      http.MultipartFile(
        'file',
        selectedImage.readAsBytes().asStream(),
        selectedImage.lengthSync(),
        filename: basename(selectedImage.path),
        contentType: MediaType('image', 'jpeg'),
      ),
    );
    request.headers.addAll(headers);
    print("request: " + request.toString());
    var res = await request.send();
    print("This is response:" + res.toString());
    // viewSellDetail(context);
  }

  // viewSellDetail(BuildContext context) {
  //   Size size = MediaQuery.of(context).size;
  //   SizedBox(height: size.height * 0.03);
  //   RoundedInputField(
  //     hintText: "Name",
  //     onChanged: (value) {
  //       this.name = value;
  //     },
  //   );
  //   RoundedInputField(
  //     hintText: "Quantity",
  //     onChanged: (value) {
  //       this.quantity = int.parse(value);
  //     },
  //   );
  //   RoundedInputField(
  //     hintText: "Address",
  //     onChanged: (value) {
  //       this.address = value;
  //     },
  //   );
  //   RoundedInputField(
  //     hintText: "Cost",
  //     onChanged: (value) {
  //       this.cost = int.parse(value);
  //     },
  //   );
  //   RoundedInputField(
  //     hintText: "Quality",
  //     onChanged: (value) {
  //       this.quality = value;
  //     },
  //   );
  //   RoundedButton(
  //     text: "Submit",
  //     press: () {
  //       submit();
  //     },
  //   );
  //   RoundedButton(
  //     text: "Cancel",
  //     press: () {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) {
  //             return Sell();
  //           },
  //         ),
  //       );
  //     },
  //   );
  //   SizedBox(height: size.height * 0.03);
  // }

  //get image from camera
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

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
