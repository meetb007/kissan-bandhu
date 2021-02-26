import 'package:flutter/material.dart';  
import 'package:google_maps_flutter/google_maps_flutter.dart';  
    
// ignore: camel_case_types
class trackMap extends StatefulWidget {  
  @override  
  _trackMapState createState() => _trackMapState();  
}  
  
// ignore: camel_case_types
class _trackMapState extends State<trackMap> {  
  GoogleMapController myController;  
  
  final LatLng _center = const LatLng(45.521563, -122.677433);  
  
  void _onMapCreated(GoogleMapController controller) {  
    myController = controller;  
  }  
  
  @override  
  Widget build(BuildContext context) {  
    return MaterialApp(  
      home: Scaffold(  
        appBar: AppBar(  
          title: Text('Flutter Maps Demo'),  
          backgroundColor: Colors.green,  
        ),  
        body: Stack(  
          children: <Widget>[  
            GoogleMap(  
              onMapCreated: _onMapCreated,  
              initialCameraPosition: CameraPosition(  
                target: _center,  
                zoom: 10.0,  
              ),  
            ),  
            Padding(  
              padding: const EdgeInsets.all(14.0),  
              child: Align(  
                alignment: Alignment.topRight,  
                child: FloatingActionButton(  
                  onPressed: () => print('You have pressed the button'),  
                  materialTapTargetSize: MaterialTapTargetSize.padded,  
                  backgroundColor: Colors.green,  
                  child: const Icon(Icons.map, size: 30.0),  
                ),  
              ),  
            ),  
          ],  
        ),  
      ),  
    );  
  }  
}  


// // Copyright 2018 The Chromium Authors. All rights reserved.
// // Use of this source code is governed by a BSD-style license that can be
// // found in the LICENSE file.

// // ignore_for_file: public_member_api_docs

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter_example/lite_mode.dart';
// import 'animate_camera.dart';
// import 'map_click.dart';
// import 'map_coordinates.dart';
// import 'map_ui.dart';
// import 'marker_icons.dart';
// import 'move_camera.dart';
// import 'padding.dart';
// import 'page.dart';
// import 'place_circle.dart';
// import 'place_marker.dart';
// import 'place_polygon.dart';
// import 'place_polyline.dart';
// import 'scrolling_map.dart';
// import 'snapshot.dart';
// import 'tile_overlay.dart';

// final List<GoogleMapExampleAppPage> _allPages = <GoogleMapExampleAppPage>[
//   MapUiPage(),
//   MapCoordinatesPage(),
//   MapClickPage(),
//   AnimateCameraPage(),
//   MoveCameraPage(),
//   PlaceMarkerPage(),
//   MarkerIconsPage(),
//   ScrollingMapPage(),
//   PlacePolylinePage(),
//   PlacePolygonPage(),
//   PlaceCirclePage(),
//   PaddingPage(),
//   SnapshotPage(),
//   LiteModePage(),
//   TileOverlayPage(),
// ];

// class MapsDemo extends StatelessWidget {
//   void _pushPage(BuildContext context, GoogleMapExampleAppPage page) {
//     Navigator.of(context).push(MaterialPageRoute<void>(
//         builder: (_) => Scaffold(
//               appBar: AppBar(title: Text(page.title)),
//               body: page,
//             )));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('GoogleMaps examples')),
//       body: ListView.builder(
//         itemCount: _allPages.length,
//         itemBuilder: (_, int index) => ListTile(
//           leading: _allPages[index].leading,
//           title: Text(_allPages[index].title),
//           onTap: () => _pushPage(context, _allPages[index]),
//         ),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(home: MapsDemo()));
// }

