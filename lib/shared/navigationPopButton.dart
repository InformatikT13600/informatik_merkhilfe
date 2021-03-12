import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavigationPopButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Transform.scale(scale: 2, child: IconButton(icon: SvgPicture.asset('assets/icons/arrow_white.svg'), onPressed: () => Navigator.pop(context),));
  }
}
