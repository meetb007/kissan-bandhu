import 'package:flutter/material.dart';
import 'package:frontend/Screens/Farmer/src/pages/grocery/tabs/articles.dart';

class BlogTile extends StatelessWidget {
  final String imageUrl, title, description, url;
  BlogTile({this.imageUrl, this.title, this.description, this.url});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticlesView(
              url: url,
            ),
          ),
        );
      },
      child: Container(
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image(
                fit: BoxFit.cover,
                height: 250,
                width: double.infinity,
                image: NetworkImage(imageUrl),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 5,
            ),
            Text(description,
                style: TextStyle(
                  color: Colors.grey,
                ),
                textAlign: TextAlign.justify),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
