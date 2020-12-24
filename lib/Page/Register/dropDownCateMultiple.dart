import 'package:flutter/material.dart';
import 'package:matchfinder/Utilities/Common.dart';
import 'package:matchfinder/Utilities/sharedWidget/text_field.dart';
import 'package:matchfinder/Utilities/style.dart';

class DropDownCasteMultiple extends StatefulWidget {
  final GlobalKey<ScaffoldState> keyScaffold;
  final Function onSelect;
  final List<dynamic> casteList;
  final List<dynamic> defaultValue;

  DropDownCasteMultiple({
    @required this.onSelect,
    @required this.casteList,
    @required this.keyScaffold,
    @required this.defaultValue,
  });

  @override
  _DropDownCasteMultipleState createState() => _DropDownCasteMultipleState();
}

class _DropDownCasteMultipleState extends State<DropDownCasteMultiple> {
  TextEditingController search = TextEditingController();
  List<dynamic> castString = [];

  @override
  void initState() {
    super.initState();
    search.addListener(() {
      if (search.text.isNotEmpty) {
        if (widget.casteList.isNotEmpty) {
          widget.casteList.retainWhere((searchValue) {
            String name = searchValue[1];
            String searchTerm = search.text.trim().toLowerCase();
            String searchName = name.toLowerCase();
            return searchName.contains(searchTerm);
          });
          setState(() {
            castString = widget.casteList;
          });
        }
      }
    });
  }

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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                color: greyColor.withOpacity(0.4),
                child: TextFieldCustom(
                  controller: search,
                  style: miniGreyTextStyle,
                  labelText: 'Search Caste',
                  suffixIconData: Icons.search,
                  sufixIconColor: Colors.black,
                  inputType: TextInputType.text,
                  onChanged: (value) async {
                    if (value.isNotEmpty) {}
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter City';
                    }
                    return null;
                  },
                ),
              ),
              castString.isNotEmpty
                  ? Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount:
                            castString.length == null ? 0 : castString.length,
                        itemBuilder: (context, index) {
                          return new CheckboxListTile(
                            title: new Text(castString[index][1]),
                            value: widget.defaultValue != null
                                ? widget.defaultValue
                                    .contains(widget.casteList[index])
                                : false,
                            onChanged: (bool isCheck) {
                              if (isCheck) {
                                addToFunction(widget.casteList[index]);
                              } else {
                                addToFunction(widget.casteList[index]);
                              }
                            },
                          );
                        },
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: widget.casteList.length == null
                          ? 0
                          : widget.casteList.length,
                      itemBuilder: (context, index) {
                        return new CheckboxListTile(
                          title: new Text(widget.casteList[index][1]),
                          value: widget.defaultValue != null
                              ? widget.defaultValue
                                  .contains(widget.casteList[index])
                              : false,
                          onChanged: (bool isCheck) {
                            if (isCheck) {
                              addToFunction(widget.casteList[index]);
                            } else {
                              addToFunction(widget.casteList[index]);
                            }
                          },
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
                if (widget.defaultValue.isNotEmpty) {
                  Navigator.pop(context);
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
                  vertical: 15,
                  horizontal: 15,
                ),
                child: Text(
                  'Submit',
                  textAlign: TextAlign.center,
                  style: headingWhiteTextStyle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  addToFunction(value) {
    widget.onSelect(value);
    setState(() {});
  }
}
