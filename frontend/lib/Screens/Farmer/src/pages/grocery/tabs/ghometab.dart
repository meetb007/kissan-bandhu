import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:frontend/Screens/Farmer/src/pages/grocery/tabs/blogtile.dart';
import 'package:http/http.dart' as http;

// import 'package:frontend/Screens/Login/components/background.dart';
class HomeTabView extends StatefulWidget {
  @override
  _HomeTabViewState createState() => _HomeTabViewState();
}

class _HomeTabViewState extends State<HomeTabView> {
  bool _loading = true;
  var articles = [];
  _HomeTabViewState() {
    getData();
  }

  void getData() async {
    String url =
        "https://newsapi.org/v2/everything?qintitle=farmer&sortBy=popularity&apiKey=869afd0e6e274fa999c6179c245ba002";
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    print(jsonData["articles"].length);
    if (jsonData["status"] == "ok") {
      jsonData["articles"].forEach((elements) {
        if (elements["title"] != null &&
            elements["description"] != null &&
            elements["urlToImage"] != null &&
            elements["url"] != null) {
          articles.add(elements);
        }
      });
      print(articles.length);
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    // return Background(
    return Container(
      child: _loading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context, index) => BlogTile(
                          title: articles[index]["title"],
                          description: articles[index]["description"],
                          imageUrl: articles[index]["urlToImage"],
                          url: articles[index]["url"]),
                      itemCount: articles.length,
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
