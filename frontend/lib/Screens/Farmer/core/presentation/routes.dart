import 'package:flutter/material.dart';
import 'package:frontend/Screens/Buyer/core/data/models/menu.dart';
import 'package:frontend/Screens/Buyer/src/pages/grocery/ghome.dart';

final List<dynamic> pages = [
  MenuItem(
      title: "UI Kits (Clones)",
      items: [
        SubMenuItem("Grocery UI Kit", GroceryHomePage(),
            path: GroceryHomePage.path),
      ],
      icon: Icons.account_balance_wallet),
];

SubMenuItem getItemForKey(String key) {
  SubMenuItem item;
  List<dynamic> pag = List<dynamic>.from(pages);
  pag.forEach((page) {
    if (page is SubMenuItem && page.title == key) {
      item = page;
    } else if (page is MenuItem) {
      page.items.forEach((sub) {
        if (sub.title == key) item = sub;
      });
    }
  });
  return item;
}
