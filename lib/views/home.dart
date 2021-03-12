import 'package:flutter/material.dart';
import 'package:informatik_merkhilfe/services/informationService.dart';
import 'package:informatik_merkhilfe/shared/loading.dart';
import 'package:informatik_merkhilfe/shared/styles.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool loading = true;

  void initInformationService() async {
    InformationService.init().then((value) => loading = false);
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
        title: Text('Informatik Merkhilfe'),
        centerTitle: true,
        backgroundColor: colorMainAppbar,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        width: double.infinity,
        child: ListView.builder(
          itemCount: InformationService.langs.length,
          itemBuilder: (context, index) {
            return ListTile(

            );
          },
        ),
      ),
    );
  }
}

