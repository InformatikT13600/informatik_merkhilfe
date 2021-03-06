import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:informatik_merkhilfe/models/article.dart';
import 'package:informatik_merkhilfe/models/category.dart';
import 'package:informatik_merkhilfe/models/language.dart';

class InformationService {

  static List<Language> langs = [];
  static Map<String, List<Category>> informationMap = {};

  /// a map that contains all [Article]s a given [Category] has
  static Map<Category, List<Article>> articleLists = {};

  /// a list that contains all existing and valid [Article]s
  /// disregarding whether or not the parent [Category] exists
  static List<Article> articles = [];

  static Language currentLanguage;
  static Category currentCategory;


  /// Initializes service by reading all information from the files
  static Future<void> init() async {
    print('init information service');

    await _readLanguages();
    await _readCategories();
    await _readArticles();

    print('after initializing:');
    print('languages: ${langs.length}');
    print('informationMaps: ${informationMap.keys.length}');
    print('categoriesWithArticles: ${articleLists.keys.length}');
  }

  /// reads all languages from the corresponding json file
  static Future<void> _readLanguages() async {

    // read json array from json file
    List<dynamic> languages = jsonDecode(await rootBundle.loadString('assets/information/language.json'));

    // iterate through all language json objects
    for(Map<String, dynamic> map in languages) {

      // generate language object from json object
      Language lang = Language.fromJSON(map);

      // add language to the language list
      if(lang.isValid()) langs.add(lang);
    }
  }

  /// reads all categories from the corresponding json file
  static Future<void> _readCategories() async {

    // read json array from json file
    List<dynamic> categories = jsonDecode(await rootBundle.loadString('assets/information/categories.json'));

    // iterate through all category json objects
    for(Map<String, dynamic> map in categories) {

      // generate category object from json object
      Category cat = Category.fromJSON(map);

      // check if category is valid
      if(!cat.isValid()) return;

      // check if the language that is specified in the category exists
      if(!langs.any((element) => element.name == cat.language)) continue;

      // build up children
      cat.buildTree();

      // add category to information tree
      informationMap.update(cat.language, (currentList) {currentList.add(cat); return currentList;}, ifAbsent: () => [cat]);
    }
  }

  /// reads all articles from the corresponding json file
  static Future<void> _readArticles() async {

    // read json array from json file
    List<dynamic> articles = jsonDecode(await rootBundle.loadString('assets/information/articles.json'));

    // iterate through all article json objects
    for(Map<String, dynamic> map in articles) {

      // generate article object from json object
      Article article = Article.fromJSON(map);

      // check if category is valid
      if(!article.isValid()) return;

      // check if the language that is specified in the article exists
      if(!langs.any((element) => element.name == article.language)) continue;

      // article is valid => add it to the articles list
      InformationService.articles.add(article);

      Category category;

      // search for the category that is specified in the article exists
      for(Category cat in informationMap[article.language]) {
        category = _searchForCategory(cat, article.category);
        if(category != null) break;
      }

      // check if the category that is specified in the article exists
      if(category == null) return;

      // add article to articles map
      InformationService.articleLists.update(category, (currentList) {currentList.add(article); return currentList;}, ifAbsent: () => [article]);
    }
  }

  /// searches for a category with the given name
  static Category _searchForCategory(Category category, String searchedCategory) {
    if(category.name == searchedCategory) return category;
    for(Category childCategory in category.childrenCategories) {
      Category possiblyExistingCategory = _searchForCategory(childCategory, searchedCategory);
      if(possiblyExistingCategory != null) return possiblyExistingCategory;
    }
    return null;
  }

}
