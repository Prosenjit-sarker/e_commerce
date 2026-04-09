import 'package:crafty_bay/app/providers/language_provider.dart';
import 'package:crafty_bay/app/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../features/category/presentation/providers/category_list_provider.dart';
import '../features/home/presentation/providers/home_slider_provider.dart';
import '../features/shared/Presentation/providers/main_nav_provider.dart';
import '../l10n/app_localizations.dart';
import 'app_routes.dart';
import 'app_theme.dart';

class CraftyBayApp extends StatelessWidget {
  const CraftyBayApp({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => MainNavProvider()),
        ChangeNotifierProvider(create: (context) => HomeSliderProvider()),
        ChangeNotifierProvider(create: (context) => CategoryListProvider()),


      ],
      child: Consumer2<LanguageProvider, ThemeProvider>(
        builder: (context, languageProvider, themeProvider, child) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            initialRoute: '/',
            onGenerateRoute: AppRoutes.onGenerateRoute,
            theme: AppTheme.lightTheme,

            darkTheme: AppTheme.darkTheme,
            locale: languageProvider.currentLocale,
            supportedLocales: AppLocalizations.supportedLocales,
            themeMode: themeProvider.themeMode,
          );
        }
      ),
    );
  }
}
