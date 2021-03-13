import 'package:flutter/material.dart';
import 'package:informatik_merkhilfe/models/article.dart';
import 'package:informatik_merkhilfe/services/informationService.dart';
import 'package:informatik_merkhilfe/shared/homeButton.dart';
import 'package:informatik_merkhilfe/shared/navigationPopButton.dart';
import 'package:informatik_merkhilfe/shared/styles.dart';

class ArticlePage extends StatefulWidget {

  final Article article;

  ArticlePage({@required this.article});

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorMainBackground,
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: NavigationPopButton(),
                  ),
                  buildButtonElliptical(buttonText: widget.article.name, color: InformationService.currentLanguage.color, filled: true, onPressed: () => print('test')),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 50),
                      scrollDirection: Axis.vertical,
                      clipBehavior: Clip.hardEdge,
                      itemCount: widget.article.content.length,
                      itemBuilder: (context, index) {
                        return Text('- ${widget.article.content[index]}', style: TextStyle(fontSize: 22, color: Colors.white),);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: HomeButton(),
            ),
          )
        ],
      ),
    );
  }
}
