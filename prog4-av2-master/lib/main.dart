import 'package:flutter/material.dart';
import './visao/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MaterialApp(
    home: SplashScreenPage(),
    debugShowCheckedModeBanner: false,
    localizationsDelegates: [
      GlobalWidgetsLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: [Locale('pt', 'BR')],
  ));
}
