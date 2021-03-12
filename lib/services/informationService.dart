import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:informatik_merkhilfe/models/language.dart';

class InformationService {

  static List<Language> langs = [];
  static Map<Language, dynamic> information = {};



  /// Initializes service by reading all information from the files
  static Future<void> init() async {
    print('init information service');

    Map<String, dynamic> langJSON = jsonDecode(await rootBundle.loadString('assets/information/language.json'));
    List<dynamic> languages = langJSON['languages'];

    for(Map<String, dynamic> map in languages) {
      Language lang = Language.fromJSON(map);
      if(lang.isValid()) langs.add(lang);
    }

  }



}
