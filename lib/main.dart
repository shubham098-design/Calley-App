import 'package:calley_app/route/route_page.dart';
import 'package:calley_app/route/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();

  String? languageCode = prefs.getString('language_code');
  String? userId = prefs.getString('id');

  String initialRoute;

  if (languageCode == null || languageCode.isEmpty) {
    // No language set → Go to language selection
    initialRoute = RouteName.language_selection;
  } else if (userId ==null || userId.isEmpty) {
    // Language set but no user ID → Go to signup/login
    initialRoute = RouteName.signup; // or RouteName.login if you have login
  } else {
    // Both language and ID exist → Go to calley ui screen
    initialRoute = RouteName.calley;
  }

  runApp(MyApp(languageCode: languageCode ?? 'hi', initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final String? languageCode;
  final String initialRoute;

  const MyApp({super.key, this.languageCode, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    Locale? appLocale =
    languageCode != null ? Locale(languageCode!) : null;

    return GetMaterialApp(
      supportedLocales: const [
        Locale('en'),
        Locale('hi'),
        Locale('es'),
        Locale('bn'),
        Locale('kn'),
        Locale('pa'),
        Locale('ta'),
        Locale('te'),
        Locale('fr'),
      ],
      locale: appLocale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      title: 'Calley App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      getPages: RoutePage.page,
      initialRoute: initialRoute,
    );
  }
}
