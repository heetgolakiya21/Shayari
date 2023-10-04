import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shayari/home_page.dart';
import 'package:shayari/splash_page.dart';
import 'package:shayari/themes.dart';
import 'package:shayari/title_page.dart';

void main() {
  runApp(
    MaterialApp(
      title: "Shayari App",
      debugShowCheckedModeBanner: false,
      // debugShowMaterialGrid: false,
      // showPerformanceOverlay: false,
      theme: CustomeThemes.lightTheme,
      // home: const SplashPage(),
      initialRoute: 'splash_page',
      routes: {
        'splash_page': (context) => const SplashPage(),
        'home_page': (context) => const HomePage(),
        'title_page': (context) => const TitlePage(),
      },
    ),
  );

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.landscapeLeft]);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.dark,
    systemNavigationBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.transparent,
  ));
}
