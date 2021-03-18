import 'package:flutter/material.dart';
import 'package:frontend/Screens/Driver/src/pages/grocery/animations.dart';
import 'package:frontend/Screens/Driver/src/pages/grocery/tabs/track_map.dart';
import '../../../../../../constants.dart';

class CurrentOrder extends StatelessWidget {
  const CurrentOrder({Key key}) : super(key: key);

  final Color color = kPrimaryLightColor;

  @override
  Widget build(BuildContext context) {
    //double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 73),
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
                                                  margin:
                                                      EdgeInsets.symmetric(horizontal: 10,vertical:15),
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(50),
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
                                                    child: Text(
                                                      "View",
                                                      style: TextStyle(color: Colors.white)
                                                    ),
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
                  SizedBox(
                    height: 10,
                  ),
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
                                                  margin:
                                                      EdgeInsets.symmetric(horizontal: 10,vertical:15),
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(50),
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
                                                    child: Text(
                                                      "View",
                                                      style: TextStyle(color: Colors.white)
                                                    ),
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
                  SizedBox(
                    height: 10,
                  ),
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
                                                  margin:
                                                      EdgeInsets.symmetric(horizontal: 10,vertical:15),
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(50),
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
                                                    child: Text(
                                                      "View",
                                                      style: TextStyle(color: Colors.white)
                                                    ),
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
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),

      ],
    );
  }

  showAlertDialog(BuildContext context,String product) {  
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