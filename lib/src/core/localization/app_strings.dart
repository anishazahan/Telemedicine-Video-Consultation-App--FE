import 'package:flutter/material.dart';

class AppStrings {
  static const supportedLocales = [Locale('en'), Locale('bn'), Locale('ar')];

  static final values = {
    'en': {'welcome': 'Premium care, anywhere', 'searchDoctors': 'Search doctors'},
    'bn': {'welcome': 'যেখানেই থাকুন, উন্নত চিকিৎসা', 'searchDoctors': 'ডাক্তার খুঁজুন'},
    'ar': {'welcome': 'رعاية طبية مميزة في أي مكان', 'searchDoctors': 'ابحث عن طبيب'},
  };

  static String t(BuildContext context, String key) {
    final code = Localizations.localeOf(context).languageCode;
    return values[code]?[key] ?? values['en']![key] ?? key;
  }
}
