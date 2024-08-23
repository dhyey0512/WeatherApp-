import 'package:flutter/material.dart';

TextStyle textS({double? fontSize}) {
  return TextStyle(
    fontSize: fontSize  ?? 21,
    color: Colors.white,
    fontWeight: FontWeight.w800,
    letterSpacing: 3,
  );
}

Widget dataText({required String value ,double? fontSize, double? mt , double? mb, double? mr ,double? ml}) {
  return Container(
    margin: EdgeInsets.only(top: mt ?? 0 , bottom: mb ?? 0 , right: mr ?? 0 , left: ml ?? 0 ),
    child: Text(
      value,
      style: textS(fontSize: fontSize),
    ),
  );
}
