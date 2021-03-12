import 'package:flutter/material.dart';
import 'package:informatik_merkhilfe/models/language.dart';
import 'package:informatik_merkhilfe/services/informationService.dart';
import 'package:informatik_merkhilfe/shared/loading.dart';
import 'package:informatik_merkhilfe/shared/styles.dart';
import 'package:informatik_merkhilfe/shared/routingTransition.dart';
import 'package:informatik_merkhilfe/views/navigationPage.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool loading = true;

  void initInformationService() async {
    InformationService.init().then((value) => setState(() => loading = false));
  }

  @override
  void initState() {

    initInformationService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading? Loading() : Scaffold(
      backgroundColor: colorMainBackground,
      appBar: AppBar(
        title: Text('Informatik Merkhilfe', style: TextStyle(fontSize: 34),),
        centerTitle: true,
        backgroundColor: colorMainAppbar,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          clipBehavior: Clip.hardEdge,
          itemCount: InformationService.langs.length,
          itemBuilder: (context, index) {
            Language lang = InformationService.langs[index];

            // return empty container if language has no categories
            if(InformationService.informationMap[lang.name] == null || InformationService.informationMap[lang.name].isEmpty) return Container();

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Align(alignment: Alignment.center,child: buildButtonRectangular(buttonText: lang.name, color: lang.color, onPressed: () {

                // set current language
                InformationService.currentLanguage = lang;
                
                // navigate to Navigation page of the chosen language
                Navigator.push(context, RoutingTransition(page: NavigationPage()))
                    // reset language when popping the route
                    .then((value) => InformationService.currentLanguage = null);

              })),
            );
          },
        ),
      ),
    );
  }
}

