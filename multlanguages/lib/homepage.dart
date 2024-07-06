import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:multlanguages/components/controllers.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

enum Language { english, spanish }

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Consumer<LanguageChangeController>(
                builder: (context, provider, child) {
              return PopupMenuButton(
                  onSelected: (Language item) {
                    if (Language.english.name == item.name) {
                      provider.changeLanguage(Locale('en'));
                    } else {
                      provider.changeLanguage(Locale('es'));
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<Language>>[
                        PopupMenuItem(
                          value: Language.english,
                          child: Text('English'),
                        ),
                        PopupMenuItem(
                          value: Language.spanish,
                          child: Text('Spanish'),
                        )
                      ]);
            })
          ],
          title: Center(child: Text(AppLocalizations.of(context)!.helloWorld)),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.name,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ));
  }
}
