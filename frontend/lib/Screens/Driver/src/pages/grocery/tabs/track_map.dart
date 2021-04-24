import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_mapbox_navigation/library.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/url.dart';
// void main() => runApp(MyApp());

// ignore: camel_case_types
class trackMap extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<trackMap> {
  // String _platformVersion = 'Unknown';
  String _instruction = "";
  // final _origin = WayPoint(
  //     name: "Way Point 1",
  //     latitude: 38.9111117447887,
  //     longitude: -77.04012393951416);
  // final _stop1 = WayPoint(
  //     name: "Way Point 2",
  //     latitude: 38.91113678979344,
  //     longitude: -77.03847169876099);
  // final _stop2 = WayPoint(
  //     name: "Way Point 3",
  //     latitude: 38.91040213277608,
  //     longitude: -77.03848242759705);
  // final _stop3 = WayPoint(
  //     name: "Way Point 4",
  //     latitude: 38.909650771013034,
  //     longitude: -77.03850388526917);
  // final _stop4 = WayPoint(
  //     name: "Way Point 5",
  //     latitude: 38.90894949285854,
  //     longitude: -77.03651905059814);
  // final _farAway = WayPoint(
  //     name: "Far Far Away", latitude: 36.1175275, longitude: -115.1839524);

  MapBoxNavigation _directions;
  MapBoxOptions _options;

