import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/app/core/styles/theme_styles.dart';
import 'package:my_portfolio/app/core/utils/portfolio_data.dart';
import 'package:my_portfolio/app/core/utils/theme_util.dart';
import 'package:my_portfolio/app/core/utils/translation_util.dart';
import 'package:my_portfolio/app/core/utils/translations/translation.dart';
import 'package:my_portfolio/app/core/utils/translations/translations_assets_reader.dart';
import 'package:my_portfolio/app/modules/user_controller.dart';
import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await AppInitializer.initialize();
    _configureSystemSettings();
    await PortfolioData.initial();

    runApp(const PortfolioApp());
  } catch (error, stackTrace) {
    if (kDebugMode) {
      debugPrint('🚨 App initialization failed: $error');
      debugPrint('Stack trace: $stackTrace');
    }
    runApp(const ErrorApp());
  }
}

/// Centralized app initialization with proper sequencing
class AppInitializer {
  static Future<void> initialize() async {
    final dependencies = [
      TranslationsAssetsReader.initialize(),
      TranslationUtil.initialize(),
      ThemeUtil.initialize(),
    ];

    // Initialize in parallel where possible, sequentially where dependencies exist
    await Future.wait([
      dependencies[0], // Translations assets first
    ]);
    await Future.wait(dependencies.sublist(1));

    // Initialize controllers last
    Get.put(UserController(), permanent: true);
  }
}

void _configureSystemSettings() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      designSize: const Size(600, 1200),
      minTextAdapt: true,
      splitScreenMode: false,
      ensureScreenSize: true, // Better for web responsiveness
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Adel Azzi - Portfolio',

        // Routing
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,

        // Internationalization
        translations: Translation(),
        locale: TranslationUtil.currentLocale,
        fallbackLocale: const Locale('en'),
        // supportedLocales: TranslationUtil.supportedLocales,

        // Themes
        themeMode: ThemeUtil.currentTheme,
        theme: ThemeStyles.lightTheme,
        darkTheme: ThemeStyles.darkTheme,

        // Web & Mobile optimizations
        defaultTransition: Transition.cupertino,
        transitionDuration: const Duration(milliseconds: 250),
        opaqueRoute: true,
        popGesture: kIsWeb ? false : true,

        // Accessibility & Text scaling
        builder: (context, widget) => MediaQuery(
          data: MediaQuery.of(context).copyWith(
              // textScaleFactor: _optimalTextScaleFactor(context),
              ),
          child: widget!,
        ),

        onReady: AppHealthChecker.performChecks,
      ),
    );
  }
}

/// Health checker for production monitoring
class AppHealthChecker {
  static void performChecks() {
    if (kReleaseMode) return;

    if (!TranslationsAssetsReader.isInitialized) {
      debugPrint('⚠️ TranslationsAssetsReader not initialized');
    }

    debugPrint('✅ Portfolio App ready');
    debugPrint('🌐 Locale: ${Get.locale}');
    debugPrint('🎨 Theme: ${ThemeUtil.currentTheme}');
  }
}

class ErrorApp extends StatelessWidget {
  const ErrorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(24.w),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.build_circle_outlined,
                      size: 80.w,
                      color: Colors.orange,
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      'Portfolio Loading Failed',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'Something went wrong during initialization. Please refresh the page.',
                      style: TextStyle(fontSize: 16.sp, color: Colors.black54),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 32.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildActionButton(
                          'Refresh',
                          Icons.refresh,
                          () => _restartApp(),
                          Colors.blue,
                        ),
                        _buildActionButton(
                          'Details',
                          Icons.info_outline,
                          () => _showErrorDetails(context),
                          Colors.orange,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(
    String label,
    IconData icon,
    VoidCallback onTap,
    Color color,
  ) {
    return Expanded(
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        ),
      ),
    );
  }

  void _restartApp() {
    if (kIsWeb) {
      // Web: reload page
      // (js.context.callMethod('location') as dynamic).callMethod('reload');
    } else {
      main();
    }
  }

  void _showErrorDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Troubleshooting'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Common issues:'),
              SizedBox(height: 8),
              Text('• Translation files missing'),
              Text('• Network connectivity'),
              Text('• Storage permissions'),
              Text('• Check browser console (F12)'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }
}

/// Production-ready safe translation extension
extension PortfolioTranslation on String {
  String get trSafe => _safeTranslate(this);

  static String _safeTranslate(String key) {
    try {
      return key.tr;
    } catch (_) {
      if (kDebugMode) debugPrint('❌ Missing translation: $key');
      return key;
    }
  }
}



/////////////////////////////////////////////


// void main() {
//   // Ensure Flutter bindings are initialized for web
//   WidgetsFlutterBinding.ensureInitialized();

//   runApp(const MyPortfolio());
// }

// class MyPortfolio extends StatelessWidget {
//   const MyPortfolio({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => PortfolioProvider(),
//       child: Consumer<PortfolioProvider>(
//         builder: (context, provider, _) {
//           return ScreenUtilInit(
//             designSize: kIsWeb ? const Size(1440, 900) : const Size(414, 896),
//             minTextAdapt: true,
//             splitScreenMode: true,
//             builder: (context, child) {
//               return MaterialApp(
//                 title: 'Adel Azzi - Full Stack Developer Portfolio',
//                 debugShowCheckedModeBanner: false,
//                 themeMode: provider.themeMode,
//                 theme: OptimizedTheme.lightTheme,
//                 darkTheme: OptimizedTheme.darkTheme,
//                 home: child,
//               );
//             },
//             child: const HomeScreen(),
//           );
//         },
//       ),
//     );
//   }
// }
