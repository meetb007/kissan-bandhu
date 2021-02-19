import 'dart:convert';
import 'dart:io';
import 'package:frontend/Screens/Farmer/components/sell_detail.dart';
import 'package:frontend/components/rounded_button.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../bloc.navigation_bloc/navigation_bloc.dart';
import 'package:image_picker/image_picker.dart';

class Sell extends StatefulWidget with NavigationStates {
  @override
  _SellState createState() => _SellState();
}

class _SellState extends State<Sell> {
  File _image;

  Future getImage() async {
    // ignore: deprecated_member_use
    final image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);
    setState(() {
      _image = image;
    });
  }

  submitForm() async {
    // final response = await http.post(
    //   "",
    //   body: {
    //     'photo': _image != null ? 'data:image/png;base64,' +
    //         base64Encode(_image.readAsBytesSync()) : '',
    //   },
    // );
    // final responseJson = json.decode(response.body);
    // print(responseJson);
    print('data:image/png;base64,' + base64Encode(_image.readAsBytesSync()));
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) {
    //       return SellDetail();
    //     },
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Sell'),
      // ),
      body: Center(
          child: Column(
        children: [
          _image == null ? Text("Image is not Loaded") : Image.file(_image),
          SizedBox(height: 20),
          _image == null
              ? Text("")
              : RoundedButton(
                  text: "Submit",
                  press: () {
                    submitForm();
                  },
                ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Click',
        child: Icon(Icons.camera_alt),
      ),
    );
  }
}
