import 'package:flutter/material.dart';
import 'package:matchfinder/Page/MainScreen/mainScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContexcontext) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Matchfinder',
      home: MainScreen(),
    );
  }
}
