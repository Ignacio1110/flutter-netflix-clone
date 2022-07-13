import 'dart:math';

import 'package:flutter/material.dart';

class WonderfulPreview extends StatefulWidget {
  @override
  _WonderfulPreviewState createState() => _WonderfulPreviewState();
}

class _WonderfulPreviewState extends State<WonderfulPreview> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 24.0),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            "精彩預覽",
            style: TextStyle(fontSize: 24.0),
          ),
        ),
        SizedBox(
          height: 140,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(8, (index) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Ink(
                      width: 114,
                      height: 114,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Color.fromRGBO(
                                  Random().nextInt(255),
                                  Random().nextInt(255),
                                  Random().nextInt(255),
                                  1),
                              width: 2.0),
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/videolist/videolist${index + 1}.jpg"),
                              fit: BoxFit.cover)),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(100.0),
                        onLongPress: () {
//                          _globalKey.currentState
//                              .showSnackBar(SnackBar(content: Text("動畫名字")));
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        "劇名圖片",
                        style: TextStyle(fontSize: 22.0),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      height: 10,
                    )
                  ],
                ),
              );
            }),
          ),
        )
      ],
    );
  }
}
