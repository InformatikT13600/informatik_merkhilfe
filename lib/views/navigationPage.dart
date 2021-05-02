import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:informatik_merkhilfe/models/article.dart';
import 'package:informatik_merkhilfe/models/category.dart';
import 'package:informatik_merkhilfe/services/informationService.dart';
import 'package:informatik_merkhilfe/shared/homeButton.dart';
import 'package:informatik_merkhilfe/shared/navigationPopButton.dart';
import 'package:informatik_merkhilfe/shared/routingTransition.dart';
import 'package:informatik_merkhilfe/shared/styles.dart';
import 'package:informatik_merkhilfe/views/articlePage.dart';

class NavigationPage extends StatefulWidget {

  @override
  _NavigationPageState createState() => _NavigationPageState();

  static final searchInputDecoration = InputDecoration(
    isDense: true,
    isCollapsed: true,
    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    border: OutlineInputBorder(
      gapPadding: 0,
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(
        color: Colors.white,
        width: 2,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      gapPadding: 0,
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(
        color: Colors.white,
        width: 2,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      gapPadding: 0,
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(
        color: Color(0xff77DD77),
        width: 2,
      ),
    ),
  );
}

class _NavigationPageState extends State<NavigationPage> {

  String title;
  List<dynamic> children = [];

  List<dynamic> displayedChildren = [];
  TextEditingController _controller = new TextEditingController();

  @override
  void initState() {

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
      if(InformationService.articleLists[InformationService.currentCategory] != null) {
        for(Article art in InformationService.articleLists[InformationService.currentCategory]) {
          children.add(art);
        }
      }
    }

    displayedChildren = children;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: colorMainBackground,
      appBar: AppBar(
        title: Column(
          children: [

            /* category title */
            FittedBox(fit: BoxFit.contain,child: Text(title, style: TextStyle(fontSize: 34),)),

            /* searchbar */
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    height: 45,
                    width: 200,
                    padding: EdgeInsets.only(top: 5),
                    child: TextField(
                      key: Key('search'),
                      controller: _controller,
                      decoration: NavigationPage.searchInputDecoration,
                      textAlign: TextAlign.left,
                      textAlignVertical: TextAlignVertical.top,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                      onSubmitted: ((input) {

                        // if input is empty => display like normal
                        if(input.isEmpty) {
                          setState(() =>  displayedChildren = children);
                          return;
                        }

                        // check all articles for any match

                        List<Article> matches = [];

                        // iterate through all articles
                        InformationService.articles.forEach((article) {
                          // check if article is part of the current language
                          if(article.language == InformationService.currentLanguage.name) {

                            // check if the article has a match with the input
                            if(article.hasMatch(input))
                              // add it to the list of displayed articles
                              matches.add(article);

                          }
                        });

                        // set new displayed list
                        setState(() => displayedChildren = matches);


                      }),
                    ),
                  ),
                ),
                FittedBox(
                  fit: BoxFit.fill,
                  child: IconButton(
                    onPressed: () {
                      // delete input and reset displayed children
                      setState(() {
                        displayedChildren = children;
                        _controller.value = TextEditingValue.empty;
                      });
                    },
                    // does not actually affect the button itself but only it's optical appearance (color)
                    icon: _controller.value.text.isEmpty ? SvgPicture.asset('assets/icons/delete_disabled.svg') : SvgPicture.asset('assets/icons/delete_enabled.svg'),
                  ),
                ),
              ],
            ),
          ],
        ),
        toolbarHeight: 120,
        centerTitle: true,
        backgroundColor: colorMainAppbar,
        automaticallyImplyLeading: false,
        leading: NavigationPopButton(),
      ),
      body: Stack(
        children: [
          Container(
            child: displayedChildren.isNotEmpty ? ListView.builder(
              scrollDirection: Axis.vertical,
              clipBehavior: Clip.hardEdge,
              itemCount: displayedChildren.length,
              itemBuilder: (context, index) {

                // get current child
                var child = displayedChildren[index];

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
                  if(child.children.isEmpty && (InformationService.articleLists[child] == null || InformationService.articleLists[child].isEmpty)) return Container();

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
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: HomeButton(),
            ),
          ),
        ],
      ),
    );
  }
}
