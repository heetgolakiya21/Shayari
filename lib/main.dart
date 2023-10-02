import 'package:flutter/material.dart';
import 'package:shayari/home_page.dart';
import 'package:shayari/splash_page.dart';

void main() {
  runApp(
    const MaterialApp(
      home: SplashPage(),
      title: "Shayari App",
      debugShowCheckedModeBanner: false,
    ),
  );
}
