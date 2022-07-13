import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppSettingPage extends StatefulWidget {
  @override
  _AppSettingPageState createState() => _AppSettingPageState();
}

class _AppSettingPageState extends State<AppSettingPage> {
  TextStyle _textStyle = TextStyle(color: Colors.white, fontSize: 16.0);

  TextStyle titleStyle = TextStyle(color: Colors.white);
  TextStyle subtitleStyle = TextStyle(color: Colors.grey);

  bool _notification = true;
  bool _onlyWiFi = true;
  bool _smartDownload = true;

  @override
  Widget build(BuildContext context) {
    print("notification: $_notification");
    return Scaffold(
      appBar: AppBar(
        title: Text("App設定"),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        children: [
          _buildTitle("視訊播放"),
          _buildListTile(Icons.wifi, "行動數據用量", "自動", null, null),
          _buildTitle("通知"),
          _buildListTile(Icons.notifications, "允許通知", null, _notification,
              (value) {
            _notification = value;
          }),
          _buildTitle("下載內容"),
          _buildListTile(Icons.wifi, "僅限Wi-Fi", null, _onlyWiFi, (value) {
            _onlyWiFi = value;
          }),
          _buildListTile(Icons.file_download, "智慧下載-Fi",
              "看完的集數會被刪除，並替換為下一集，僅限Wi-Fi模式使用。", _smartDownload, (value) {
            _smartDownload = value;
          }),
          _buildListTile(
              Icons.picture_in_picture_alt, "下載畫質", "標準", null, null),
          _buildListTile(
              Icons.format_list_bulleted, "下載位置", "內部儲存空間", null, null),
          _buildListTile(Icons.delete, "刪除所有下載內容", null, null, null),
//          _buildStorage(),
          _buildStorage2(),
          _buildTitle("關於"),
        ],
      ),
    );
  }

  _buildStorage() {
    return Card(
      color: Colors.white.withOpacity(0.2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("內部儲存空間"), Text("預設")],
          ),
          SizedBox(
            height: 10.0,
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Colors.grey,
                Colors.blue,
                Colors.blue,
                Colors.white
              ], stops: [
                0.7,
                0.7,
                0.8,
                0.8,
              ])),
            ),
          ),
          // Container(
          //   decoration: BoxDecoration(
          //     gradient: LinearGradient(

          //     )
          //   ),
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    color: Colors.grey,
                  ),
                  Text("已使用 107GB"),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    color: Colors.blue,
                  ),
                  Text("Netflix 272MB"),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    color: Colors.white,
                  ),
                  Text("可用 11GB"),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  _buildStorage2() {
    return Card(
      color: Colors.white.withOpacity(0.2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("內部儲存空間"), Text("預設")],
          ),
          SizedBox(
            height: 10.0,
            child: Row(
              children: [
                Expanded(
                    flex: 107000,
                    child: Container(
                      color: Colors.grey,
                    )),
                Expanded(
                    flex: 1000,
                    child: Container(
                      color: Colors.blue,
                    )),
                Expanded(
                    flex: 11000,
                    child: Container(
                      color: Colors.white,
                    ))
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    color: Colors.grey,
                  ),
                  Text("已使用 107GB"),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    color: Colors.blue,
                  ),
                  Text("Netflix 272MB"),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    color: Colors.white,
                  ),
                  Text("可用 11GB"),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  _buildListTile(IconData iconData, String title, String subtitle,
      bool _switchState, Function function) {
    print("_buildSwitch $_switchState");
    return Card(
      color: Colors.white.withOpacity(0.2),
      child: ListTile(
        onTap: () {},
        leading: Icon(
          iconData,
          color: Colors.white,
        ),
        title: Text(
          title,
          style: titleStyle,
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle,
                style: subtitleStyle,
              )
            : null,
        trailing: _switchState != null
            ? Switch(
                value: _switchState,
                onChanged: (value) {
                  setState(() {
                    function(value);
                  });
                })
            : null,
      ),
    );
  }

  _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Text(
        title,
        style: _textStyle,
      ),
    );
  }
}
