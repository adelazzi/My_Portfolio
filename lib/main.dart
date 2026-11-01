import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/app/core/design/palette.dart';
import 'package:my_portfolio/app/core/utils/theme_util.dart';
import 'package:my_portfolio/app/core/utils/translation_util.dart';
import 'package:my_portfolio/app/core/utils/translations/translation.dart';
import 'package:my_portfolio/app/core/utils/translations/translations_assets_reader.dart';
import 'package:my_portfolio/app/data/career_repository.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final query = Uri.base.queryParameters;
  TranslationUtil.initialize(
    requested: query['lang'],
    systemLanguage: PlatformDispatcher.instance.locale.languageCode,
  );
  ThemeUtil.initialize(requested: query['theme']);

  try {
    await Future.wait([
      TranslationsAssetsReader.initialize(),
      CareerRepository.initialize(lang: TranslationUtil.currentLocale.languageCode),
    ]);
    runApp(const PortfolioApp());
  } catch (error, stackTrace) {
    if (kDebugMode) {
      debugPrint('App initialization failed: $error');
      debugPrint('Stack trace: $stackTrace');
    }
    runApp(const ErrorApp());
  }
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Adel Azzi',

      // Routing
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,

      // Internationalization (Arabic switches the layout to right-to-left)
      translations: Translation(),
      locale: TranslationUtil.currentLocale,
      fallbackLocale: const Locale('en'),
      supportedLocales: TranslationUtil.supportedLocales.values.toList(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // Themes
      themeMode: ThemeUtil.currentTheme,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),

      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 200),
      popGesture: !kIsWeb,
    );
  }
}

class ErrorApp extends StatelessWidget {
  const ErrorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: Builder(
        builder: (context) => Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('The portfolio didn\'t load', style: AppType.h2(context)),
                    const SizedBox(height: 12),
                    Text(
                      'Some files couldn\'t be read. Try again, and if it keeps happening, '
                      'reach me at azziadel3939@gmail.com.',
                      style: AppType.body(context),
                    ),
                    const SizedBox(height: 24),
                    // Re-running main() retries initialization on every platform, web included.
                    const FilledButton(onPressed: main, child: Text('Try again')),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
