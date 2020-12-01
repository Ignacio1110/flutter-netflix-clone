import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_neflix_cover/notifications_page.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ComingSoonPage extends StatefulWidget {
  @override
  _ComingSoonPageState createState() => _ComingSoonPageState();
}

class _ComingSoonPageState extends State<ComingSoonPage> {
//  ScrollController _scrollController = ScrollController();
//
//  @override
//  void initState() {
//    _scrollController.addListener(() {
////      print(
////          "_controller offset:${_scrollController.offset} position ${_scrollController.position}");
//    });
//    super.initState();
//  }

//  @override
//  void dispose() {
//    // TODO: implement dispose
//    _scrollController.dispose();
//    super.dispose();
//  }

//  List<GlobalKey> _keys = [];

  int visibleIndex = 0;

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height);
    return Scaffold(
      body: NotificationListener(
        onNotification: (noti) {
          Future.microtask(() {
            var info = getMeta(0, MediaQuery.of(context).size.height * .5);
            print("scrolling to ${info}");
            if (info != null) {
              setState(() {
                visibleIndex = info;
              });
            }
          });
          if (noti is ScrollEndNotification) {
            print('開始播放');
          }
          return true;
        },
        child: ListView.builder(
//          controller: _scrollController,
          itemCount: 10,
          itemBuilder: (BuildContext context, index) {
            if (index == 0) {
              return _buildNotificationItem();
            }
            return _buildItem(index);
          },
        ),
      ),
    );
  }

  T getMeta<T>(double x, double y) {
    var renderBox = context.findRenderObject() as RenderBox;
    var offset = renderBox.localToGlobal(Offset(x, y));

    HitTestResult result = HitTestResult();
    WidgetsBinding.instance.hitTest(result, offset);

    for (var i in result.path) {
      if (i.target is RenderMetaData) {
        var d = i.target as RenderMetaData;
        if (d.metaData is T) {
          return d.metaData as T;
        }
      }
    }
    return null;
  }

  _buildItem(int index) {
    return MetaData(
      metaData: index,
      behavior: HitTestBehavior.translucent,
      child: _buildComingSoonItem(index),
    );
  }

  _buildNotificationItem() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => NotificationsPage()));
      },
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.notifications),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(AppLocalizations.of(context).notification),
          ),
          Expanded(
            child: SizedBox(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.arrow_forward_ios),
          )
        ],
      ),
    );
  }

  _buildComingSoonItem(int index) {
    Color _color = Colors.white.withOpacity(visibleIndex != index ? 0.4 : 1.0);
    return ShaderMask(
      shaderCallback: (rect) {
        return LinearGradient(colors: [_color, _color]).createShader(rect);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VideoItem(),
            Row(
              children: [
                Expanded(
                    child: SizedBox(
                        height: 80.0,
                        child: Image.asset("assets/guiruqing.png"))),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.notifications,
                        size: 20.0,
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        "提醒我",
                        style: TextStyle(
                            color: Colors.grey.withOpacity(0.5),
                            fontSize: 12.0),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.share,
                        size: 20.0,
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        "分享",
                        style: TextStyle(
                            color: Colors.grey.withOpacity(0.5),
                            fontSize: 12.0),
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 4.0,
            ),
            Text(
              "10月9號上線",
              style: TextStyle(color: Colors.grey.withOpacity(0.5)),
            ),
            SizedBox(
              height: 4.0,
            ),
            Text(
              "鬼莊園",
              style: TextStyle(
                fontSize: 22.0,
              ),
            ),
            SizedBox(
              height: 4.0,
            ),
            Text(
                "劇情描述一家七口買下古老的豪宅希爾山莊，打算待上一陣子後即將房屋整頓拋售，藉此大賺一筆，沒想到入住成了惡夢的開始，每個人的未來皆受此影響，影集穿插不少倒敘畫面，以過去和現在的片段交互敘事，有別於一般恐怖電影，不僅營造氛圍技術一流，更著重於角色塑造。影集推出後獲得諸多好評，爛番茄新鮮度目前為 93 %。",
                maxLines: 3,
                style: TextStyle(color: Colors.grey.withOpacity(0.5))),
            SizedBox(
              height: 4.0,
            ),
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                _buildKeyWord("不祥"),
                _buildKeyWord("嚇人"),
                _buildKeyWord("黑暗"),
                _buildKeyWord("感動人心"),
                _buildKeyWord("恐怖片"),
                _buildKeyWord("懸疑推理片"),
                Text(
                  "驚悚片",
                  style: TextStyle(fontSize: 12.0),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _buildKeyWord(String word) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "$word",
          style: TextStyle(fontSize: 12.0),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 2.0,
          ),
        )
      ],
    );
  }
}

class VideoItem extends StatefulWidget {
  @override
  _VideoItemState createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  VideoPlayerController _controller;

  @override
  void initState() {
    // TODO: implement initState
    _controller = VideoPlayerController.asset('assets/gui_zhuang_yuan.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        print('initialize success');
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Center(
          child: _controller.value.isPlaying
              ? AspectRatio(
                  aspectRatio: 16 / 9,
                  child: VideoPlayer(_controller),
                )
              : AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Container(
                    color: Colors.grey,
                    child: Image.asset(
                      "assets/guizhuanyuan2.jpeg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
        ),
        GestureDetector(
            onTap: () {
              setState(() {
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
              });
            },
            child: Icon(
              _controller.value.isPlaying
                  ? Icons.pause
                  : Icons.play_circle_outline,
              size: 60.0,
            ))
      ],
    );
  }
}
