import 'package:flutter/material.dart';
import 'package:matchfinder/Utilities/Common.dart';
import 'package:matchfinder/Utilities/Function/function.dart';
import 'package:matchfinder/Utilities/sharedWidget/text_field.dart';
import 'package:matchfinder/Utilities/style.dart';

class DropDownCity extends StatefulWidget {
  final GlobalKey<ScaffoldState> keyScaffold;
  final Function onSelect;

  DropDownCity({
    @required this.onSelect,
    @required this.keyScaffold,
  });

  @override
  _DropDownCityState createState() => _DropDownCityState();
}

class _DropDownCityState extends State<DropDownCity> {
  TextEditingController search = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<String> castString = <String>[];
  String value;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        padding: EdgeInsets.only(
          top: 30,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState.validate()) {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        if (value != null) {
                          Navigator.pop(context);
                        } else {
                          addToFunction(search.text.trim());
                          Navigator.pop(context);
                        }
                      }
                    },
                    borderRadius: BorderRadius.circular(
                      15,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          15,
                        ),
                        color: appColor,
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                      child: Text(
                        'Done',
                        style: smallWhiteTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Form(
                key: _formKey,
                child: TextFieldCustom(
                  controller: search,
                  style: miniGreyTextStyle,
                  labelText: 'City',
                  inputType: TextInputType.text,
                  onChanged: (value) async {
                    if (value.isNotEmpty) {
                      setState(() {
                        isLoading = true;
                        castString.clear();
                      });
                      List<dynamic> res = await getCity(value);
                      setState(() {
                        isLoading = false;
                      });
                      if (res.isNotEmpty) {
                        for (int i = 0; i < res.length; i++) {
                          if (castString.length != res.length) {
                            setState(() {
                              castString.add(res[i]);
                            });
                          }
                        }
                      }
                    } else {
                      setState(() {
                        isLoading = false;
                        if (castString.isNotEmpty) castString.clear();
                      });
                    }
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter City';
                    }
                    return null;
                  },
                ),
              ),
              isLoading ? CircularProgressIndicator() : Container(),
              castString.isNotEmpty
                  ? ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount:
                castString.length == null ? 0 : castString.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                      border: Border.all(
                        color: value == castString[index] ? green : black,
                        width: 1,
                      ),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      onTap: () {
                        setState(() {
                          value = castString[index];
                        });
                        addToFunction(castString[index]);
                      },
                      title: Text(castString[index]),
                      trailing: Icon(
                        Icons.check,
                        color: value == castString[index]
                            ? green
                            : transparent,
                      ),
                    ),
                  );
                },
              )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  addToFunction(String value) {
    widget.onSelect(value);
  }
}
