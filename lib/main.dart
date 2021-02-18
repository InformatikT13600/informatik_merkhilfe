import 'package:flutter/material.dart';
import 'package:informatik_merkhilfe/shared/routingTransition.dart';
import 'package:informatik_merkhilfe/views/home.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {

  static const String routeHome = 'home';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      home: Container(),
      initialRoute: routeHome,
      onGenerateRoute: (settings) {
        print('settings.name : ${settings.name}');

        Widget page;

        switch (settings.name) {
          case routeHome: page = Home(); break;

          default: return null;
        }

        return RoutingTransition(page: page);
      },
    );
  }
}
