import 'package:floating_snackbar/floating_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shayari/editShayari_Page.dart';
import 'package:shayari/utility.dart';

class ShayariPage extends StatefulWidget {
  int specificIndex;
  int totalShayariIndex;
  List allShayariSpecific = [];

  ShayariPage(
      this.specificIndex, this.totalShayariIndex, this.allShayariSpecific);

  @override
  State<ShayariPage> createState() => _ShayariPageState();
}

class _ShayariPageState extends State<ShayariPage> {
  PageController pageController = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    pageController = PageController(initialPage: widget.specificIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Utils.shayariName[Utils.commonIndex]),
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
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "images/background.jpg",
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                "${widget.specificIndex + 1} / ${widget.totalShayariIndex}",
                style: const TextStyle(
                  color: Colors.indigo,
                  fontWeight: FontWeight.w500,
                  fontSize: 26.0,
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: pageController,
                onPageChanged: (value) {
                  widget.specificIndex = value;
                  setState(() {});
                },
                itemCount: widget.totalShayariIndex,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 12.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.purpleAccent,
                        border: Border.all(
                          color: Colors.black,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      alignment: Alignment.center,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Text(
                          widget.allShayariSpecific[widget.specificIndex],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Spacer(),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.red,
                border: Border.all(
                  color: Colors.black,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              margin: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () async {
                        await Clipboard.setData(
                          ClipboardData(
                            text:
                                widget.allShayariSpecific[widget.specificIndex],
                          ),
                        );
                        FloatingSnackBar(
                          message: "Copied",
                          context: context,
                          textStyle: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w700,
                          ),
                          duration: const Duration(milliseconds: 500),
                          backgroundColor: Colors.white,
                        );
                      },
                      icon: const Icon(
                        Icons.copy,
                        size: 30.0,
                        weight: 50.0,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (widget.specificIndex > 0) {
                          widget.specificIndex = widget.specificIndex - 1;
                          pageController.jumpToPage(widget.specificIndex);
                        }
                        setState(() {});
                      },
                      icon: const Icon(
                        Icons.keyboard_arrow_left_rounded,
                        size: 30.0,
                        weight: 50.0,
                        color: Colors.white,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return EditShayari(
                                widget.allShayariSpecific[widget.specificIndex],
                              );
                            },
                          ),
                        );
                      },
                      child: SizedBox(
                        height: 35,
                        width: 35,
                        child: Image.asset(
                          'images/pencil.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (widget.specificIndex <
                            widget.totalShayariIndex - 1) {
                          widget.specificIndex = widget.specificIndex + 1;
                          pageController.jumpToPage(widget.specificIndex);
                        }
                        setState(() {});
                      },
                      icon: const Icon(
                        Icons.keyboard_arrow_right_rounded,
                        size: 30.0,
                        weight: 50.0,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        Share.share(
                          widget.allShayariSpecific[widget.specificIndex],
                        );
                      },
                      icon: const Icon(
                        Icons.share,
                        size: 30.0,
                        weight: 50.0,
                        color: Colors.white,
                      ),
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
