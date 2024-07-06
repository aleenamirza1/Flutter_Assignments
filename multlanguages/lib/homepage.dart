import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

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
          PopupMenuButton(
              itemBuilder: (BuildContext context) => <PopupMenuEntry<Language>>[
                    PopupMenuItem(
                      value: Language.english,
                      child: Text('English'),
                    ),
                    PopupMenuItem(
                      value: Language.spanish,
                      child: Text('Spanish'),
                    )
                  ])
        ],
        title: Text(AppLocalizations.of(context)!.helloWorld),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
