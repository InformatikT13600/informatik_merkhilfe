import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:informatik_merkhilfe/services/informationService.dart';

class HomeButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return IconButton(

      icon: Transform.scale(
          scale: 2.5,
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(701),
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                )
              ),
              child: SvgPicture.asset('assets/icons/home_white.svg'),),
      ),

      onPressed: () {

      // reset Navigation
      InformationService.currentLanguage = null;
      InformationService.currentCategory = null;

      Navigator.popUntil(context, (route) => route.isFirst);

    },);
  }
}
