import 'dart:io';

import 'package:flutter/material.dart';
import '../bloc.navigation_bloc/navigation_bloc.dart';
import 'package:image_picker/image_picker.dart';

class Sell extends StatefulWidget with NavigationStates{
  @override
  _SellState createState() => _SellState();
}

class _SellState extends State<Sell> {
  File _image;

  Future getImage() async {
    final image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);
    setState(() {
      _image = image;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Sell'),
      // ),
      body: Center(
          child: _image == null
              ? Text("Image is not Loaded")
              : Image.file(_image)
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Click',
        child: Icon(Icons.camera_alt),
      ),
    );
  }


}