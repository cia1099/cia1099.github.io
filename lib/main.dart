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
    runApp(
      EasyDynamicThemeWidget(
        child: EasyLocalization(
          child: MyApp(),
          supportedLocales: const [
            Locale('en'),
            Locale('zh', 'CN'),
            Locale('zh', 'TW')
          ],
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
  static const monitorUrl = 'http://localhost:50050';
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
      home:
          // ExperiencePage(),
          HomePage(),
      initialRoute: MyApp.home,
      //customized route by PageRouteBuilder
      onGenerateRoute: (settings) => MaterialPageRoute(
          settings: settings,
          builder: (context) {
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
          }),
    );
  }
}
