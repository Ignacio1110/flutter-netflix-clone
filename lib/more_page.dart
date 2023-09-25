import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_neflix_cover/app_setting_page.dart';
import 'package:flutter_neflix_cover/model/user.dart';

class MorePage extends StatefulWidget {
  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  String jsonUserData =
      "{\"users\":[{\"name\":\"p1\",\"assets_name\":\"assets\/icons\/icon_user.jpg\"},{\"name\":\"p1\",\"assets_name\":\"assets\/icons\/icon_user.jpg\"},{\"name\":\"p1\",\"assets_name\":\"assets\/icons\/icon_user.jpg\"},{\"name\":\"p1\",\"assets_name\":\"assets\/icons\/icon_user.jpg\"},{\"name\":\"p1\",\"assets_name\":\"assets\/icons\/icon_user.jpg\"}]}";
  List<User> _users = [
    User("Player1", "assets/icons/icon_user.jpg"),
    User("Player2", "assets/icons/icon_user.jpg"),
    User("Player3", "assets/icons/icon_user.jpg"),
    User("Player4", "assets/icons/icon_user.jpg"),
    User("Player5", "assets/icons/icon_user.jpg"),
  ];

  TextStyle labelStyle = TextStyle(color: Colors.grey);
  TextStyle titleStyle = TextStyle(color: Colors.white, fontSize: 18);
  TextStyle textStyle = TextStyle(color: Colors.white, fontSize: 14);
  TextStyle textStyle2 = TextStyle(color: Colors.grey, fontSize: 12);

  @override
  Widget build(BuildContext context) {
    Map data = json.decode(jsonUserData);
    print(data);
    print(data['users']);
    _users.clear();
    (data['users'] as List).forEach((element) {
      _users.add(User.fromJson(element));
    });

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildUserList(_users, _selectedIndex),
            _buildEditButton(),
            _buildShareLink(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Icon(Icons.check),
                  Text(
                    "我的片單",
                    style: labelStyle.copyWith(fontSize: 18),
                  )
                ],
              ),
            ),
            Divider(
              height: 4.0,
              color: Colors.grey,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => AppSettingPage()));
              },
              child: Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  width: double.infinity,
                  child: Text(
                    "App設定",
                    style: labelStyle.copyWith(fontSize: 18.0),
                  )),
            ),
            Container(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                width: double.infinity,
                child: Text(
                  "帳戶",
                  style: labelStyle.copyWith(fontSize: 18.0),
                )),
            Container(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                width: double.infinity,
                child: Text(
                  "說明",
                  style: labelStyle.copyWith(fontSize: 18.0),
                )),
            Container(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                width: double.infinity,
                child: Text(
                  "登出",
                  style: labelStyle.copyWith(fontSize: 18.0),
                ))
          ],
        ),
      ),
    );
  }

  int _selectedIndex = 0;

  _buildUserList(List<User> users, int selectedIndex) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
              5,
              (index) =>
                  _buildUserItemImage(_users[index], index, selectedIndex)),
        ),
        Row(
          children: List.generate(
              5,
              (index) =>
                  _buildUserItemName(_users[index], index, selectedIndex)),
        )
      ],
    );
  }

  _buildUserItemImage(User user, int index, int selectedIndex) {
    return Flexible(
      flex: selectedIndex == index ? 4 : 3,
      child: GestureDetector(
        onTap: () {
          _selectedIndex = index;
          setState(() {
            print("selectedIndex :$selectedIndex");
          });
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Image.asset(user.assetName),
            ],
          ),
        ),
      ),
    );
  }

  _buildUserItemName(User user, int index, int selectedIndex) {
    return Flexible(
      flex: selectedIndex == index ? 4 : 3,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Text(
          user.name,
          style: TextStyle(
              color: selectedIndex == index ? Colors.white : Colors.grey),
        ),
      ),
    );
  }

  _buildEditButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(foregroundColor: Colors.black),
        icon: Icon(
          Icons.edit,
        ),
        onPressed: () {},
        label: Text(
          "管理使用者",
          style: labelStyle.copyWith(
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  _buildShareLink() {
    return Container(
      color: Colors.grey.withOpacity(0.2),
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.message),
              Text(
                " 將 Netflix 介紹給朋友。",
                style: titleStyle,
              )
            ],
          ),
          Text(
            "將此連結分享給朋友，讓他們也可以一起討論您最喜愛的節目與電影。",
            style: textStyle,
          ),
          Text(
            "條款與條件",
            style: textStyle2,
          ),
          Container(
            color: Colors.black,
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  "https://www.netflix.com/browse/saiosfhaisfjaosfasf",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () {},
                    child: Text("複製連結"),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              _buildShareIcon("Line", "assets/icons/line.png"),
              _buildDivider(),
              _buildShareIcon("Facebook", "assets/icons/facebook.png"),
              _buildDivider(),
              _buildShareIcon("Gmail", "assets/icons/Gmail-icon.png"),
              _buildDivider(),
              Expanded(
                child: Column(
                  children: [
                    Container(
                        margin: EdgeInsets.all(4.0),
                        width: 30.0,
                        height: 30.0,
                        child: Icon(Icons.more_horiz)),
                    Text("更多")
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  _buildShareIcon(String title, String assetName) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Image.asset(
              assetName,
              width: 30,
              height: 30,
            ),
          ),
          Text(title)
        ],
      ),
    );
  }

  _buildDivider() {
    return Container(
      width: 2,
      height: 40,
      color: Colors.grey.withOpacity(0.6),
    );
  }
}
