import 'dart:math';
import 'dart:html' as html;

import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:portfolio/screens/experience.dart';
import 'package:portfolio/screens/html_page.dart';
import 'package:portfolio/utils/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';

import 'screens/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  EasyLocalization.ensureInitialized().then((_) {
    const support = [Locale('en'), Locale('zh', 'CN'), Locale('zh', 'TW')];
    runApp(
      EasyDynamicThemeWidget(
        child: EasyLocalization(
          child: MyApp(),
          supportedLocales: support,
          startLocale: getBrowserLocale(support),
          path: 'assets/langs/langs.yaml',
          fallbackLocale: Locale('en'),
          assetLoader: YamlSingleAssetLoader(),
        ),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  static const home = '/';
  static const experience = '/work_experiences';
  static const lan = '/lan';
  static const monitorUrl = 'https://www.cia1099.cloudns.ch/api';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile',
      theme: lightThemeData,
      darkTheme: darkThemeData,
      debugShowCheckedModeBanner: false,
      themeMode: EasyDynamicTheme.of(context).themeMode,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      initialRoute: MyApp.home,
      onGenerateRoute: (settings) => PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation, secondaryAnimation) {
          final uri = Uri.tryParse(settings.name!);
          if (uri != null) {
            switch (uri.path) {
              case MyApp.experience:
                return ExperiencePage();
              case MyApp.lan:
                return HtmlPage(
                    url: MyApp.monitorUrl,
                    path: MyApp.lan,
                    queryArgs: uri.queryParameters);
            }
          }
          return HomePage();
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            Transform.rotate(
          angle: Tween(begin: .0, end: -pi / 2).evaluate(animation),
          alignment: Alignment.bottomRight,
          child: Transform.rotate(
            angle: pi / 2,
            alignment: Alignment.bottomRight,
            child: child,
          ),
        ),
      ),
    );
  }
}

Locale getBrowserLocale(List<Locale> supports) {
  String browserLanguage = html.window.navigator.language;
  // print('\x1b[43mBrowser language: $browserLanguage\x1b[0m');
  final langCountry = browserLanguage.split("-");
  final browserLocale = Locale.fromSubtags(
      languageCode: langCountry.first, countryCode: langCountry.lastOrNull);
  return supports.firstWhere((loc) => loc == browserLocale,
      orElse: () => const Locale('en'));
}
