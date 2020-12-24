import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:matchfinder/Utilities/Common.dart';
import 'package:matchfinder/Utilities/Function/function.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: white,
        backgroundColor: white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: greyColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Image.asset(
          'assets/logoTextBlue.png',
          width: 142,
          height: 30,
        ),
      ),
      body: Center(
        child: Text(
          'Home',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
