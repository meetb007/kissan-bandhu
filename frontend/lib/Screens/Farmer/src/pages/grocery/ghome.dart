import 'package:flutter/material.dart';
import 'package:frontend/Screens/Farmer/src/pages/grocery/tabs/gselltab.dart';
import 'package:frontend/Screens/Farmer/src/pages/grocery/tabs/ghometab.dart';
import 'package:frontend/Screens/Farmer/src/pages/grocery/tabs/gprofiletab.dart';
import 'package:frontend/Screens/Farmer/src/pages/grocery/tabs/gcurrentordertab.dart';
import 'package:frontend/Screens/Farmer/src/pages/grocery/tabs/gpreviousordertab.dart';
// import 'package:frontend/Screens/Farmer/components/background.dart';

class FarmerHomePage extends StatefulWidget {
  static final String path = "lib/src/pages/grocery/ghome.dart";

  @override
  FarmerHomePageState createState() {
    return new FarmerHomePageState();
  }
}

class FarmerHomePageState extends State<FarmerHomePage> {
  int _currentIndex = 0;
  List<Widget> _children = [];
  List<Widget> _appBars = [];

  @override
  void initState() {
    _children.add(HomeTabView());
    _children.add(SellTabView());
    _children.add(CurrentOrder());
    _children.add(PreviousOrder());
    _children.add(ProfileTabView());

    _appBars.add(_buildAppBar());
    _appBars.add(_buildAppBarOne("My Cart"));
    _appBars.add(_buildAppBarOne("My Current Orders"));
    _appBars.add(_buildAppBarOne("My Previous Orders"));
    _appBars.add(_buildAppBarOne("My Account"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1E6FF),
      appBar: _appBars[_currentIndex],
      body: _children[_currentIndex],
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(90.0),
      child: Container(
        margin: EdgeInsets.only(top: 20.0),
        child: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFFF1E6FF),
          title: Container(
            child: Card(
              child: Container(
                child: TextField(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 15.0),
                      hintText: "Search products",
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                          onPressed: () {}, icon: Icon(Icons.search))),
                ),
              ),
            ),
          ),
          // leading: PNetworkImage(deliveryIcon),
        ),
      ),
    );
  }

  Widget _buildAppBarOne(String title) {
    return AppBar(
      bottom: PreferredSize(
          child: Container(
            color: Colors.grey.shade200,
            height: 1.0,
          ),
          preferredSize: Size.fromHeight(1.0)),
      automaticallyImplyLeading: false,
      backgroundColor: Color(0xFFF1E6FF),
      elevation: 0,
      title: Text(title, style: TextStyle(color: Colors.black)),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      onTap: _onTabTapped,
      backgroundColor: Color(0xFFF1E6FF),
      items: <BottomNavigationBarItem>[
        // ignore: deprecated_member_use
        BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
        BottomNavigationBarItem(
            // ignore: deprecated_member_use
            icon: Icon(Icons.grass_outlined), title: Text("Sell")),
        BottomNavigationBarItem(
            // ignore: deprecated_member_use
            icon: Icon(Icons.view_list_rounded), title: Text("Current Order")),
        BottomNavigationBarItem(
        // ignore: deprecated_member_use
        icon: Icon(Icons.view_list_rounded), title: Text("Previous Order")),
        BottomNavigationBarItem(
            // ignore: deprecated_member_use
            icon: Icon(Icons.person_outline), title: Text("Profile")),
      ],
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
    );
  }

  _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
