import 'package:darktheme/components/box.dart';
import 'package:darktheme/components/button.dart';
import 'package:darktheme/theme/themeprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: MyBox(
            child: MyButton(
              color: Theme.of(context).colorScheme.primary,
              onTap: () {
                Provider.of<ThemeProvider>(context, listen: false)
                    .toggleTheme();
              },
            ),
            color: Theme.of(context).colorScheme.secondary),
      ),
    );
  }
}
