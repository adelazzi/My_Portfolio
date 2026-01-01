

// translation_exceptions.dart
class TranslationNotInitializedException implements Exception {
  final String message;
  TranslationNotInitializedException(this.message);
  
  @override
  String toString() => 'TranslationNotInitializedException: $message';
}

class TranslationLoadException implements Exception {
  final String message;
  TranslationLoadException(this.message);
  
  @override
  String toString() => 'TranslationLoadException: $message';
}

class NoTranslationsAvailableException implements Exception {
  final String message;
  NoTranslationsAvailableException(this.message);
  
  @override
  String toString() => 'NoTranslationsAvailableException: $message';
}