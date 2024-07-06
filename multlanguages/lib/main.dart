import 'package:flutter/material.dart';
import 'package:multlanguages/components/controllers.dart';
import 'package:multlanguages/homepage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sp = await SharedPreferences.getInstance();
  final String languageCode = sp.getString('language_code') ?? "";
  runApp(MyApp(
    locale: languageCode,
  ));
}

class MyApp extends StatelessWidget {
  final String locale;
  const MyApp({super.key, required this.locale});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LanguageChangeController())
        ],
        child: Consumer<LanguageChangeController>(
            builder: (context, provider, child) {
          if (locale.isEmpty) {
            provider.changeLanguage(Locale('en'));
          }
          return MaterialApp(
            locale: locale == ''
                ? Locale('en')
                : provider.appLocale == null
                    ? Locale('en')
                    : provider.appLocale,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              Locale('en'),
              Locale('es'),
            ],
            debugShowCheckedModeBanner: false,
            home: HomePage(),
          );
        }));
  }
}
