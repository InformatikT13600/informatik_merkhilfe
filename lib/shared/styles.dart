import 'package:flutter/material.dart';

final Color colorMainBackground = Color(0xff1E1E5A);
final Color colorMainAppbar = Color(0xff333399);
final Color colorRed = Color(0xffD25A5A);


Widget buildRectangularButton(String buttonText) {

  return Container(
    constraints: BoxConstraints(minHeight: 100, minWidth: 300, maxHeight: 100, maxWidth: 300),
    decoration: BoxDecoration(
      border: Border.all(color: colorRed, width: 6),
      borderRadius: BorderRadius.circular(25),
    ),
    child: TextButton(
      onPressed: () {print('test');},
      child: Text(
        buttonText,
        style: TextStyle(color: Colors.white, fontSize: 34, fontWeight: FontWeight.normal),
      ),
    ),
  );

}

Widget buildEllipticalButton(String buttonText) {

  return Container(
    constraints: BoxConstraints(minHeight: 100, maxHeight: 100, minWidth: 300, maxWidth: 300),
    decoration: BoxDecoration(
      border: Border.all(color: colorRed, width: 6),
      borderRadius: BorderRadius.circular(50),
    ),
    child: TextButton(
      onPressed: () {print('test');},
      child: Text(
          buttonText,
        style: TextStyle(color: Colors.white, fontSize: 34, fontWeight: FontWeight.normal),
      ),
    ),
  );

  return Container();

}
