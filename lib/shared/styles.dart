import 'package:flutter/material.dart';

final Color colorMainBackground = Color(0xff1E1E5A);
final Color colorMainAppbar = Color(0xff333399);
final Color colorRed = Color(0xffD25A5A);


Widget buildRectangularButton() {

  return Container(
    constraints: BoxConstraints(minHeight: 100, minWidth: 300, maxHeight: 100, maxWidth: 300),
    decoration: BoxDecoration(
      border: Border.all(color: colorRed, width: 6),
      borderRadius: BorderRadius.circular(25),
    ),
    child: TextButton(
      onPressed: () {print('test');},
      child: Text(
        'test text',
        style: TextStyle(color: Colors.white, fontSize: 34, fontWeight: FontWeight.normal),
      ),
    ),
  );

}

Widget buildEllipticalButton() {

  return Container();

}
