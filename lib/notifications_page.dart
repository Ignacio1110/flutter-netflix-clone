import 'dart:math';

import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Center(
                  child: Text(
                "通知",
                style: TextStyle(fontSize: 20.0),
              )),
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back),
                  ),
                ),
              ),
            ],
          ),
          _buildNewVideoNotification("最新到片", "非常校護檔案"),
          _buildNewVideoNotification("最新到片", "以家人之名"),
          _buildNewVideoNotification("最新到片", "龍族教義"),
          _buildNewVideoNotification("最新到片", "詐騙之王"),
          _buildManyVideosNotification('本日10大熱門排行：台灣', "觀賞所有影片"),
          _buildNewVideoNotification("繼續觀賞", "雖然是精神病但沒關係"),
          _buildManyVideosNotification("重看你最喜歡的片段", "瀏覽你看過的作品")
        ],
      ),
    );
  }

  _buildNewVideoNotification(String title, String subtitle) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.all(8.0),
          width: 120,
          height: 70,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                  image: AssetImage(
                      "assets/videolist/videolist${Random().nextInt(7) + 1}.jpg"),
                  fit: BoxFit.cover)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$title",
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                "$subtitle",
                style: TextStyle(color: Colors.grey, fontSize: 16.0),
              ),
              Text("9月27日",
                  style: TextStyle(color: Colors.grey, fontSize: 12.0))
            ],
          ),
        )
      ],
    );
  }

  _buildManyVideosNotification(String title, String subtitle) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            margin: EdgeInsets.only(right: 16.0, bottom: 8.0),
            width: 104,
            height: 58,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(color: Color(0xff444444), offset: Offset(16, 8)),
                  BoxShadow(color: Color(0xff666666), offset: Offset(8, 4)),
                ],
                image: DecorationImage(
                    image: AssetImage(
                        "assets/videolist/videolist${Random().nextInt(7) + 1}.jpg"),
                    fit: BoxFit.cover)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$title",
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                "$subtitle",
                style: TextStyle(color: Colors.grey, fontSize: 16.0),
              ),
              Text("9月27日",
                  style: TextStyle(color: Colors.grey, fontSize: 12.0))
            ],
          ),
        )
      ],
    );
  }
}
