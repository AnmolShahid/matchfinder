import 'package:flutter/material.dart';
import 'package:matchfinder/Utilities/Common.dart';

class TextFieldCustom extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final String Function(String) validator;
  final Function(String) onFieldSubmit;
  final String hintText;
  final Function onTapSuffixIcon;
  final Function onTapPrefixIcon;
  final IconData suffixIconData;
  final IconData prefixIconData;
  final FocusNode focusNode;
  final TextStyle labelStyle;
  final TextStyle hintStyle;
  final TextInputAction textInputAction;
  final TextStyle style;
  final int maxLength;
  final int maxLines;
  final Color backgroundColor;
  final Color hintTextColor;
  final Color cursorColor;
  final EdgeInsetsGeometry contentPadding;
  final Color textColor;
  final Color prefixIconColor;
  final Color sufixIconColor;
  final Widget prefixWidget;
  final TextInputType inputType;
  final bool obscureText;
  final double borderRadius;
  final bool borderSide;
  final Function onTap;
  final Function onChanged;

  static const Color _textFieldThemeColor = const Color(0xff866d59);

  const TextFieldCustom({
    Key key,
    @required this.labelText,
    @required this.controller,
    this.validator,
    this.onFieldSubmit,
    this.hintText,
    this.onTapSuffixIcon,
    this.suffixIconData,
    this.labelStyle = const TextStyle(color: Colors.grey),
    this.hintStyle = const TextStyle(color: Colors.grey),
    this.contentPadding,
    this.maxLength,
    this.maxLines,
    @required this.style,
    this.prefixIconData,
    this.onTapPrefixIcon,
    this.textInputAction,
    this.focusNode,
    this.backgroundColor = Colors.transparent,
    this.hintTextColor = _textFieldThemeColor,
    this.cursorColor = _textFieldThemeColor,
    this.textColor = _textFieldThemeColor,
    this.prefixIconColor = const Color(0xff20242b),
    this.sufixIconColor = const Color(0xff20242b),
    this.prefixWidget,
    this.inputType = TextInputType.text,
    this.obscureText = false,
    this.borderRadius = 10,
    this.onChanged,
    this.borderSide = false,
    this.onTap,
  }) : super(key: key);

  @override
  _TextFieldState createState() => _TextFieldState();
}

class _TextFieldState extends State<TextFieldCustom> {
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 15,
      ),
      color: Colors.white,
      child: TextFormField(
        onChanged: widget.onChanged,
        onTap: widget.onTap,
        obscureText: widget.obscureText,
        keyboardType: widget.inputType,
        focusNode: widget.focusNode,
        validator: widget.validator,
        cursorWidth: 1,
        maxLines: widget.maxLines,
        maxLength: widget.maxLength,
        cursorColor: widget.cursorColor,
        autofocus: false,
        controller: widget.controller,
        style: widget.style,
        onFieldSubmitted: widget.onFieldSubmit,
        textInputAction: widget.textInputAction,
        decoration: InputDecoration(
          hoverColor: Colors.white,
          labelText: widget.labelText,
          labelStyle: widget.labelStyle,
          counterText: '',
          errorStyle: TextStyle(
            backgroundColor: transparent,
          ),
          hintText: widget.hintText,
          hintStyle: widget.hintStyle,
          contentPadding: widget.contentPadding,
          suffixIcon: widget.suffixIconData == null
              ? null
              : GestureDetector(
                  onTap: widget.onTapSuffixIcon,
                  child: Icon(
                    widget.suffixIconData,
                    size: 22,
                    color: widget.sufixIconColor,
                  ),
                ),
          prefixIcon: widget.prefixWidget != null
              ? widget.prefixWidget
              : widget.prefixIconData == null
                  ? null
                  : GestureDetector(
                      onTap: widget.onTapPrefixIcon,
                      child: Icon(
                        widget.prefixIconData,
                        size: 16,
                        color: widget.prefixIconColor,
                      ),
                    ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: red),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColorField),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: appColor),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: borderColorField),
          ),
        ),
      ),
    );
  }
}
