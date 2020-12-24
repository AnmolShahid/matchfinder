import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:matchfinder/Page/Register/dropDownCateMultiple.dart';
import 'package:matchfinder/Page/Register/registerThirdPicture.dart';
import 'package:matchfinder/Utilities/Common.dart';
import 'package:matchfinder/Utilities/Function/function.dart';
import 'package:matchfinder/Utilities/Function/url.dart';
import 'package:matchfinder/Utilities/sharedWidget/customDrop.dart';
import 'package:matchfinder/Utilities/sharedWidget/employedIn.dart';
import 'package:matchfinder/Utilities/sharedWidget/text_field.dart';
import 'package:matchfinder/Utilities/style.dart';

class RegisterSecond extends StatefulWidget {
  @override
  _RegisterSecondState createState() => _RegisterSecondState();
}

class _RegisterSecondState extends State<RegisterSecond> {
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  TextEditingController otherDegree = TextEditingController();
  TextEditingController occupation = TextEditingController();
  TextEditingController annual = TextEditingController();
  TextEditingController preferredCaste = TextEditingController();

  String groupValue;

  bool isLoading = false;
  bool isMartialStatus = true;
  bool isAnnualIncome = true;
  bool isHeight = true;
  bool isDisplay = false;
  bool isHighestEducation = true;

  String martialStatus;
  String annualIncome;
  String height;
  String highestEducation;
  String profileCastes;
  List<dynamic> casteList = [];
  List<dynamic> defaultCasteValue = [];
  List<DropdownMenuItem<String>> martialStatusDropDown =
      <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> heightDropDown = <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> highestEducationDropDown =
      <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> annualIncomeDropDown =
      <DropdownMenuItem<String>>[];

