import 'package:flutter/material.dart';
import 'package:matchfinder/Utilities/style.dart';

class EmployedIn extends StatelessWidget {
  final String value;
  final String groupValue;
  final Function onChange;
  final String text;

  const EmployedIn({
    Key key,
    this.value,
    this.groupValue,
    this.onChange,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Radio(
            value: value,
            groupValue: groupValue,
            onChanged: onChange,
          ),
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.start,
              style: miniGreyTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
