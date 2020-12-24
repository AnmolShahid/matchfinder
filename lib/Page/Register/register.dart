import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:matchfinder/Page/Register/dropDownCast.dart';
import 'package:matchfinder/Page/Register/dropDownCity.dart';
import 'package:matchfinder/Page/Register/login.dart';
import 'package:matchfinder/Page/Register/registerSecondStep.dart';
import 'package:matchfinder/Utilities/Common.dart';
import 'package:matchfinder/Utilities/Function/function.dart';
import 'package:matchfinder/Utilities/privacyPolicy.dart';
import 'package:matchfinder/Utilities/sharedWidget/customDrop.dart';
import 'package:matchfinder/Utilities/sharedWidget/text_field.dart';
import 'package:matchfinder/Utilities/style.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController castTextController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  String gender = "male";
  String groupValue = "male";
  bool isChristian = false;

  bool isDay = true;
  bool isMonth = true;
  bool isYear = true;
  bool isMotherTounge = true;
  bool isReligion = true;
  bool isChurch = false;
  bool isPhone = true;
  bool isRelationShip = true;
  bool isCity = true;
  bool isCountry = true;
  bool isCast = true;
  bool isDisplay = false;
  bool isLoading = false;

  String day;
  String month;
  String year;
  String city;
  String cast;
  String church;
  String motherTongue;
  String country = 'IN';
  String countryISD = '91';
  String religion;
  String relationShip = 'SELF';
  List<String> castString = <String>[];

  List<DropdownMenuItem<String>> dayDropDown = <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> monthDropDown = <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> yearDropDown = <DropdownMenuItem<String>>[];

  List<DropdownMenuItem<String>> countryDropDown = <DropdownMenuItem<String>>[];

  List<DropdownMenuItem<String>> countryISDDropDown =
      <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> religionDropDown =
      <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> churchDropDown = <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> motherTongueDropDown =
      <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> relationShipDropDown =
      <DropdownMenuItem<String>>[];

  getDateDropDown(String date) async {
    List<dynamic> res = await getDate(date);
    if (res.isNotEmpty) {
      List<dynamic> value = res.reversed.toList();
      List<DropdownMenuItem<String>> items = new List();
      for (int i = 0; i < value.length; i++) {
        setState(() {
          items.insert(
            0,
            DropdownMenuItem(
              child: Text(
                value[i][1],
              ),
              value: value[i][0],
            ),
          );
        });
      }
      return items;
    } else {
      return null;
    }
  }

  getCountryDropDown() async {
    List<dynamic> res = await getCountry();
    if (res.isNotEmpty) {
      List<dynamic> value = res.reversed.toList();
      List<DropdownMenuItem<String>> items = new List();
      for (int i = 0; i < value.length; i++) {
        setState(() {
          items.insert(
            0,
            DropdownMenuItem(
              child: Text(
                value[i][1],
              ),
              value: value[i][0],
            ),
          );
        });
      }
      return items;
    } else {
      return null;
    }
  }

  getCountryISDDropDown() async {
    List<dynamic> res = await getCountryISD();
    if (res.isNotEmpty) {
      List<dynamic> value = res.reversed.toList();
      List<DropdownMenuItem<String>> items = new List();
      for (int i = 0; i < value.length; i++) {
        setState(() {
          items.insert(
            0,
            DropdownMenuItem(
              child: Text(
                value[i][1] + ' (+' + value[i][0] + ')',
              ),
              value: value[i][0],
            ),
          );
        });
      }
      return items;
    } else {
      return null;
    }
  }

  getMotherTongueDropDown() async {
    List<dynamic> res = await getMotherTongue();
    if (res.isNotEmpty) {
      List<dynamic> value = res.reversed.toList();
      List<DropdownMenuItem<String>> items = new List();
      for (int i = 0; i < value.length; i++) {
        setState(() {
          items.insert(
            0,
            DropdownMenuItem(
              child: Text(
                value[i][1],
              ),
              value: value[i][0],
            ),
          );
        });
      }
      return items;
    } else {
      return null;
    }
  }

  getReligionDropDown() async {
    List<dynamic> res = await getReligion();
    if (res.isNotEmpty) {
      List<dynamic> value = res.reversed.toList();
      List<DropdownMenuItem<String>> items = new List();
      for (int i = 0; i < value.length; i++) {
        setState(() {
          items.insert(
            0,
            DropdownMenuItem(
              child: Text(
                value[i][1],
              ),
              value: value[i][0],
            ),
          );
        });
      }
      return items;
    } else {
      return null;
    }
  }

  getChurchDropDown() async {
    List<dynamic> res = await getChurch();
    if (res.isNotEmpty) {
      List<dynamic> value = res.reversed.toList();
      List<DropdownMenuItem<String>> items = new List();
      for (int i = 0; i < value.length; i++) {
        setState(() {
          items.insert(
            0,
            DropdownMenuItem(
              child: Text(
                value[i][1],
              ),
              value: value[i][0],
            ),
          );
        });
      }
      return items;
    } else {
      return null;
    }
  }

  getRelationShipDropDown() async {
    List<dynamic> res = await getRelationShip();
    if (res.isNotEmpty) {
      List<dynamic> value = res.reversed.toList();
      List<DropdownMenuItem<String>> items = new List();
      for (int i = 0; i < value.length; i++) {
        setState(() {
          items.insert(
            0,
            DropdownMenuItem(
              child: Text(
                value[i][1],
              ),
              value: value[i][0],
            ),
          );
        });
      }
      return items;
    } else {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    dayDropDown = await getDateDropDown('DAY');
    monthDropDown = await getDateDropDown('MONTH');
    yearDropDown = await getDateDropDown('YEAR');
    motherTongueDropDown = await getMotherTongueDropDown();
    religionDropDown = await getReligionDropDown();
    countryDropDown = await getCountryDropDown();
    relationShipDropDown = await getRelationShipDropDown();
    countryISDDropDown = await getCountryISDDropDown();
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    phone.dispose();
    password.dispose();
    if (dayDropDown.isNotEmpty) dayDropDown.clear();
    if (yearDropDown.isNotEmpty) yearDropDown.clear();
    if (monthDropDown.isNotEmpty) monthDropDown.clear();
    if (churchDropDown.isNotEmpty) churchDropDown.clear();
    if (countryDropDown.isNotEmpty) countryDropDown.clear();
    if (religionDropDown.isNotEmpty) religionDropDown.clear();
    if (countryISDDropDown.isNotEmpty) countryISDDropDown.clear();
    if (relationShipDropDown.isNotEmpty) relationShipDropDown.clear();
    if (motherTongueDropDown.isNotEmpty) motherTongueDropDown.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        shadowColor: appColor,
        backgroundColor: appColor,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Image.asset(
          'assets/logowhite.png',
          // width: 142,
          height: 50,
        ),
        actions: [
          InkWell(
            onTap: () {
              changeScreen(context, Login());
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Login',
                  style: smallWhiteTextStyle,
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: white,
                  size: 20,
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
        ],
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : Container(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: greyColor,
                              width: 1,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 36,
                            horizontal: 100,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  'Most Affordable Matrimony Site in India',
                                  textAlign: TextAlign.center,
                                  style: regularAppColorTextStyle,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          color: backGroundColor,
                          padding: EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 18,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Create Account',
                                      textAlign: TextAlign.start,
                                      style: headingAppColorTextStyle,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              TextFieldCustom(
                                controller: email,
                                style: miniGreyTextStyle,
                                labelText: 'Your Email ID',
                                inputType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter your Email';
                                  }
                                  return null;
                                },
                              ),
                              TextFieldCustom(
                                controller: password,
                                style: miniGreyTextStyle,
                                labelText: 'Choose Password',
                                obscureText: true,
                                maxLines: 1,
                                inputType: TextInputType.text,
                                validator: (value) {
                                  if (value.length < 4 || value.length > 20) {
                                    return 'Password must between 4 to 20 characters';
                                  } else if (value.isEmpty) {
                                    return 'Please enter your Password';
                                  }
                                  return null;
                                },
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Bride or Groom Details',
                                      textAlign: TextAlign.start,
                                      style: headingAppColorTextStyle,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 27,
                              ),
                              TextFieldCustom(
                                controller: name,
                                style: miniGreyTextStyle,
                                labelText: 'Name',
                                inputType: TextInputType.text,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter your Name';
                                  }
                                  return null;
                                },
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Gender',
                                      textAlign: TextAlign.start,
                                      style: miniGreyFontWeightStyle,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: ListTile(
                                      title: Text(
                                        "Male",
                                        textAlign: TextAlign.end,
                                        style: miniGreyTextStyle,
                                      ),
                                      trailing: Radio(
                                        value: "male",
                                        groupValue: groupValue,
                                        onChanged: (e) => valueChanged(e),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListTile(
                                      title: Text(
                                        "Female",
                                        textAlign: TextAlign.end,
                                        style: miniGreyTextStyle,
                                      ),
                                      trailing: Radio(
                                        value: "female",
                                        groupValue: groupValue,
                                        onChanged: (e) => valueChanged(e),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Date of Birth',
                                      textAlign: TextAlign.start,
                                      style: miniGreyFontWeightStyle,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomDropDown(
                                      heading: null,
                                      hint: 'Day',
                                      value: day,
                                      items: dayDropDown,
                                      onChanged: (value) {
                                        setState(() {
                                          isDay = false;
                                          day = value;
                                        });
                                        print('changed to $value');
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: CustomDropDown(
                                      heading: null,
                                      hint: 'Month',
                                      value: month,
                                      items: monthDropDown,
                                      onChanged: (value) {
                                        setState(() {
                                          isMonth = false;
                                          month = value;
                                        });
                                        print('changed to $value');
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: CustomDropDown(
                                      heading: null,
                                      hint: 'Year',
                                      value: year,
                                      items: yearDropDown,
                                      onChanged: (value) {
                                        setState(() {
                                          isYear = false;
                                          year = value;
                                        });
                                        print('changed to $value');
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              CustomDropDown(
                                heading: 'Mother Tongue',
                                hint: 'Select',
                                value: motherTongue,
                                items: motherTongueDropDown,
                                onChanged: (value) {
                                  setState(() {
                                    isMotherTounge = false;
                                    motherTongue = value;
                                  });
                                  print('changed to $value');
                                },
                              ),
                              CustomDropDown(
                                heading: 'Religion',
                                hint: 'Select',
                                value: religion,
                                items: religionDropDown,
                                onChanged: (value) async {
                                  setState(() {
                                    isReligion = false;
                                    religion = value;
                                  });
                                  if (religion == '62') {
                                    setState(() {
                                      isChurch = true;
                                      isChristian = true;
                                    });
                                    churchDropDown = await getChurchDropDown();
                                  } else {
                                    setState(() {
                                      isChristian = false;
                                    });
                                  }
                                },
                              ),
                              InkWell(
                                onTap: () {
                                  changeScreen(
                                      context,
                                      DropDownCast(
                                        keyScaffold: _key,
                                        onSelect: (value) {
                                          if (value.isNotEmpty) {
                                            setState(() {
                                              cast = value;
                                              isCast = false;
                                            });
                                            print(cast);
                                          }
                                        },
                                      ));
                                },
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Caste',
                                            textAlign: TextAlign.start,
                                            style: miniGreyFontWeightStyle,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 15,
                                        horizontal: 15,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: borderColorField,
                                          width: 1,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            cast != null
                                                ? cast
                                                : 'Your Community',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: cast != null
                                                  ? Colors.black
                                                  : greyTextField,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              isChristian
                                  ? CustomDropDown(
                                      heading: 'Church',
                                      hint: '',
                                      value: church,
                                      items: churchDropDown,
                                      onChanged: (value) {
                                        setState(() {
                                          isChurch = false;
                                          church = value;
                                        });
                                        print('changed to $value');
                                      },
                                    )
                                  : Container(),
                              CustomDropDown(
                                heading: 'Country living in',
                                hint: '',
                                value: country,
                                items: countryDropDown,
                                onChanged: (value) async {
                                  print('changed to $value');
                                  setState(() {
                                    isCountry = false;
                                    country = value;
                                  });
                                },
                              ),
                              InkWell(
                                onTap: () {
                                  changeScreen(
                                      context,
                                      DropDownCity(
                                        keyScaffold: _key,
                                        onSelect: (value) {
                                          if (value.isNotEmpty) {
                                            setState(() {
                                              city = value;
                                              isCity = false;
                                            });
                                            print(city);
                                          }
                                        },
                                      ));
                                },
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'City',
                                            textAlign: TextAlign.start,
                                            style: miniGreyFontWeightStyle,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 15,
                                        horizontal: 15,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: borderColorField,
                                          width: 1,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            city != null
                                                ? city
                                                : 'City Living In',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: city != null
                                                  ? Colors.black
                                                  : greyTextField,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Your Contact Details',
                                      textAlign: TextAlign.start,
                                      style: headingAppColorTextStyle,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              CustomDropDown(
                                heading: 'Your Relationship',
                                hint: '',
                                value: relationShip,
                                items: relationShipDropDown,
                                onChanged: (value) {
                                  setState(() {
                                    isRelationShip = false;
                                    relationShip = value;
                                  });
                                  print('changed to $value');
                                },
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CustomDropDown(
                                    heading: 'Your Phone Number',
                                    hint: '',
                                    value: countryISD,
                                    items: countryISDDropDown,
                                    onChanged: (value) {
                                      setState(() {
                                        isPhone = false;
                                        countryISD = value.toString();
                                      });
                                      print('changed to $value');
                                    },
                                  ),
                                  TextFieldCustom(
                                    controller: phone,
                                    style: miniGreyTextStyle,
                                    labelText: 'Your Phone No',
                                    inputType: TextInputType.phone,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter your Phone No';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                              MaterialButton(
                                onPressed: () {
                                  register();
                                },
                                color: appColor,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Submit',
                                      style: miniWhiteTextStyle,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              RichText(
                                text: TextSpan(
                                  text:
                                      'By choosing to continue, you agree to our ',
                                  style: miniGreyTextStyle,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'Terms & Conditions',
                                      style: miniAppColorTextStyle,
                                    ),
                                    TextSpan(
                                      text: ' , ',
                                      style: miniGreyTextStyle,
                                    ),
                                    TextSpan(
                                      text: 'Privacy Policy',
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          changeScreen(
                                              context, PrivacyPolicy());
                                        },
                                      style: miniAppColorTextStyle,
                                    ),
                                    TextSpan(
                                      text: ' and ',
                                      style: miniGreyTextStyle,
                                    ),
                                    TextSpan(
                                      text: 'Membership Plans',
                                      style: miniAppColorTextStyle,
                                    ),
                                    TextSpan(
                                      text: '.',
                                      style: miniGreyTextStyle,
                                    ),
                                  ],
                                ),
                              ),
                              isDisplay
                                  ? Column(
                                      children: [
                                        isDay
                                            ? displayError('Please select Day')
                                            : Container(),
                                        isMonth
                                            ? displayError(
                                                'Please select Month')
                                            : Container(),
                                        isYear
                                            ? displayError('Please select Year')
                                            : Container(),
                                        isMotherTounge
                                            ? displayError(
                                                'Please select Mother Tongue')
                                            : Container(),
                                        isChurch
                                            ? displayError(
                                                'Please select Church')
                                            : Container(),
                                        isReligion
                                            ? displayError(
                                                'Please select Religion')
                                            : Container(),
                                        isPhone
                                            ? displayError(
                                                'Please select Phone Code')
                                            : Container(),
                                        isRelationShip
                                            ? displayError(
                                                'Please select Relationship')
                                            : Container(),
                                        isCity
                                            ? displayError('Please select City')
                                            : Container(),
                                        isCountry
                                            ? displayError(
                                                'Please select Country')
                                            : Container(),
                                        isCast
                                            ? displayError(
                                                'Please select Caste')
                                            : Container(),
                                      ],
                                    )
                                  : Container(),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  valueChanged(e) {
    setState(() {
      if (e == "male") {
        groupValue = e;
        gender = e;
      } else if (e == "female") {
        groupValue = e;
        gender = e;
      }
    });
  }

  displayError(String error) {
    return Column(
      children: [
        SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                error,
                style: miniRedTextStyle,
              ),
            ),
          ],
        ),
      ],
    );
  }

  register() async {
    if (_formKey.currentState.validate() &&
        !isCity &&
        !isCast &&
        !isReligion &&
        !isMotherTounge &&
        !isYear &&
        !isMonth &&
        !isDay &&
        !isChurch) {
      String nameValue = name.text.trim();
      // List<String> value = nameValue.split(' ');
      setState(() {
        isLoading = true;
        isDisplay = false;
      });
      Response response = await signUp(
        email: email.text.trim(),
        password: password.text.trim(),
        name:
            // value[0] != null
            //     ? value[0]
            //     :
            nameValue,
        lastName:
            // value.length > 1 ? value[1] :
            '',
        gender: gender,
        day: day,
        month: month,
        year: year,
        motherTongue: motherTongue,
        religion: religion,
        cast: cast,
        country: country,
        relationShip: relationShip,
        countryISD: countryISD,
        phone: phone.text.trim(),
      );
      setState(() {
        isLoading = false;
      });
      if (response.data['reqstatus'] == 'success') {
        _key.currentState
            .showSnackBar(
              snackBar(
                'User Registered',
                Colors.green,
                Icons.verified_user,
              ),
            )
            .closed
            .then((value) => changeScreen(context, RegisterSecond()));
      } else {
        setState(() {
          isDisplay = true;
        });
        _key.currentState.showSnackBar(
          snackBar(
            'Please enter correct information',
            Colors.red,
            Icons.security,
          ),
        );
      }
    } else {
      setState(() {
        isDisplay = true;
      });
    }
  }
}
