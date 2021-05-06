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

                        // check if line is a code line
                        if(widget.article.content[index].startsWith('<code>')) {

                          // return code block widget
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            clipBehavior: Clip.hardEdge,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Text(widget.article.content[index].substring(6, widget.article.content[index].length), style: TextStyle(fontSize: 22, color: colorContrast, height: 1.5),),
                            ),
                          );

                        } else {

                          // return normal line
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Text('- ${widget.article.content[index]}', style: TextStyle(fontSize: 22, color: Colors.white, height: 1.5),),
                          );
                        }
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
              padding: const EdgeInsets.all(40.0),
              child: HomeButton(),
            ),
          )
        ],
      ),
    );
  }
}
