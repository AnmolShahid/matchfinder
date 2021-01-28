import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:matchfinder/Page/Home/home.dart';
import 'package:matchfinder/Page/Payment/upgradePayment.dart';
import 'package:matchfinder/Page/Register/accountNotAccess.dart';
import 'package:matchfinder/Page/Register/register.dart';
import 'package:matchfinder/Utilities/Common.dart';
import 'package:matchfinder/Utilities/Function/function.dart';
import 'package:matchfinder/Utilities/sharedWidget/text_field.dart';
import 'package:matchfinder/Utilities/style.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    email.text = 'test_india';
    password.text = '123456';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        shadowColor: appColor,
        backgroundColor: appColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Image.asset(
          'assets/logowhite.png',
          // width: 142,
          height: 50,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 33,
        ),
        child: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Spacer(),
                      Text(
                        'Login here',
                        style: headingGreyTextStyle,
                      ),
                      Spacer(),
                      TextFieldCustom(
                        controller: email,
                        style: miniGreyTextStyle,
                        labelText: '10 Digit Mobile or Email',
                        inputType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Email field is Empty';
                          }
                          return null;
                        },
                      ),
                      TextFieldCustom(
                        controller: password,
                        style: miniGreyTextStyle,
                        labelText: 'Password',
                        obscureText: true,
                        maxLines: 1,
                        inputType: TextInputType.text,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Password field is Empty';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 33,
                      ),
                      InkWell(
                        onTap: () {
                          changeScreen(context, AccountNotAccess());
                        },
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "I can't access my account",
                                textAlign: TextAlign.end,
                                style: miniAppColorUnderLineStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 33,
                      ),
                      MaterialButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            Response response = await login(
                                email.text.trim(), password.text.trim());
                            setState(() {
                              isLoading = false;
                            });
                            if (response.data['reqstatus'] == 'success') {
                              _key.currentState
                                  .showSnackBar(
                                    snackBar(
                                      'Login Successfully',
                                      Colors.green,
                                      Icons.verified_user,
                                    ),
                                  )
                                  .closed
                                  .then(
                                      (value) => changeScreen(context, UpgradePayment()));
                            } else {
                              _key.currentState.showSnackBar(
                                snackBar(
                                  response.data['validationerrors'],
                                  Colors.red,
                                  Icons.security,
                                ),
                              );
                            }
                          }
                        },
                        color: appColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(23.0),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 69,
                          ),
                          child: Text(
                            'Login',
                            textAlign: TextAlign.center,
                            style: miniWhiteTextStyle,
                          ),
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          changeScreen(context, Register());
                        },
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Don't have an account? Sign Up Free",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
