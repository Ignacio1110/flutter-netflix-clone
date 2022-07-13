import 'package:flutter/material.dart';

class Top10List extends StatefulWidget {
  @override
  _Top10ListState createState() => _Top10ListState();
}

class _Top10ListState extends State<Top10List> {
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
            "榮登本日台灣排行榜前10名",
            style: TextStyle(fontSize: 24.0),
          ),
        ),
        SizedBox(
          height: 150,
          child: ListView(
            padding: EdgeInsets.only(left: 30.0),
            scrollDirection: Axis.horizontal,
            children: List.generate(8, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: index != 0
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(0.0),
                        child: _buildTop10Item(index),
                      )
                    : _buildTop10Item(index),
              );
            }),
          ),
        )
      ],
    );
  }

  _buildTop10Item(int index) {
    return SizedBox(
      width: 120,
      child: Stack(
        // overflow: Overflow.visible,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Ink(
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                      image: AssetImage(
                          "assets/videolist/videolist${index + 1}.jpg"),
                      fit: BoxFit.cover)),
              child: InkWell(
                borderRadius: BorderRadius.circular(8.0),
                onLongPress: () {
//                  _globalKey.currentState
//                      .showSnackBar(SnackBar(content: Text("動畫名字")));
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Transform.translate(
              offset: Offset(-14, 0),
              child: Text(
                "${index + 1}",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 100.0,
                    fontWeight: FontWeight.w700,
                    height: 0.2,
                    letterSpacing: 0.0,
                    wordSpacing: 0.0,
                    shadows: [
                      Shadow(
                          // bottomLeft
                          offset: Offset(-1.5, -1.5),
                          color: Colors.white),
                      Shadow(
                          // bottomRight
                          offset: Offset(1.5, -1.5),
                          color: Colors.white),
                      Shadow(
                          // topRight
                          offset: Offset(1.5, 1.5),
                          color: Colors.white),
                      Shadow(
                          // topLeft
                          offset: Offset(-1.5, 1.5),
                          color: Colors.white),
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
