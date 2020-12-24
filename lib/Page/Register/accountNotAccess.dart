import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:matchfinder/Utilities/Common.dart';
import 'package:matchfinder/Utilities/Function/function.dart';
import 'package:matchfinder/Utilities/sharedWidget/text_field.dart';
import 'package:matchfinder/Utilities/style.dart';

class AccountNotAccess extends StatefulWidget {
  @override
  _AccountNotAccessState createState() => _AccountNotAccessState();
}

class _AccountNotAccessState extends State<AccountNotAccess> {
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  TextEditingController email = TextEditingController();
  int groupValue = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    email.text = 'lovvlykate@gmail.com';
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
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : Form(
                key: _formKey,
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 38,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Spacer(),
                      Text(
                        'What problem do you have with your account?',
                        textAlign: TextAlign.center,
                        style: headingAppColorRegularStyle,
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 0,
                            groupValue: groupValue,
                            onChanged: (e) => valueChanged(e),
                          ),
                          Column(
                            children: [
                              Text(
                                "I have problem with my password",
                                textAlign: TextAlign.start,
                                style: miniGreyTextStyle,
                              ),
                            ],
                          ),
                        ],
                      ),
                      groupValue == 0
                          ? Container(
                              margin: EdgeInsets.only(
                                left: 20,
                              ),
                              child: TextFieldCustom(
                                controller: email,
                                style: miniGreyTextStyle,
                                labelText:
                                    'Enter Email ID or 10 Digit Phone No.',
                                inputType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Email field is Empty';
                                  }
                                  return null;
                                },
                              ),
                            )
                          : Container(),
                      Row(
                        children: [
                          Radio(
                            value: 1,
                            groupValue: groupValue,
                            onChanged: (e) => valueChanged(e),
                          ),
                          Column(
                            children: [
                              Text(
                                "I forgot my User Id",
                                textAlign: TextAlign.start,
                                style: miniGreyTextStyle,
                              ),
                            ],
                          ),
                        ],
                      ),
                      groupValue == 1
                          ? Container(
                              margin: EdgeInsets.only(
                                left: 20,
                              ),
                              child: RichText(
                                text: TextSpan(
                                  text:
                                      "Your User Id is your Email Id or matchfinder.in Id"
                                      "If you don't remember your Email Id, please contact our ",
                                  style: miniGreyTextStyle,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'Customer Care',
                                      style: miniAppColorUnderLineStyle,
                                    ),
                                    TextSpan(
                                      text: ' or write to ',
                                      style: miniGreyTextStyle,
                                    ),
                                    TextSpan(
                                      text: 'info@matchfinder.in',
                                      style: miniGreyFontWeightStyle,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container(),
                      SizedBox(
                        height: 40,
                      ),
                      MaterialButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            Response response =
                                await resetMail(email.text.trim());
                            setState(() {
                              isLoading = false;
                            });
                            print(response.data);
                            if (response.data['reqstatus'] == 'success') {
                              _key.currentState.showSnackBar(
                                snackBar(
                                  response.data['message'],
                                  Colors.green,
                                  Icons.verified_user,
                                ),
                              );
                            } else {
                              _key.currentState.showSnackBar(
                                snackBar(
                                  'Invalid Email Id',
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
                            'Submit',
                            textAlign: TextAlign.center,
                            style: miniWhiteTextStyle,
                          ),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  valueChanged(e) {
    setState(() {
      if (e == 0) {
        groupValue = e;
      } else if (e == 1) {
        groupValue = e;
      }
    });
  }
}
