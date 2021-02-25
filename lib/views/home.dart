import 'package:flutter/material.dart';
import 'package:informatik_merkhilfe/shared/styles.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorMainBackground,
      appBar: AppBar(
        title: Text('Informatik Merkhilfe'),
        centerTitle: true,
        backgroundColor: colorMainAppbar,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            buildRectangularButton(),
            SizedBox(height: 30),
            buildEllipticalButton(),
          ],
        ),
      ),
    );
  }
}

