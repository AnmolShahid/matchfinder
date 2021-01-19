import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:matchfinder/Page/Register/dropDownCateMultiple.dart';
import 'package:matchfinder/Page/Register/registerThirdPicture.dart';
import 'package:matchfinder/Utilities/Common.dart';
import 'package:matchfinder/Utilities/Function/function.dart';
import 'package:matchfinder/Utilities/Function/url.dart';
import 'package:matchfinder/Utilities/sharedWidget/customDrop.dart';
import 'package:matchfinder/Utilities/sharedWidget/employedIn.dart';
import 'package:matchfinder/Utilities/sharedWidget/text_field.dart';
import 'package:matchfinder/Utilities/style.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';


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
  bool isAnnualIncome = false;
  bool isHeight = false;
  bool isDisplay = false;
  bool isHighestEducation = false;

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

  String textAnnual = 'Your Annual Income ';

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
          if(value[i][2]=="N"){
               items.insert(
            0,
            DropdownMenuItem(
              child: Text(
                value[i][1],
              ),
              value: value[i][0],
            ),
          );

          }else{
               items.insert(
            0,
            DropdownMenuItem(
              child: Text(
                value[i][1],
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
              ),
              value: value[i][0],

            ),
          );

          }
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

FocusNode focusNodeIncome;
FocusNode focusNodeOccupation;

  @override
  void initState() {
    super.initState();
    getData();
     focusNodeIncome = new FocusNode();
     focusNodeOccupation = new FocusNode();

  // listen to focus changes
  focusNodeOccupation.addListener(() => print('focusNode updated: hasFocus: ${focusNodeIncome.hasFocus}')); 

  // listen to focus changes
  focusNodeIncome.addListener(() => print('focusNode updated: hasFocus: ${focusNodeOccupation.hasFocus}')); 

  }
  void setFocus(focusNode) {
  FocusScope.of(context).requestFocus(focusNode);
  }
@override
  void dispose() {
    focusNodeOccupation.dispose();
    focusNodeIncome.dispose();
    super.dispose();
  }
