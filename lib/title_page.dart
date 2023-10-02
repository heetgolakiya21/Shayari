import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shayari/shayari_page.dart';
import 'package:shayari/utility.dart';

class TitlePage extends StatefulWidget {
  const TitlePage({Key? key}) : super(key: key);

  @override
  State<TitlePage> createState() => _TitlePageState();
}

class _TitlePageState extends State<TitlePage> {
  List<String> shayari = [];

  // Use first when page is call. suppose, this page is call then first init state method call and after build method call.
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (Utils.commonIndex == 0) {
      shayari = Utils.shubhShayari;
    } else if (Utils.commonIndex == 1) {
      shayari = Utils.dostiShayari;
    } else if (Utils.commonIndex == 2) {
      shayari = Utils.godShayari;
    } else if (Utils.commonIndex == 3) {
      shayari = Utils.lifeShayari;
    } else if (Utils.commonIndex == 4) {
      shayari = Utils.loveShayari;
    } else if (Utils.commonIndex == 5) {
      shayari = Utils.rajnitiShayari;
    } else if (Utils.commonIndex == 6) {
      shayari = Utils.birthShayari;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Utils.shayariName[Utils.commonIndex],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.0,
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.red,
        toolbarHeight: 55.5,
        shadowColor: Colors.indigo,
        actions: [
          IconButton(
            onPressed: () {
              Utils.share();
            },
            icon: const Icon(
              Icons.share,
              color: Colors.white,
              size: 20.0,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
              size: 20.0,
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'images/background.jpg',
            ),
            fit: BoxFit.fill,
          ),
        ),
        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: shayari.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.5),
              child: ElevatedButton(
                onPressed: () {
                  Timer(
                    const Duration(milliseconds: 175),
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ShayariPage(
                              index,
                              shayari.length,
                              shayari,
                            );
                          },
                        ),
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: EdgeInsets.zero,
                  backgroundColor: Colors.white,
                  // primary: Colors.red,
                  onPrimary: Colors.indigo,
                  shadowColor: Colors.indigo,
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17.5),
                  ),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundImage: AssetImage(
                          Utils.photo[Utils.commonIndex],
                        ),
                        radius: 22.5,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        shayari[index],
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.red,
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
