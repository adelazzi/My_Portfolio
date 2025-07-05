import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'providers/portfolio_provider.dart';
import 'screens/home_screen.dart';
import 'utils/theme.dart';

void main() {
  // Ensure Flutter bindings are initialized for web
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyPortfolio());
}

class MyPortfolio extends StatelessWidget {
  const MyPortfolio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PortfolioProvider(),
      child: Consumer<PortfolioProvider>(
        builder: (context, provider, _) {
          return ScreenUtilInit(
            designSize: kIsWeb ? const Size(1440, 900) : const Size(414, 896),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp(
                title: 'Adel Azzi - Full Stack Developer Portfolio',
                debugShowCheckedModeBanner: false,
                themeMode: provider.themeMode,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                home: child,
              );
            },
            child: const HomeScreen(),
          );
        },
      ),
    );
  }
}
