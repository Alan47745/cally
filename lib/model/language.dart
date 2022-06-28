import 'package:cally/model/cacheHelper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Language {
  final int id;
  final String name;

  final String languageCode;

  Language(this.id, this.name, this.languageCode);

  static List<Language> languageList() {
    return <Language>[
      Language(1, 'English', 'en'),
      Language(2, 'العربية', 'ar'),
      Language(3, 'French', 'fr'),
    ];
  }
}
