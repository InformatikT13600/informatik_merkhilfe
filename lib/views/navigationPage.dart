import 'package:flutter/material.dart';
import 'package:informatik_merkhilfe/models/article.dart';
import 'package:informatik_merkhilfe/models/category.dart';
import 'package:informatik_merkhilfe/services/informationService.dart';
import 'package:informatik_merkhilfe/shared/navigationPopButton.dart';
import 'package:informatik_merkhilfe/shared/routingTransition.dart';
import 'package:informatik_merkhilfe/shared/styles.dart';
import 'package:informatik_merkhilfe/views/articlePage.dart';

class NavigationPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    String title;
    List<dynamic> children = [];

    // check if there is no current category (root of language)
    if(InformationService.currentCategory == null) {
      title = InformationService.currentLanguage.name;
      children = InformationService.informationMap[InformationService.currentLanguage.name];
    }

    // not root of language => read children and articles of current Category
    else {
      title = InformationService.currentCategory.name;

      // check if category has children
      if(InformationService.currentCategory.childrenCategories != null) {
        // iterate through children categories
        for(Category cat in InformationService.currentCategory.childrenCategories) {
          children.add(cat);
        }
      }

      // check if category has articles
      if(InformationService.articles[InformationService.currentCategory] != null) {
        for(Article art in InformationService.articles[InformationService.currentCategory]) {
          children.add(art);
        }
      }
    }

    return Scaffold(
      backgroundColor: colorMainBackground,
      appBar: AppBar(
        title: Text(title, style: TextStyle(fontSize: 34),),
        centerTitle: true,
        backgroundColor: colorMainAppbar,
        automaticallyImplyLeading: false,
        leading: NavigationPopButton(),
      ),
      body: Container(
        child: children.isNotEmpty ? ListView.builder(
          scrollDirection: Axis.vertical,
          clipBehavior: Clip.hardEdge,
          itemCount: children.length,
          itemBuilder: (context, index) {

            // get current child
            var child = children[index];

            // declare button widget;
            Widget button;

            // check if current child is an article
            if(child is Article) {
              // build article button
              button = buildButtonElliptical(buttonText: child.name, color: InformationService.currentLanguage.color, onPressed: () {

                // navigate to article page
                Navigator.push(context, RoutingTransition(page: ArticlePage(article: child)));

              });
            }

            // check if current child is a category
            else if(child is Category) {

              // return empty container if category has no articles and no children
              if(child.children.isEmpty && (InformationService.articles[child] == null || InformationService.articles[child].isEmpty)) return Container();

              button = buildButtonRectangular(buttonText: child.name, color: InformationService.currentLanguage.color, onPressed: () {

                // store currentCategory
                Category currentCategoryOld = InformationService.currentCategory;

                // set new current category
                InformationService.currentCategory = child;

                // navigate to next page
                Navigator.push(context, RoutingTransition(page: NavigationPage()))
                // reset category when popping the route
                    .then((value) => InformationService.currentCategory = currentCategoryOld);

              });
            }

            // return button with padding
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Align(alignment: Alignment.center,child: button),
            );
          },
        ) : Text('Pretty empty'),
      ),
    );
  }
}
