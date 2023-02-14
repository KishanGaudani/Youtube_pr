import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:you_tube_pr/viiews/screens/home.dart';
import 'package:you_tube_pr/viiews/screens/play.dart';
import 'package:you_tube_pr/viiews/screens/search.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => Home(),
        "search_page": (context) => const Search(),
        "player_page": (context) => const Play(),
      },
    ),
  );
}
