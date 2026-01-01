
import 'package:get/get.dart';
import 'package:my_portfolio/app/core/utils/translations/translation_exceptions.dart';
import 'package:my_portfolio/app/core/utils/translations/translations_assets_reader.dart';

class Translation extends Translations {
  static bool get isInitialized => TranslationsAssetsReader.isInitialized;
  
  static void ensureInitialized() {
    if (!isInitialized) {
      throw TranslationNotInitializedException(
        'Translation assets must be initialized before accessing translations. '
        'Call TranslationsAssetsReader.initialize() first.',
      );
    }
  }

  @override
  Map<String, Map<String, String>> get keys {
    ensureInitialized();
    
    final translationsMap = <String, Map<String, String>>{};
    
    // Safely add each language with fallback handling
    for (final language in TranslationsAssetsReader.availableLanguages) {
      final translations = TranslationsAssetsReader.getTranslations(language);
      if (translations != null && translations.isNotEmpty) {
        translationsMap[language] = translations;
      } else {
        _logMissingLanguage(language);
      }
    }
    
    // Ensure we have at least one language
    if (translationsMap.isEmpty) {
      throw NoTranslationsAvailableException(
        'No translation files were loaded successfully.',
      );
    }
    
    return translationsMap;
  }

  /// Get available languages from the translation system
  static List<String> get availableLanguages {
    ensureInitialized();
    return TranslationsAssetsReader.availableLanguages;
  }

  /// Check if a specific language is available
  static bool isLanguageAvailable(String languageCode) {
    ensureInitialized();
    return TranslationsAssetsReader.getTranslations(languageCode) != null;
  }

  /// Get translation count for a specific language
  static int getTranslationCount(String languageCode) {
    ensureInitialized();
    final translations = TranslationsAssetsReader.getTranslations(languageCode);
    return translations?.length ?? 0;
  }

  /// Get total translation keys across all languages
  static int get totalTranslationKeys {
    ensureInitialized();
    return TranslationsAssetsReader.getTranslationKeys().length;
  }

  /// Validate that all languages have the same keys (for consistency)
  static Map<String, List<String>> validateTranslationConsistency() {
    ensureInitialized();
    
    final allKeys = TranslationsAssetsReader.getTranslationKeys();
    final missingKeysByLanguage = <String, List<String>>{};
    
    for (final language in availableLanguages) {
      final languageKeys = TranslationsAssetsReader.getTranslations(language)?.keys.toSet() ?? <String>{};
      final missingKeys = allKeys.where((key) => !languageKeys.contains(key)).toList();
      
      if (missingKeys.isNotEmpty) {
        missingKeysByLanguage[language] = missingKeys;
      }
    }
    
    return missingKeysByLanguage;
  }

  /// Get a specific translation directly (bypassing GetX)
  static String? getDirectTranslation(String languageCode, String key) {
    ensureInitialized();
    return TranslationsAssetsReader.getTranslation(languageCode, key);
  }

  /// Get translation with fallback support
  static String getTranslationWithFallback({
    required String languageCode,
    required String key,
    String fallbackLanguage = 'en',
    String fallbackText = '[MISSING TRANSLATION]',
  }) {
    ensureInitialized();
    
    // Try primary language
    final translation = TranslationsAssetsReader.getTranslation(languageCode, key);
    if (translation != null) return translation;
    
    // Try fallback language
    final fallbackTranslation = TranslationsAssetsReader.getTranslation(fallbackLanguage, key);
    if (fallbackTranslation != null) return fallbackTranslation;
    
    // Return fallback text
    return fallbackText;
  }

  /// Reload translations (useful for development)
  static Future<void> reload() async {
    await TranslationsAssetsReader.reload();
  }

  // Private helper method for logging
  static void _logMissingLanguage(String languageCode) {
    // You can replace this with your preferred logging method
    print('Warning: Translation file for "$languageCode" is empty or not loaded.');
  }
}


