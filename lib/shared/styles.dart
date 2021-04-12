import 'package:flutter/material.dart';

final Color colorMainBackground = Color(0xff1E1E5A);
final Color colorMainAppbar = Color(0xff333399);
final Color colorRed = Color(0xffD25A5A);

enum ButtonShape {
  RECTANGULAR,
  ELLIPTICAL,
}

Widget _buildButton({String buttonText = "", ButtonShape shape = ButtonShape.RECTANGULAR, Color color = Colors.white, bool filled = false, @required Function onPressed}) {

  double borderRadius = 0;

  switch(shape) {
    case ButtonShape.RECTANGULAR: borderRadius = 25; break;
    case ButtonShape.ELLIPTICAL: borderRadius = 50; break;
    default: break;
  }

  return Container(
    constraints: BoxConstraints(minHeight: 100, minWidth: 300, maxHeight: 100, maxWidth: 300),
    decoration: BoxDecoration(
      border: Border.all(color: color, width: 6),
      borderRadius: BorderRadius.circular(borderRadius),
      color: filled ? color : Colors.transparent,
    ),
    child: TextButton(
      style: TextButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),),
      onPressed: () => {onPressed()},
      child: FittedBox(
        fit: BoxFit.contain,
        child: Text(
          buttonText,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 34, fontWeight: FontWeight.normal),
        ),
      ),
    ),
  );
}

Widget buildButtonRectangular({String buttonText = "", Color color = Colors.white, bool filled = false, @required Function onPressed}) {
  return _buildButton(buttonText: buttonText, color: color, filled: filled, onPressed: onPressed, shape: ButtonShape.RECTANGULAR);
}

Widget buildButtonElliptical({String buttonText = "", Color color = Colors.white, bool filled = false, @required Function onPressed}) {
  return _buildButton(buttonText: buttonText, color: color, filled: filled, onPressed: onPressed, shape: ButtonShape.ELLIPTICAL);
}