YYDialog YYAlertDialogBody() {
  return 
  
  YYDialog().build()
    ..width = 240
    ..borderRadius = 4.0
    ..gravity = Gravity.right
    ..gravityAnimationEnable = true
    ..widget(
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
     
    )
    ..show(
       
    );
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
    YYDialog.init(context);
    return Scaffold(
      backgroundColor: white,
      key: _key,
      appBar: AppBar(
        shadowColor: appColor,
        backgroundColor: appColor,
        automaticallyImplyLeading: false,
        // leading: IconButton(
        //   icon: Icon(
        //     Icons.arrow_back,
        //     color: white,
        //   ),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
      //  centerTitle: true,
      //  ClipPath(
      //       clipper: TriangleClipper(),
      //       child: Container(
      //         color: Colors.white,
      //         height: 10,
      //         width: 20,
      //       ),
      //     )
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
                 roundCirclePresent(
                '2',
                white,miniGreyColorStyle,
               

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
                              heading: 'Marital Status *',
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
                                if(value=="EN"||value=="MD"||value=="UG"||value=="PG"||value=="DC"||value=="US"||value=="OT"){

                                  }else{
                                     setState(() {
                                        highestEducation = value.toString();
                                        isHighestEducation = false;

                                       });

                                  }

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
                            Column(

                              children: [
                                SizedBox(height: 10,),
                                SizedBox(
                                  child:       Row(
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
                          height: 25,
                                ),
                                SizedBox(child:   Row(
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
                           height: 25),
                           SizedBox(child:  Row(
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
                           height: 25,),
                          SizedBox(child:   Row(
                              children: [
                                EmployedIn(
                                  value: 'OT',
                                  groupValue: groupValue,
                                  onChange: (e) => valueChanged(e),
                                  text: 'Others',
                                ),
                              ],
                            ),

                         height: 25,),
                         SizedBox(height: 10,)   ],
                            ),
                             TextFieldCustom(
                               focusNode: focusNodeOccupation,
                              controller: occupation,
                              style: miniGreyTextStyle,
                              labelText: 'Occupation *',
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
                              focusNode: focusNodeIncome,
                              style: miniGreyTextStyle,
                              labelText: textAnnual,
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
print('de');
  YYDialog().build()
    ..width = MediaQuery.of(context).size.width-80
    ..height = MediaQuery.of(context).size.height
    ..gravity = Gravity.right
    ..gravityAnimationEnable = true
    ..widget(
      
      Container(
        width: MediaQuery.of(context).size.width-80,
        height: MediaQuery.of(context).size.height,
        child:  DropDownCasteMultiple(
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
     )
    )
    ..show();
/*            showDialog(
                barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return WillPopScope(
              onWillPop: () {
                return Future.value(true);
              },
              child: Material(
                child: Container(
                  alignment: Alignment.centerLeft,
                 // padding: const EdgeInsets.all(16.0),
                  width: MediaQuery.of(context).size.width - 100,
                  height: double.infinity,
                  child: 
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
      ),
              ));
        },
      );
    },

              
            
                  );
*/
                              },
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      // Expanded(
                                      //   child: Text(
                                      //     'Preferred Caste:',
                                      //     textAlign: TextAlign.start,
                                      //     style: miniGreyFontWeightStyle,
                                      //   ),
                                      // ),
                                       Expanded(
                                        child: Text(
                                          '+ Add more',
                                          textAlign: TextAlign.end,
                                          style:  TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: greyTextField,
                                                    fontSize: 16,
                                                  ),
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
                                    height: 350,
                                    child:
                                           GridView.builder(
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

                                              vertical: 2,
                                            ),
                                            child: Stack(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(left:16,right: 16,top:5,bottom: 5),
                                                alignment: Alignment.center,
                                                child:  Column(
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
                                                          child:
                                                           Text(
                                                            defaultCasteValue[
                                                                    index][1]
                                                                .toString(),
                                                            maxLines:3,
                                                            textAlign: TextAlign
                                                                .center,

                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:TextStyle(fontSize: 12)
                                                               ,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                                 Align(
                                                  alignment: Alignment.topRight,
                                                  child:  Container(
                                                      // color: red,
                                                      height: 30,
                                                      width: 30,
                                                      child: IconButton(icon: Icon(
                                                        Icons.clear,
                                                        size: 12,
                                                      ),onPressed: (){
                                                         print('Reach');
                                                      setState(() {
                                                        defaultCasteValue.remove(
                                                            defaultCasteValue[
                                                                index]);
                                                      });
                                                      },)
                                                    ),
),
                                            /*    Positioned(
                                                  top:0.0,
                                                  right: 0.0,
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
                                                      child: IconButton(icon: Icon(
                                                        Icons.clear,
                                                        size: 15,
                                                      ),onPressed: (){
                                                         print('Reach');
                                                      setState(() {
                                                        defaultCasteValue.remove(
                                                            defaultCasteValue[
                                                                index]);
                                                      });
                                                      },)
                                                    ),
                                                  ),
                                                ),
                                            */  ],
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
                                if ( occupation.text.isNotEmpty) {
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
                                       setFocus(focusNodeIncome);
                                    }
                                  } else {
                                    uploadData();
                                  }
                                } else 
                                if(occupation.text == '' || occupation.text == null){
                                    _key.currentState.showSnackBar(
                                        snackBar(
                                          'Occupation is missing',
                                          Colors.red,
                                          Icons.verified_user,
                                        ),
                                      );
                                      setFocus(focusNodeOccupation);
                                 
                                  setState(() {
                                    isDisplay = true;
                                  });
                                } else {
                                    uploadData();
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
        isAnnualIncome = true;
        textAnnual = 'Your Annual Income *';
      } else if (e == "PVT") {
        groupValue = e;
        isAnnualIncome = true;
        textAnnual = 'Your Annual Income *';
      } else if (e == "OWN") {
        groupValue = e;
        textAnnual = 'Your Annual Income';
      } else if (e == "NW") {
        groupValue = e;
        textAnnual = 'Your Annual Income';
      } else if (e == "JT") {
        groupValue = e;
        textAnnual = 'Your Annual Income';
      } else if (e == "SP") {
        groupValue = e;
        textAnnual = 'Your Annual Income';
      } else if (e == "OT") {
        groupValue = e;
        textAnnual = 'Your Annual Income';
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
    /*_key.currentState
        .showSnackBar(
          snackBar(
            'Data uploaded',
            Colors.green,
            Icons.verified_user,
          ),
        )
        .closed
        .then((value) => changeScreen(context, RegisterThird()));
    */
    setState(() {
      isLoading = false;
    });
    changeScreen(context, RegisterThird());
  }
}
class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TriangleClipper oldClipper) => false;
}