import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shayari/utility.dart';
import 'dart:math' as math;

class EditShayari extends StatefulWidget {
  String allShayariSpecific;

  EditShayari(
    this.allShayariSpecific,
  ); // const EditShayari({Key? key}) : super(key: key);

  @override
  State<EditShayari> createState() => _EditShayariState();
}

class _EditShayariState extends State<EditShayari> {
  Color backColor = Colors.purpleAccent;

  void backColor2() {
    setState(() {
      backColor = Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
          .withOpacity(1.0);
    });
  }

  Future backColorSet() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Pick a color",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.indigo,
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: backColor,
              onColorChanged: (Color color) {
                setState(() {
                  backColor = color;
                });
              },
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('DONE'),
              onPressed: () {
                Navigator.of(context).pop(); //dismiss the color picker
              },
            ),
          ],
        );
      },
    );
  }

  List txtColorList = [
    Colors.purple,
    Colors.deepPurple,
    Colors.purpleAccent,
    Colors.deepPurpleAccent,
    Colors.indigo,
    Colors.indigoAccent,
    Colors.blueGrey,
    Colors.blue,
    Colors.lightBlue,
    Colors.blueAccent,
    Colors.lightBlueAccent,
    Colors.amber,
    Colors.amberAccent,
    Colors.yellow,
    Colors.yellowAccent,
    Colors.lime,
    Colors.limeAccent,
    Colors.black,
    Colors.white,
    Colors.orange,
    Colors.deepOrange,
    Colors.orangeAccent,
    Colors.deepOrangeAccent,
    Colors.red,
    Colors.redAccent,
    Colors.pink,
    Colors.pinkAccent,
    Colors.brown,
    Colors.green,
    Colors.lightGreen,
    Colors.greenAccent,
    Colors.lightGreenAccent,
    Colors.cyan,
    Colors.cyanAccent,
    Colors.teal,
    Colors.tealAccent,
  ];

  Color txtColor = Colors.white;

  Future txtColorSet() {
    return showModalBottomSheet(
      isDismissible: false,
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0.5),
          ),
          // color: Colors.purpleAccent,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                  ),
                  itemCount: txtColorList.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            txtColor = txtColorList[index];
                          });
                        },
                        child: Container(
                          color: txtColorList[index],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 8.0, left: 3.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.zero,
                    shape: const CircleBorder(
                      side: BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.all(10.0),
                  ),
                  child: const Icon(Icons.close_outlined,
                      size: 25.0, weight: 40.0),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<Uint8List> _capturePng() async {
    try {
      RenderRepaintBoundary? boundary = globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary?;
      ui.Image image = await boundary!.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      var pngBytes = byteData!.buffer.asUint8List();
      // var bs64 = base64Encode(pngBytes);
      return pngBytes;
    } catch (e) {
      return Future.value();
    }
  }

  GlobalKey globalKey = GlobalKey();

  double txtSize = 20.0;

  Future txtSizeSet() {
    return showModalBottomSheet(
      isDismissible: false,
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState1) {
            return Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 0.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 8.0, right: 8.0, left: 3.0),
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.zero,
                        shape: const CircleBorder(
                          side: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.all(10.0),
                      ),
                      child: const Icon(Icons.close_outlined,
                          size: 25.0, weight: 40.0),
                    ),
                  ),
                  const Spacer(),
                  Slider(
                    value: txtSize,
                    min: 10.0,
                    max: 100.0,
                    activeColor: Colors.red,
                    inactiveColor: Colors.purpleAccent,
                    thumbColor: Colors.green,
                    overlayColor: const MaterialStatePropertyAll(Colors.purple),
                    onChanged: (value) {
                      setState(() {
                        setState1(() {
                          txtSize = value;
                        });
                      });
                      print(value);
                    },
                  ),
                  const Spacer(),
                ],
              ),
            );
          },
        );
      },
    );
  }

  String defaultTxtFamily = "Hindi1";

  List txtFamily = ["Hindi1", "Hindi2"];

  Future txtFamilySet() {
    return showModalBottomSheet(
      isDismissible: false,
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState1) {
            return Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 0.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 8.0, right: 8.0, left: 3.0),
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.zero,
                        shape: const CircleBorder(
                          side: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.all(10.0),
                      ),
                      child: const Icon(Icons.close_outlined,
                          size: 25.0, weight: 40.0),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: txtFamily.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 8.0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                defaultTxtFamily = txtFamily[index];
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.purpleAccent,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1.0,
                                  style: BorderStyle.solid,
                                ),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              alignment: Alignment.center,
                              padding: const EdgeInsets.fromLTRB(
                                  15.0, 7.0, 15.0, 2.0),
                              child: Text(
                                'शायरी',
                                style: TextStyle(
                                  fontSize: 25.0,
                                  color: Colors.white,
                                  fontFamily: txtFamily[index],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  List emoji = [
    "Without Emoji",
    "💛💚💙🖤🤍❤️",
    "😍🥰😘",
    "😜🤪",
    "😊😍😘❤👫🏽😊😎",
    "🤗🤔",
    "🥳🤩🎈",
    "💔",
    "🙏🙏",
    "🌷🌸🌻🥀🌼🌹🌹",
    "🔥",
    "💕💞💓💗💖💘💝",
    "👑",
    "😡🤬",
    "😈",
    "😂🤣",
    "👐🙌"
  ];

  String blank = "";

  Future emojiSet() {
    return showModalBottomSheet(
      isDismissible: false,
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0.5),
          ),
          // color: Colors.purpleAccent,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: emoji.length,
                  itemBuilder: (context, index) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            if (index == 0) {
                              setState(() {
                                blank = "";
                              });
                            } else {
                              setState(() {
                                blank = emoji[index];
                              });
                            }
                          },
                          child: Text(
                            '${emoji[index]}',
                            style: const TextStyle(
                              fontSize: 30.0,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 8.0, left: 3.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.zero,
                    shape: const CircleBorder(
                      side: BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.all(10.0),
                  ),
                  child: const Icon(Icons.close_outlined,
                      size: 25.0, weight: 40.0),
                ),
              ),
            ],
          ),
        );
      },
    );
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
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'images/background.jpg',
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                child: InkWell(
                  onTap: backColor2,
                  child: RepaintBoundary(
                    key: globalKey,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: backColor,
                        border: Border.all(
                          color: Colors.white,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(20.5),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 10.0,
                      ),
                      alignment: Alignment.center,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Text(
                          '$blank ${widget.allShayariSpecific} $blank',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: txtColor,
                            fontFamily: defaultTxtFamily,
                            fontWeight: FontWeight.w500,
                            fontSize: txtSize,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Expanded(
            //   child: Container(),
            // ),
            // const Spacer(), // it contains space with expanded.
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Colors.grey,
                    Colors.brown,
                    Colors.grey,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                // color: Colors.brown,
                border: Border.all(
                  color: Colors.black,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              margin: const EdgeInsets.all(10.0),
              child: Padding(
                padding: const EdgeInsets.all(9.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 9.0,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: backColorSet,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                onPrimary: Colors.purpleAccent,
                                side: const BorderSide(
                                  width: 1.0,
                                  color: Colors.white,
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15.0),
                              ),
                              child: const Icon(
                                Icons.color_lens_outlined,
                                color: Colors.white,
                                size: 27.0,
                              ),
                            ),
                          ),
                          const SizedBox(width: 9.0),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: txtColorSet,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                onPrimary: Colors.purpleAccent,
                                side: const BorderSide(
                                  width: 1.0,
                                  color: Colors.white,
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15.0),
                              ),
                              child: const Icon(
                                Icons.format_color_text_outlined,
                                color: Colors.white,
                                size: 27.0,
                              ),
                            ),
                          ),
                          const SizedBox(width: 9.0),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                if (await Permission.storage
                                    .request()
                                    .isGranted) {
                                  _capturePng().then(
                                    (value) async {
                                      // For Creating File Number
                                      DateTime dt = DateTime.now();
                                      String time =
                                          '${dt.year}${dt.month}${dt.day}${dt.hour}${dt.minute}${dt.second}';

                                      // For Creating Directory
                                      final directory =
                                          await getExternalStorageDirectory();
                                      final dirPath =
                                          "${directory?.path}/Shayari";
                                      await Directory(dirPath).create();

                                      // For Creating File
                                      String fileName =
                                          "$dirPath/image$time.jpg";
                                      File file = File(fileName);
                                      file.create();

                                      // Input Image into File.
                                      File f = await file.writeAsBytes(value);

                                      Share.shareFiles(
                                        [f.path],
                                        // text:
                                        //     'Use this link for download an App :\t https://play.google.com/store/apps/details?id=com.ghj.Shayari.shayari \n\n This is Shayari App. It is use for Customize and Share shayari.\n\n Developed by Heet Golakiya.',
                                      );
                                    },
                                  );
                                } else {
                                  // Here implement Flutter Toast.
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          "Please Allow Access for Share the Content"),
                                    ),
                                  );
                                  print(
                                      'Please Allow Access to Share the Content');
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                onPrimary: Colors.purpleAccent,
                                side: const BorderSide(
                                  width: 1.0,
                                  color: Colors.white,
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15.0),
                              ),
                              child: const Icon(
                                Icons.share,
                                color: Colors.white,
                                size: 27.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: txtFamilySet,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              onPrimary: Colors.purpleAccent,
                              side: const BorderSide(
                                width: 1.0,
                                color: Colors.white,
                              ),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                            ),
                            child: const Icon(
                              Icons.font_download,
                              color: Colors.white,
                              size: 27.0,
                            ),
                          ),
                        ),
                        const SizedBox(width: 9.0),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: emojiSet,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              onPrimary: Colors.purpleAccent,
                              side: const BorderSide(
                                width: 1.0,
                                color: Colors.white,
                              ),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                            ),
                            child: const Icon(
                              Icons.emoji_emotions,
                              color: Colors.white,
                              size: 27.0,
                            ),
                          ),
                        ),
                        const SizedBox(width: 9.0),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: txtSizeSet,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              onPrimary: Colors.purpleAccent,
                              side: const BorderSide(
                                width: 1.0,
                                color: Colors.white,
                              ),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                            ),
                            child: const Icon(
                              Icons.format_size,
                              color: Colors.white,
                              size: 27.0,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
