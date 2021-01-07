import 'package:flutter/material.dart';

Color transparent = Colors.transparent;
final appColor = HexColor('236B8E');
final greyColor = HexColor('707070');
final backGroundColor = HexColor('F7F7F7');
final greyTextField = HexColor('737277');
final borderColorField = HexColor('D2D2D2');
final orangeSelected = HexColor('F17515');
final blueSelected = HexColor('1A6DF4');
final lightGray = HexColor('2E2925');
final blue = HexColor('407BFF');
final darkBlue = HexColor('122E6E');
Color orange = Colors.deepOrange;
Color whiteHint = Colors.white70;
Color yellow = Colors.yellow;
Color white70 = Colors.white70;
final white = HexColor('FDFEFF');

final orangeLinear = HexColor('FC8428');
final yellowLinear = HexColor('ECB907');

Color ratingBG = Colors.yellow[600];
Color black = Colors.black;
Color darkGrey = Color(0xFF313A44);
Color grey = Colors.grey;
Color green = Colors.green;
Color red = Colors.red;

void changeScreen(BuildContext context, Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void changeScreenReplacement(BuildContext context, Widget widget) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => widget));
}

void changeScreenReplacementUtils(BuildContext context, Widget widget) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (BuildContext context) => widget),
      (route) => false);
}

roundCirclePresent(String text, Color color, TextStyle textStyle) {
  return Container(
    alignment: Alignment.center,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: color,
    ),
    padding: EdgeInsets.all(
      10,
    ),
    child: Container(
      child: Text(
        text,
        style: textStyle,
      ),
    ),
  );
}

roundCircle(String text, Color color, TextStyle textStyle) {
  return Container(
    alignment: Alignment.center,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: color,
    ),
    padding: EdgeInsets.all(
      6,
    ),
    child: Container(
      child: Text(
        text,
        style: textStyle,
      ),
    ),
  );
}

snackBar(String name, MaterialColor color, IconData icon) {
  return SnackBar(
    duration: Duration(
      milliseconds: 500,
    ),
    backgroundColor: color.withOpacity(
      0.9,
    ),
    content: Row(
      children: [
        Icon(
          icon,
          color: white,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 10.0,
            ),
            child: Text(
              name,
              style: TextStyle(
                fontSize: 20,
                color: white,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}

class Common {
  static final String appName = 'Match Finder';
  static final String cardTypeVisa = 'visa';
  static final String cardTypeMaster = 'master';
}
