import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neflix_cover/shared_data_widget.dart';
import 'package:flutter_neflix_cover/coming_soon_page.dart';
import 'package:flutter_neflix_cover/more_page.dart';
import 'package:flutter_neflix_cover/navigator_home.dart';
import 'package:flutter_neflix_cover/serch_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  List<Widget> pages = [
    HomeNavigator(),
    SearchingPage(),
    ComingSoonPage(),
    SearchingPage(),
    MorePage(),
  ];

  int notificationCount = 0;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // notificationCount=10;
    print("notificationCount: $notificationCount");
    return SharedDataWidget(
      data: notificationCount,
      child: Scaffold(
        body: pages[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "首頁"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "搜尋"),
            BottomNavigationBarItem(
                icon: _buildItemWithNotification(), label: "即將上線"),
            BottomNavigationBarItem(
                icon: Icon(Icons.file_download), label: "下載內容"),
            BottomNavigationBarItem(icon: Icon(Icons.more_vert), label: "更多"),
          ],
          iconSize: 24.0,
          backgroundColor: Colors.black54,
          currentIndex: currentIndex,
          selectedFontSize: 12.0,
          unselectedFontSize: 12.0,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            // here we used the navigator key to pop the stack to get back to our
            // main page

            setState(() {
//            navigatorKey.currentState.maybePop();
              currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }

  _buildItemWithNotification() {
    return Stack(
      children: [
        Icon(Icons.featured_play_list),
        if (notificationCount != 0)
          Positioned(
            top: 0,
            right: 0,
            child: Transform.translate(
              offset: Offset(3, -3),
              child: Container(
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(6),
                ),
                constraints: BoxConstraints(
                  minWidth: 12,
                  minHeight: 12,
                ),
                child: Text(
                  '$notificationCount',
                  style: TextStyle(fontSize: 10.0),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )
      ],
    );
  }
}
