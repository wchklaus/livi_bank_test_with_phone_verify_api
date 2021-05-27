// Dart Packages
import 'dart:async';

// Flutter Packages
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// Third Party Packages
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

// Customized Packages
import 'package:country_code_picker/country_localizations.dart';

// Project Modules
import 'package:livi_bank_test/common/const/support_locals.dart';
import 'package:livi_bank_test/common/const/theme.dart';
import 'package:livi_bank_test/common/model/phone_validation_result.dart';
import 'package:livi_bank_test/common/util/theme_notifier.dart';
import 'package:livi_bank_test/home/hom_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DotEnv.load(fileName: '.env');
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Hive.initFlutter();
  Hive.registerAdapter(PhoneValidationResultAdapter());
  await Hive.openBox<PhoneValidationResult>('PhoneValidationResult');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeNotifier(),
        ),
      ],
      child: LiviBank(),
    ),
  );
}

class LiviBank extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      supportedLocales: supportedLocales,
      localizationsDelegates: [
        CountryLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      showPerformanceOverlay: false,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: themeProvider.themeMode,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
