import 'package:flutter/material.dart';
import 'package:matchfinder/Page/Register/login.dart';
import 'package:matchfinder/Page/Register/register.dart';
import 'package:matchfinder/Utilities/Common.dart';
import 'package:matchfinder/Utilities/style.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 1.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(
                      100,
                    ),
                    bottomRight: Radius.circular(
                      100,
                    ),
                  ),
                  color: white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Spacer(),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Most Affordable Matrimony',
                          style: headingItalicTextStyle,
                        ),
                      ],
                    ),
                    Spacer(),
                    Image.asset(
                      'assets/drum.png',
                      height: 167,
                    ),
                    Spacer(),
                    Text(
                      'New User?',
                      style: headingAppColorTextStyle,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        changeScreen(context, Register());
                      },
                      borderRadius: BorderRadius.circular(
                        24,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            24,
                          ),
                          color: appColor,
                        ),
                        margin: EdgeInsets.only(
                          bottom: 30,
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 53),
                        child: Text(
                          'Register Here',
                          style: headingWhiteTextStyle,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              50,
                            ),
                            color: HexColor('EEECEC'),
                          ),
                          margin: EdgeInsets.only(
                            bottom: 30,
                            right: 10,
                          ),
                          padding: EdgeInsets.all(
                            10,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              50,
                            ),
                            color: HexColor('D1CECE'),
                          ),
                          margin: EdgeInsets.only(
                            bottom: 30,
                            right: 10,
                          ),
                          padding: EdgeInsets.all(
                            10,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              50,
                            ),
                            color: HexColor('D1CECE'),
                          ),
                          margin: EdgeInsets.only(
                            bottom: 30,
                            right: 10,
                          ),
                          padding: EdgeInsets.all(
                            10,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              50,
                            ),
                            color: HexColor('D1CECE'),
                          ),
                          margin: EdgeInsets.only(
                            bottom: 30,
                          ),
                          padding: EdgeInsets.all(
                            10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        changeScreen(context, Login());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
                            style: smallWhiteTextStyle,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                24,
                              ),
                              border: Border.all(
                                color: white,
                                width: 1,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 25),
                            child: Text(
                              'Login',
                              style: smallWhiteTextStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
