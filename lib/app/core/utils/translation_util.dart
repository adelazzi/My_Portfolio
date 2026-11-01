import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/app/data/career_repository.dart';

enum AppLanguage { english, arabic, french, russian }

class TranslationUtil {
  static const Map<AppLanguage, Locale> supportedLocales = {
    AppLanguage.english: Locale('en'),
    AppLanguage.arabic: Locale('ar'),
    AppLanguage.french: Locale('fr'),
    AppLanguage.russian: Locale('ru'),
  };

  /// Short codes shown in the language switcher.
  static const Map<AppLanguage, String> codes = {
    AppLanguage.english: 'EN',
    AppLanguage.arabic: 'AR',
    AppLanguage.french: 'FR',
    AppLanguage.russian: 'RU',
  };

  /// Language names written in their own language, for screen readers and tooltips.
  static const Map<AppLanguage, String> names = {
    AppLanguage.english: 'English',
    AppLanguage.arabic: 'العربية',
    AppLanguage.french: 'Français',
    AppLanguage.russian: 'Русский',
  };

  static final Rx<AppLanguage> current = AppLanguage.english.obs;

  static Locale get currentLocale => supportedLocales[current.value]!;

  /// Picks the starting language: a `?lang=ar` link first, then the
  /// browser's language if it's one we have, otherwise English.
  static void initialize({String? requested, required String systemLanguage}) {
    AppLanguage? match(String? code) {
      for (final e in supportedLocales.entries) {
        if (e.value.languageCode == code?.toLowerCase()) return e.key;
      }
      return null;
    }

    current.value = match(requested) ?? match(systemLanguage) ?? AppLanguage.english;
  }

  static bool isCurrentLanguage(AppLanguage language) => current.value == language;

  static Future<void> changeLanguage(AppLanguage language) async {
    final locale = supportedLocales[language]!;
    current.value = language;
    CareerRepository.to.lang.value = locale.languageCode;
    await Get.updateLocale(locale);
  }
}
