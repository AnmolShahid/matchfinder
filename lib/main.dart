import 'package:flutter/material.dart';
import 'package:matchfinder/Page/MainScreen/mainScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Match Finder',
      home: MainScreen(),
    );
  }
}
