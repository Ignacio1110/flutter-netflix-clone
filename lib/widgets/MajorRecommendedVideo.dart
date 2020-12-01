import 'package:flutter/material.dart';

class MajorRecommendedVideo extends StatefulWidget {
  @override
  _MajorRecommendedVideoState createState() => _MajorRecommendedVideoState();
}

class _MajorRecommendedVideoState extends State<MajorRecommendedVideo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .7,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                  colors: [Colors.white, Colors.white, Colors.transparent],
                  stops: [0.0, 0.7, 1.0],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)
                  .createShader(bounds);
            },
            child: Image.asset(
              "assets/videophoto2.jpg",
              fit: BoxFit.fitHeight,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    Text("黑暗  "),
                    Text("刺激  "),
                    Text("奇幻動畫  "),
                    Text("動作動畫  "),
                    Text("神話與傳說  "),
                    Text("報復  "),
                  ],
                ),
                SizedBox(
                  height: 24.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add),
                        Text('我的片單'),
                        SizedBox(
                          width: 80,
                        )
                      ],
                    ),
                    Container(
                      width: 90.0,
                      padding: EdgeInsets.all(4.0),
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.play_arrow,
                            size: 30,
                            color: Colors.black,
                          ),
                          Text(
                            "播放",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.info_outline),
                        Text("資訊"),
                        SizedBox(
                          width: 80.0,
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
