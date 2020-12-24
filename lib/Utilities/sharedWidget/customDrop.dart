import 'package:flutter/material.dart';
import 'package:matchfinder/Utilities/Common.dart';
import 'package:matchfinder/Utilities/style.dart';

class CustomDropDown extends StatelessWidget {
  final String value;
  final String hint;
  final String heading;
  final List<DropdownMenuItem> items;
  final Function onChanged;

  const CustomDropDown({
    Key key,
    this.value,
    this.hint,
    this.heading,
    this.items,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        heading != null
            ? Row(
                children: [
                  Expanded(
                    child: Text(
                      heading,
                      textAlign: TextAlign.start,
                      style: miniGreyFontWeightStyle,
                    ),
                  ),
                ],
              )
            : Container(),
        heading != null
            ? SizedBox(
                height: 5,
              )
            : Container(),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: borderColorField,
              width: 1,
            ),
          ),
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
          child: DropdownButton<String>(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            value: value,
            hint: Text(
              hint,
              style: TextStyle(fontSize: 14),
              overflow: TextOverflow.ellipsis,
            ),
            style: smallGreyTextStyle,
            items: items,
            onChanged: (item) {
              onChanged(item);
            },
            isExpanded: true,
            underline: Container(),
            icon: Icon(Icons.keyboard_arrow_down),
          ),
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