  getMartialStatusDropDown(param0, String martial) async {
    List<dynamic> res = await param0;
    if (res.isNotEmpty) {
      List<dynamic> value = res.reversed.toList();
      List<DropdownMenuItem<String>> items = new List();
      for (int i = 0; i < value.length; i++) {
        setState(() {
          if (value[i][0] == martial) {
            martialStatus = value[i][0];
          }
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

  getHeightDropDown(param0) async {
    List<dynamic> res = await param0;
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

  getHighestEducationDropDown(param0) async {
    List<dynamic> res = await param0;
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

  getAnnualIncomeDropDown(param0, String anualIncome) async {
    List<dynamic> res = await param0;
    if (res.isNotEmpty) {
      List<dynamic> value = res.reversed.toList();
      List<DropdownMenuItem<String>> items = new List();
      for (int i = 0; i < value.length; i++) {
        setState(() {
          if (value[i][0] == anualIncome) {
            annualIncome = value[i][0];
          }
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
    try {
      var value = getSession();
      if (value != null) {
        Response response = await getDetails();
        if (await response.data != null) {
          String anualIncome, martial;
          martial = await response.data['profileMaritalStatus'] != null
              ? await response.data['profileMaritalStatus'].toUpperCase()
              : '';
          anualIncome = await response.data['defaultCurrency'] != null
              ? await response.data['defaultCurrency']
              : '';
          profileCastes = await response.data['profileCastes'] != null
              ? await response.data['profileCastes']
              : '';

          if (await response.data['maritalStatusCode'] != null) {
            martialStatusDropDown = await getMartialStatusDropDown(
                await response.data['maritalStatusCode'], martial);
          }
          if (await response.data['heightCode'] != null) {
            heightDropDown =
                await getHeightDropDown(await response.data['heightCode']);
          }
          if (await response.data['degreeCode'] != null) {
            highestEducationDropDown = await getHighestEducationDropDown(
                await response.data['degreeCode']);
          }
          if (await response.data['currenciesList'] != null) {
            annualIncomeDropDown = await getAnnualIncomeDropDown(
                await response.data['currenciesList'], anualIncome);
          }

          var casteDefault = profileCastes.split(",");
          await getC();
          if (casteList.isNotEmpty) {
            for (int i = 0; i < casteList.length; i++) {
              if (casteList[i][0] == casteDefault[0]) {
                addValue(casteList[i]);
              }
              if (casteList[i][0] == casteDefault[1]) {
                addValue(casteList[i]);
              }
              if (casteList[i][0] == casteDefault[2]) {
                addValue(casteList[i]);
              }
            }
          }
        }
      } else {
        print('No cache value');
        Navigator.pop(context);
      }
    } catch (e) {}
  }

  getC() async {
    try {
      if (casteList.isEmpty) {
        Response caste = await getCaste();
        if (caste.data != null) {
          casteList = await caste.data['casteList'];
        }
      }
    } catch (e) {}
  }

  addValue(casteList) {
    setState(() {
      defaultCasteValue.add(casteList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
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
          Row(
            children: [
              roundCircle(
                '1',
                borderColorField,
                miniWhiteTextStyle,
              ),
              Container(
                width: 10,
                child: Divider(
                  color: borderColorField,
                  thickness: 2,
                ),
              ),
              roundCircle(
                '2',
                white,
                miniGreyColorStyle,
              ),
              Container(
                width: 10,
                child: Divider(
                  color: borderColorField,
                  thickness: 2,
                ),
              ),
              roundCircle(
                '3',
                borderColorField,
                miniWhiteTextStyle,
              ),
              SizedBox(
                width: 15,
              ),
            ],
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              margin: EdgeInsets.symmetric(horizontal: 8.5),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 30,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                'Just a few more steps!\n Please add your education & career details:',
                                textAlign: TextAlign.center,
                                style: miniGreyColorStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: borderColorField,
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              '* Mandatory',
                              textAlign: TextAlign.end,
                              style: miniGreyColorStyle,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Personal Details',
                                    textAlign: TextAlign.start,
                                    style: headingAppColorRegularStyle,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            CustomDropDown(
                              heading: 'Marital Status',
                              hint: '',
                              value: martialStatus,
                              items: martialStatusDropDown,
                              onChanged: (value) {
                                setState(() {
                                  martialStatus = value;
                                  isMartialStatus = false;
                                });
                              },
                            ),
                            CustomDropDown(
                              heading: 'Height',
                              hint: 'Feet In',
                              value: height,
                              items: heightDropDown,
                              onChanged: (value) {
                                setState(() {
                                  height = value;
                                  isHeight = false;
                                });
                              },
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Education and Employment',
                                    textAlign: TextAlign.start,
                                    style: headingAppColorRegularStyle,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            CustomDropDown(
                              heading: 'Highest Education',
                              hint: '',
                              value: highestEducation,
                              items: highestEducationDropDown,
                              onChanged: (value) {
                                setState(() {
                                  highestEducation = value.toString();
                                  isHighestEducation = false;
                                });
                              },
                            ),
                            TextFieldCustom(
                              controller: otherDegree,
                              style: miniGreyTextStyle,
                              labelText: 'Any Other Degrees',
                              inputType: TextInputType.text,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter your Degree';
                                }
                                return null;
                              },
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Employed in:',
                                    textAlign: TextAlign.start,
                                    style: miniGreyFontWeightStyle,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                EmployedIn(
                                  value: 'GOV',
                                  groupValue: groupValue,
                                  onChange: (e) => valueChanged(e),
                                  text: 'Government Job',
                                ),
                                EmployedIn(
                                  value: 'PVT',
                                  groupValue: groupValue,
                                  onChange: (e) => valueChanged(e),
                                  text: 'Private Job',
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                EmployedIn(
                                  value: 'OWN',
                                  groupValue: groupValue,
                                  onChange: (e) => valueChanged(e),
                                  text: 'Own Business',
                                ),
                                EmployedIn(
                                  value: 'NW',
                                  groupValue: groupValue,
                                  onChange: (e) => valueChanged(e),
                                  text: 'Not Working',
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                EmployedIn(
                                  value: 'JT',
                                  groupValue: groupValue,
                                  onChange: (e) => valueChanged(e),
                                  text: 'Job Trial',
                                ),
                                EmployedIn(
                                  value: 'SP',
                                  groupValue: groupValue,
                                  onChange: (e) => valueChanged(e),
                                  text: 'Sports Person',
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                EmployedIn(
                                  value: 'OT',
                                  groupValue: groupValue,
                                  onChange: (e) => valueChanged(e),
                                  text: 'Others',
                                ),
                              ],
                            ),
                            TextFieldCustom(
                              controller: occupation,
                              style: miniGreyTextStyle,
                              labelText: 'Occupation:',
                              inputType: TextInputType.text,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter your occupation';
                                }
                                return null;
                              },
                            ),
                            TextFieldCustom(
                              controller: annual,
                              style: miniGreyTextStyle,
                              labelText: 'Your Annual Income:',
                              suffixIconData: Icons.help_outline,
                              sufixIconColor: borderColorField,
                              onTapSuffixIcon: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: greyColor.withOpacity(
                                        0.95,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(
                                            20.0,
                                          ),
                                        ),
                                      ),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'Your income will be used for '
                                            'matchmaking. You can hide your '
                                            'income from others using '
                                            'Privacy Settings.',
                                            style: extraMiniWhiteColorStyle,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              inputType: TextInputType.text,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter your annual Income';
                                }
                                return null;
                              },
                            ),
                            CustomDropDown(
                              heading: null,
                              hint: '',
                              value: annualIncome,
                              items: annualIncomeDropDown,
                              onChanged: (value) {
                                setState(() {
                                  annualIncome = value;
                                  isAnnualIncome = false;
                                });
                              },
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    'My Preferred Castes',
                                    textAlign: TextAlign.start,
                                    style: headingAppColorRegularStyle,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            InkWell(
                              onTap: () {
                                changeScreen(
                                  context,
                                  DropDownCasteMultiple(
                                    keyScaffold: _key,
                                    onSelect: (value) {
                                      if (value.isNotEmpty) {
                                        if (defaultCasteValue.contains(value)) {
                                          setState(() {
                                            defaultCasteValue.remove(value);
                                          });
                                          print(value);
                                        } else {
                                          setState(() {
                                            defaultCasteValue.add(value);
                                          });
                                          print(value);
                                        }
                                      }
                                    },
                                    defaultValue: defaultCasteValue,
                                    casteList: casteList,
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Preferred Caste:',
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
                                      vertical: 5,
                                      horizontal: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: borderColorField,
                                        width: 1,
                                      ),
                                    ),
                                    height: 200,
                                    child: GridView.builder(
                                      itemCount: defaultCasteValue != null
                                          ? defaultCasteValue.length
                                          : 0,
                                      shrinkWrap: true,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 5.0,
                                        mainAxisSpacing: 5.0,
                                        childAspectRatio: 1.9,
                                      ),
                                      physics: BouncingScrollPhysics(),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return InkWell(
                                          onTap: () {},
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: borderColorField,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 5,
                                            ),
                                            child: Stack(
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            defaultCasteValue[
                                                                    index][1]
                                                                .toString(),
                                                            maxLines: 2,
                                                            textAlign: TextAlign
                                                                .center,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                miniGreyColorStyle,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Positioned(
                                                  top: 0,
                                                  right: 0,
                                                  child: InkWell(
                                                    onTap: () {
                                                      print('Reach');
                                                      setState(() {
                                                        defaultCasteValue.remove(
                                                            defaultCasteValue[
                                                                index]);
                                                      });
                                                    },
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      50,
                                                    ),
                                                    child: Container(
                                                      // color: red,
                                                      height: 30,
                                                      width: 30,
                                                      child: Icon(
                                                        Icons.clear,
                                                        size: 20,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            MaterialButton(
                              onPressed: () async {
                                if (groupValue != null &&
                                    !isHeight &&
                                    !isHighestEducation &&
                                    occupation.text.isNotEmpty) {
                                  setState(() {
                                    isDisplay = false;
                                  });
                                  if (groupValue == 'GOV' ||
                                      groupValue == 'PVT') {
                                    if (annual.text.isNotEmpty) {
                                      uploadData();
                                    } else {
                                      _key.currentState.showSnackBar(
                                        snackBar(
                                          'Enter your annual income',
                                          Colors.red,
                                          Icons.verified_user,
                                        ),
                                      );
                                    }
                                  } else {
                                    uploadData();
                                  }
                                } else {
                                  _key.currentState.showSnackBar(
                                    snackBar(
                                      'Enter correct information',
                                      Colors.red,
                                      Icons.verified_user,
                                    ),
                                  );
                                  setState(() {
                                    isDisplay = true;
                                  });
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
                                  'Continue',
                                  textAlign: TextAlign.center,
                                  style: miniWhiteTextStyle,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            isDisplay
                                ? Column(
                                    children: [
                                      isHighestEducation
                                          ? displayError(
                                              'Please select Highest Education')
                                          : Container(),
                                      isHeight
                                          ? displayError('Please select Height')
                                          : Container(),
                                      SizedBox(
                                        height: 15,
                                      ),
                                    ],
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  valueChanged(e) {
    setState(() {
      if (e == "GOV") {
        groupValue = e;
      } else if (e == "PVT") {
        groupValue = e;
      } else if (e == "OWN") {
        groupValue = e;
      } else if (e == "NW") {
        groupValue = e;
      } else if (e == "JT") {
        groupValue = e;
      } else if (e == "SP") {
        groupValue = e;
      } else if (e == "OT") {
        groupValue = e;
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

  uploadData() async {
    setState(() {
      isLoading = true;
    });
    await submitData(
        UrlLinks.submitMaritalStatus, {'marstatusbd': martialStatus});
    await submitData(UrlLinks.submitHeight, {'heightfeetpd': height});
    await submitData(UrlLinks.submitCaste, {'caste': defaultCasteValue});
    await submitData(UrlLinks.submitSecondRegistrationUrl, {
      'highdeged': highestEducation,
      'spedeged': otherDegree.text.trim(),
      'emplinpd': groupValue,
      'speoccued': occupation.text.trim(),
      'salarypd': annual.text.trim(),
      'currencypd': annualIncome
    });
    _key.currentState
        .showSnackBar(
          snackBar(
            'Data uploaded',
            Colors.green,
            Icons.verified_user,
          ),
        )
        .closed
        .then((value) => changeScreen(context, RegisterThird()));
    setState(() {
      isLoading = false;
    });
  }
}