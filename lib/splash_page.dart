import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shayari/home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    permission();
  }

  permission() async {
    if (await Permission.storage.request().isGranted) {
      pushReplacement();
      createFolder();
    } else {
      pushReplacement();
    }
  }

  createFolder() async {
    final directory = await getExternalStorageDirectory();
    final dirPath = '${directory?.path}/Shayari';
    await Directory(dirPath).create();
  }

  pushReplacement() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const HomePage();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Image.asset(
            'images/logo.png',
            height: 130,
          ),
        ),
      ),
    );
  }
}
