import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/app/core/constants/strings_assets_constants.dart';
import 'package:my_portfolio/app/core/toast_component.dart';
import 'package:my_portfolio/app/core/utils/portfolio_data.dart';

class TranslationUtil extends GetxController {
  // ← Make it a Controller
  static TranslationUtil get to => Get.find(); // ← Singleton access

  // Make these reactive
  // static final Rx<Locale?> _currentLocale = Rx<Locale?>(null);
  static final Map<AppLanguage, Locale> _supportedLocales = {
    AppLanguage.english: const Locale('en', 'US'),
    AppLanguage.arabic: const Locale('ar', 'SA'),
    AppLanguage.french: const Locale('fr', 'FR'),
    AppLanguage.russian: const Locale('ru', 'RU'),
  };

  static final Map<AppLanguage, String> _languageNames = {
    AppLanguage.english: 'English',
    AppLanguage.arabic: 'العربية',
    AppLanguage.french: 'Français',
    AppLanguage.russian: 'Русский',
  };

  static final Map<AppLanguage, String> _languageFlags = {
    AppLanguage.english: '🇺🇸',
    AppLanguage.arabic: '🇸🇦',
    AppLanguage.french: '🇫🇷',
    AppLanguage.russian: '🇷🇺',
  };

  static final Rx<Locale?> _currentLocale = Rx<Locale?>(null);

  // FIXED: Match exact Rx type
  static Rx<Locale?> get rxCurrentLocale =>
      _currentLocale; // ← Rx<Locale?>, not Rxn

  static Locale get currentLocale =>
      _currentLocale.value ?? _supportedLocales[AppLanguage.english]!;

  static Map<AppLanguage, Locale> get supportedLocales => _supportedLocales;
  static Map<AppLanguage, String> get languageNames => _languageNames;
  static Map<AppLanguage, String> get languageFlags => _languageFlags;

  /// Changes the app language and saves preference
  static Future<void> changeLanguage(AppLanguage language) async {
    final newLocale = _supportedLocales[language];
    if (newLocale == null) return;

    try {
      // Update reactive state FIRST (triggers Obx rebuilds)
      _currentLocale.value = newLocale;

      // Update GetX locale
      await Get.updateLocale(newLocale);
      await PortfolioData.load(newLocale.languageCode);

      if (isDesktopWindow(Get.context!)) {
        ToastComponent().showDesktopToast(Get.context!,
            message: StringsAssetsConstants.languageChanged,
            type: ToastTypes.success);
      } else {
        ToastComponent().showMobileToast(Get.context!,
            message: StringsAssetsConstants.languageChanged,
            type: ToastTypes.success);
      }
    } catch (e) {
      if (isDesktopWindow(Get.context!)) {
        ToastComponent().showDesktopToast(Get.context!,
            message: StringsAssetsConstants.languageChangeFailed,
            type: ToastTypes.error);
      } else {
        ToastComponent().showMobileToast(Get.context!,
            message: StringsAssetsConstants.languageChangeFailed,
            type: ToastTypes.error);
      }
    }
  }

  /// Initializes the language from local storage
  static Future<void> initialize() async {
    try {
      if (_currentLocale.value != null) {
        Get.updateLocale(_currentLocale.value!);
      }
    } catch (e) {
      // Fallback to English
      _currentLocale.value = _supportedLocales[AppLanguage.english];
      Get.updateLocale(currentLocale);
    }
  }

  /// Gets the current AppLanguage enum value (reactive)
  static AppLanguage get currentLanguage {
    return _supportedLocales.entries
        .firstWhere(
          (entry) => entry.value.languageCode == currentLocale.languageCode,
          orElse: () => _supportedLocales.entries.first,
        )
        .key;
  }

  /// Checks if a specific language is currently selected
  static bool isCurrentLanguage(AppLanguage language) {
    return currentLanguage == language;
  }

  /// Gets display name for current language with flag (REACTIVE)
  static String get currentLanguageDisplay {
    final language = currentLanguage;
    return '${_languageNames[language]}';
  }

  /// Gets display name for any language with flag
  static String getLanguageDisplay(AppLanguage language) {
    return '${_languageNames[language]}';
  }
}

enum AppLanguage {
  english,
  arabic,
  french,
  russian,
}
