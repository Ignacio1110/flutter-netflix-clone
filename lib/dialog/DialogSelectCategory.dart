import 'package:flutter/material.dart';

class DialogSelectCategory extends StatefulWidget {
  final searchListType;
  final searchLisCategory;

  DialogSelectCategory({this.searchListType, this.searchLisCategory});

  @override
  _DialogSelectCategoryState createState() => _DialogSelectCategoryState();
}

class _DialogSelectCategoryState extends State<DialogSelectCategory> {
  List<String> _list1 = ["全部", "節目", "電影", "我的片單"];
  List<String> _list2 = [
    "所有類型",
    "可供下載",
    "台灣",
    "犯罪",
    "亞洲",
    "兒童",
    "青少年",
    "科幻/奇幻",
    "科學及自然",
    "紀錄片系列",
    "美國",
    "英國",
    "食物及旅遊",
    "恐怖"
  ];

  String selected = "所有類型";
  List _list;

  @override
  Widget build(BuildContext context) {
    if (widget.searchListType != null) {
      selected = widget.searchListType;
      _list = _list1;
    } else if (widget.searchLisCategory != null) {
      selected = widget.searchLisCategory;
      _list = _list2;
    }

    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.7),
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 64.0),
              child: ListView(
                shrinkWrap: true,
                children: List.generate(
                    _list.length, (index) => _buildTitles(_list[index])),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.cancel,
                  size: 64.0,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildTitles(String data) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        data,
        style: TextStyle(
            fontSize: selected == data ? 24.0 : 20,
            color: selected == data
                ? Colors.white
                : Colors.white.withOpacity(0.6)),
      ),
    ));
  }
}