  bool _arrived = false;
  bool _isMultipleStop = false;
  double _distanceRemaining, _durationRemaining;
  MapBoxNavigationViewController _controller;
  bool _routeBuilt = false;
  bool _isNavigating = false;
  var jsonData = [];
  bool getData = false, exist = false, startLoading = false;
  int counter = 0;
  @override
  void initState() {
    super.initState();
    initialize();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initialize() async {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    _directions = MapBoxNavigation(onRouteEvent: _onEmbeddedRouteEvent);
    _options = MapBoxOptions(
        //initialLatitude: 36.1175275,
        //initialLongitude: -115.1839524,
        zoom: 15.0,
        tilt: 0.0,
        bearing: 0.0,
        enableRefresh: false,
        alternatives: true,
        voiceInstructionsEnabled: true,
        bannerInstructionsEnabled: true,
        allowsUTurnAtWayPoints: true,
        mode: MapBoxNavigationMode.drivingWithTraffic,
        units: VoiceUnits.imperial,
        simulateRoute: true,
        animateBuildRoute: true,
        longPressDestinationEnabled: false,
        language: "en");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        RaisedButton(
                          child: Text("Start Route"),
                          onPressed: () {
                            getDetail();
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    getData
                        ? (exist
                            ?
                            // ListView.builder(
                            //     itemCount: jsonData.length,
                            //     scrollDirection: Axis.vertical,
                            //     shrinkWrap: true,
                            //     physics: ClampingScrollPhysics(),
                            //     itemBuilder: (BuildContext context, int index) {
                            //       return getCard(index);
                            //     },
                            //   )
                            Column(children: [
                                Container(
                                  child: Column(
                                    children: [
                                      Text(
                                          "List of farmer for pickup of products",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18.0)),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                getCard(),
                                SizedBox(
                                  height: 10,
                                ),
                                RaisedButton(
                                  child: Text("Go To Map"),
                                  onPressed: () {
                                    getMap();
                                  },
                                ),
                              ])
                            : Container(
                                child: Center(
                                child: Text("No order to pickup ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18.0)),
                              )))
                        : (startLoading
                            ? Container(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : Text("")),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  void getDetail() async {
    setState(() {
      startLoading = true;
    });
    _isMultipleStop = true;
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // print(
    //     position.latitude.toString() + "****" + position.longitude.toString());
    String latitude = position.latitude.toString();
    String longitude = position.longitude.toString();
    SharedPreferences storage = await SharedPreferences.getInstance();
    print(storage.getString("token"));
    String token = storage.getString("token");
    var response = await http.post(pickUp,
        headers: {HttpHeaders.authorizationHeader: token},
        body: {"longitude": longitude, "latitude": latitude});
    print(response.statusCode);
    var res = jsonDecode(response.body);
    print(res);
    var status = res['statusCode'];
    if (status == 200 && res['length'] > 2) {
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
      print("Some error occured..");
    }
    // var wayPoints = List<WayPoint>();
    // var coordinates = [
    //   [19.2011, 72.9785],
    //   [19.2015, 72.9787],
    //   [19.1726, 72.9425],
    //   [19.0745, 72.9978]
    // ];
    // wayPoints.add(_origin);
    // wayPoints.add(_stop1);
    // wayPoints.add(_stop2);
    // wayPoints.add(_stop3);
    // wayPoints.add(_stop4);
    // wayPoints.add(_origin);

    // for (var i = 0; i < coordinates.length; i++) {
    //   wayPoints.add(WayPoint(
    //       name: i.toString(),
    //       latitude: coordinates[i][0],
    //       longitude: coordinates[i][1]));
    // }
    // await _directions.startNavigation(
    //     wayPoints: wayPoints,
    //     options: MapBoxOptions(
    //         mode: MapBoxNavigationMode.driving,
    //         simulateRoute: true,
    //         language: "en",
    //         allowsUTurnAtWayPoints: false,
    //         units: VoiceUnits.metric));
  }

  void getMap() async {
    var wayPoints = List<WayPoint>();
    for (var i = 0; i < jsonData.length; i++) {
      print('lon:' + jsonData[i]['latitude'] + ',' + jsonData[i]['longitude']);
      WayPoint a = WayPoint(
          name: i.toString(),
          latitude: double.parse(jsonData[i]['latitude']),
          longitude: double.parse(jsonData[i]['longitude']));
      wayPoints.add(a);
    }
    print(wayPoints);
    await _directions.startNavigation(
        wayPoints: wayPoints,
        options: MapBoxOptions(
            mode: MapBoxNavigationMode.driving,
            simulateRoute: true,
            language: "en",
            allowsUTurnAtWayPoints: true,
            units: VoiceUnits.metric));
    print(wayPoints);
  }

  Widget getCard() {
    var cards = List<DataRow>();
    int i = 1;
    cards.add(DataRow(cells: [
      DataCell(Text('Your Location ')),
      DataCell(Text("-")),
      DataCell(Text("-")),
      DataCell(Text(jsonData[0]['latitude'])),
      DataCell(Text(jsonData[0]['longitude']))
    ]));
    for (i = 1; i < (jsonData.length - 1); i++) {
      cards.add(DataRow(cells: [
        DataCell(Text('Farmer ' + i.toString())),
        DataCell(Text(jsonData[i]['name'])),
        DataCell(Text(jsonData[i]['quantity'])),
        DataCell(Text(jsonData[i]['latitude'])),
        DataCell(Text(jsonData[i]['longitude']))
      ]));
    }
    cards.add(DataRow(cells: [
      DataCell(Text('APMC Location ')),
      DataCell(Text("-")),
      DataCell(Text("-")),
      DataCell(Text(jsonData[i]['latitude'])),
      DataCell(Text(jsonData[i]['longitude']))
    ]));
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: [
          DataTable(
            columns: [
              DataColumn(
                  label: Text('Number',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Name',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Quantity',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Latitude',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Longitude',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
            ],
            rows: cards,
          ),
        ],
      ),
    );
  }

  // Widget getCard(int index) {
  //   if (index == 0) {
  //     return Container(
  //         child: Column(
  //       children: [
  //         Text("Driver current location = "),
  //         Text("Latitude = " + jsonData[index]['latitude']),
  //         Text("Longitude = " + jsonData[index]['longitude']),
  //       ],
  //     ));
  //   }
  //   if (index == (jsonData.length - 1)) {
  //     return Container(
  //         child: Column(
  //       children: [
  //         Text("APMC Location"),
  //         Text("Latitude = " + jsonData[index]['latitude']),
  //         Text("Longitude = " + jsonData[index]['longitude']),
  //       ],
  //     ));
  //   }
  //   return Container(
  //       child: Column(
  //     children: [
  //       Text("Name = " + jsonData[index]['name']),
  //       Text("Quantity = " + jsonData[index]['quantity']),
  //       Text("Latitude = " + jsonData[index]['latitude']),
  //       Text("Longitude = " + jsonData[index]['longitude']),
  //     ],
  //   ));
  // }

  Future<void> _onEmbeddedRouteEvent(e) async {
    _distanceRemaining = await _directions.distanceRemaining;
    _durationRemaining = await _directions.durationRemaining;

    switch (e.eventType) {
      case MapBoxEvent.progress_change:
        var progressEvent = e.data as RouteProgressEvent;
        _arrived = progressEvent.arrived;
        if (progressEvent.currentStepInstruction != null)
          _instruction = progressEvent.currentStepInstruction;
        break;
      case MapBoxEvent.route_building:
      case MapBoxEvent.route_built:
        setState(() {
          _routeBuilt = true;
        });
        break;
      case MapBoxEvent.route_build_failed:
        setState(() {
          _routeBuilt = false;
        });
        break;
      case MapBoxEvent.navigation_running:
        setState(() {
          _isNavigating = true;
        });
        break;
      case MapBoxEvent.on_arrival:
        _arrived = true;
        counter++;
        print("arrived at ------------");
        if (counter == (jsonData.length - 1)) {
          print("finished------------------");
          await finishedRequest();
        }
        if (!_isMultipleStop) {
          await Future.delayed(Duration(seconds: 3));
          await _controller.finishNavigation();
        } else {}
        break;
      case MapBoxEvent.navigation_finished:
      case MapBoxEvent.navigation_cancelled:
        setState(() {
          _routeBuilt = false;
          _isNavigating = false;
        });
        break;
      default:
        break;
    }
    setState(() {});
  }

  Future<void> finishedRequest() async {
    var farmers = new List<String>(jsonData.length-2);
    SharedPreferences storage = await SharedPreferences.getInstance();
    print(storage.getString("token"));
    String token = storage.getString("token");
    print(jsonData);
    for (int i = 1; i < jsonData.length - 1; i++) {
      farmers[i - 1] = jsonData[i]["_id"];
    }
    var apmc = jsonData[jsonData.length - 1];
    print(apmc);
    print(farmers);
    print("printed jsondata");
    var response = await http.post(driver_orders,
        body: {"farmers": farmers, "apmc": apmc},
        headers: {HttpHeaders.authorizationHeader: token});
    print(response.statusCode);
    var res = jsonDecode(response.body);
    print(res);
    var status = res['statusCode'];
    if (status == 200) {
      Toast.show("All orders picked up Successfully", context,
          duration: Toast.LENGTH_LONG);
    } else {
      Toast.show("Some error occured", context, duration: Toast.LENGTH_LONG);
    }
  }
}
