import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_portfolio/app/core/utils/translations/translation_exceptions.dart';

abstract class TranslationsAssetsReader {
  // Private storage for translations
  static final Map<String, Map<String, String>> _translations = {};
  
  // Supported languages
  static const List<String> supportedLanguages = ['ar', 'en', 'fr', 'ru'];
  
  // Current loaded status
  static bool _isInitialized = false;
  
  // Getter for initialization status
  static bool get isInitialized => _isInitialized;
  
  // Getter for available languages
  static List<String> get availableLanguages => _translations.keys.toList();

  /// Initialize and load all translation files
  static Future<void> initialize() async {
    if (_isInitialized) return;
    
    try {
      await _loadAllTranslations();
      _isInitialized = true;
    } catch (e) {
      _isInitialized = false;
      rethrow;
    }
  }

  /// Load all translation files concurrently for better performance
  static Future<void> _loadAllTranslations() async {
    final loadFutures = <Future<void>>[];
    
    for (final language in supportedLanguages) {
      loadFutures.add(_loadLanguageFile(language));
    }
    
    await Future.wait(loadFutures);
  }

  /// Load a specific language file
  static Future<void> _loadLanguageFile(String languageCode) async {
    try {
      final response = await rootBundle.loadString(
        'assets/translations/language_$languageCode.json',
      );
      
      final decoded = json.decode(response) as Map<String, dynamic>;
      
      // Convert all values to String and handle nested objects
      _translations[languageCode] = _flattenTranslationMap(decoded);
      
    } on FlutterError catch (e) {
      throw TranslationLoadException(
        'Failed to load translation file for $languageCode: ${e.message}',
      );
    } on FormatException catch (e) {
      throw TranslationLoadException(
        'Invalid JSON format for $languageCode: ${e.message}',
      );
    } catch (e) {
      throw TranslationLoadException(
        'Unexpected error loading $languageCode: $e',
      );
    }
  }

  /// Flatten nested JSON objects into a single-level map
  static Map<String, String> _flattenTranslationMap(
    Map<String, dynamic> map, {
    String prefix = '',
  }) {
    final result = <String, String>{};
    
    for (final entry in map.entries) {
      final key = prefix.isEmpty ? entry.key : '${prefix}_${entry.key}';
      
      if (entry.value is Map<String, dynamic>) {
        result.addAll(_flattenTranslationMap(
          entry.value as Map<String, dynamic>,
          prefix: key,
        ));
      } else {
        result[key] = entry.value.toString();
      }
    }
    
    return result;
  }

  /// Get translation map for a specific language
  static Map<String, String>? getTranslations(String languageCode) {
    if (!_isInitialized) {
      throw TranslationNotInitializedException(
        'TranslationsAssetsReader must be initialized before use. Call initialize() first.',
      );
    }
    
    return _translations[languageCode];
  }

  /// Get a specific translation key for a language
  static String? getTranslation(String languageCode, String key) {
    final translations = getTranslations(languageCode);
    return translations?[key];
  }

  /// Check if a specific translation key exists
  static bool hasTranslation(String languageCode, String key) {
    final translations = getTranslations(languageCode);
    return translations?.containsKey(key) ?? false;
  }

  /// Get all available translation keys
  static Set<String> getTranslationKeys() {
    if (!_isInitialized) {
      throw TranslationNotInitializedException(
        'TranslationsAssetsReader must be initialized before use.',
      );
    }
    
    final allKeys = <String>{};
    for (final translationMap in _translations.values) {
      allKeys.addAll(translationMap.keys);
    }
    return allKeys;
  }

  /// Reload translations (useful for hot reload in development)
  static Future<void> reload() async {
    _translations.clear();
    _isInitialized = false;
    await initialize();
  }

  /// Get translation with fallback support
  static String getTranslationWithFallback({
    required String languageCode,
    required String key,
    String fallback = '',
  }) {
    return getTranslation(languageCode, key) ?? fallback;
  }

  /// Get translation with parameter replacement
  static String getTranslationWithParams({
    required String languageCode,
    required String key,
    Map<String, String> params = const {},
    String fallback = '',
  }) {
    final translation = getTranslation(languageCode, key) ?? fallback;
    
    if (params.isEmpty) return translation;
    
    var result = translation;
    for (final param in params.entries) {
      result = result.replaceAll('{{${param.key}}}', param.value);
    }
    
    return result;
  }

  // Convenience getters for direct access (maintains backward compatibility)
  static Map<String, String>? get ar => getTranslations('ar');
  static Map<String, String>? get en => getTranslations('en');
  static Map<String, String>? get fr => getTranslations('fr');
  static Map<String, String>? get ru => getTranslations('ru');
}
