import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shayari/utility.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<bool> showExitPopup(context) async {
    return await showDialog(
        context: context,
        barrierDismissible: false,
        // barrierColor: Colors.transparent,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              height: 90,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Do you want to exit an App ?"),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // it is recommended for android.
                            exit(0);

                            // it is not recommended for android. because it works on background not close fully.
                            // SystemNavigator.pop();

                            // it is not work properly.
                            // Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.red.shade800),
                          child: const Text("Yes"),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                        ),
                        child: const Text(
                          "No",
                          style: TextStyle(color: Colors.black),
                        ),
                      ))
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Shayari"),
          actions: [
            IconButton(
              onPressed: () {
                Utils.share();
              },
              icon: const Icon(Icons.share),
            ),
            PopupMenuButton(
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 1,
                  child: Text("About us"),
                ),
              ],
              iconSize: 20.0,
              color: Colors.white,
              onSelected: (value) {
                if (value == 1) {
                  Utils.aboutDialogue(context);
                }
              },
            ),
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "images/background.jpg",
              ),
              fit: BoxFit.fill,
            ),
          ),
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: Utils.photo.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.5),
                child: ElevatedButton(
                  onPressed: () {
                    Utils.commonIndex = index;
                    Timer(
                      const Duration(milliseconds: 175),
                      () {
                        Navigator.pushNamed(context, 'title_page');
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                    backgroundColor: Colors.white,
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
                            Utils.photo[index],
                          ),
                          radius: 22.5,
                        ),
                      ),
                      Text(
                        Utils.shayariName[index],
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
