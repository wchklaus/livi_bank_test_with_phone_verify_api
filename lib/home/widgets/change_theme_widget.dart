// Flutter Packages
import 'package:flutter/material.dart';

// Third Party Packages
import 'package:provider/provider.dart';

// Project Modules
import 'package:livi_bank_test/common/util/theme_notifier.dart';

class ChangeThemeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeNotifier>(context);
    return StatefulBuilder(
      builder: (BuildContext context, setState) {
        return IconButton(
          icon: themeProvider.isDarkMode
              ? Icon(Icons.dark_mode)
              : Icon(Icons.light_mode),
          color: Theme.of(context).hintColor,
          onPressed: () {
            setState(
              () {
                final provider =
                    Provider.of<ThemeNotifier>(context, listen: false);
                provider.toggleTheme(!themeProvider.isDarkMode);
              },
            );
          },
        );
      },
    );
  }
}
