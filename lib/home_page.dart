import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_neflix_cover/dialog/DialogSelectCategory.dart';
import 'package:flutter_neflix_cover/model/episode.dart';
import 'package:flutter_neflix_cover/model/series_model.dart';
import 'package:flutter_neflix_cover/series_detial_page.dart';
import 'package:flutter_neflix_cover/specific_category_page.dart';
import 'package:flutter_neflix_cover/widgets/major_recommended_video.dart';
import 'package:flutter_neflix_cover/widgets/recommended_menu.dart';
import 'package:flutter_neflix_cover/widgets/top_10_list.dart';
import 'package:flutter_neflix_cover/widgets/wonderful_preview.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:shimmer/shimmer.dart';

enum SearchListType { All, SERIES, VIDEO }

enum SearchListCategory { All, SERIES, VIDEO }

class HomePage extends StatefulWidget {
  final ValueChanged<Series> onTapped;

  HomePage({this.onTapped});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LinkedScrollControllerGroup _controllers;
  ScrollController _sliverAppbar;
  ScrollController _listView;

  List<Series> _seriesList1 = [
    Series([Episode()], title: ""),
    Series([Episode()], title: ""),
    Series([Episode()], title: ""),
    Series([Episode()], title: ""),
  ];
  List<Series> _seriesList2 = [
    Series([Episode()], title: ""),
    Series([Episode()], title: ""),
    Series([Episode()], title: ""),
    Series([Episode()], title: ""),
  ];
  SearchListType _type = SearchListType.All;

  @override
  void initState() {
    _controllers = LinkedScrollControllerGroup();
    _sliverAppbar = _controllers.addAndGet();
    _listView = _controllers.addAndGet();
    super.initState();
  }

  @override
  void dispose() {
    _sliverAppbar.dispose();
    _listView.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('build homepage');
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          floating: true,
          pinned: false,
          snap: false,
          backgroundColor: Colors.transparent,
          title: _type == SearchListType.All
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                        onTap: () {
                          _type = SearchListType.SERIES;
                          setState(() {});
                        },
                        child: Text("節目")),
                    InkWell(
                        onTap: () {
                          _type = SearchListType.SERIES;
                          setState(() {});
                        },
                        child: Text("電影")),
                    InkWell(
                        onTap: () {
                          _type = SearchListType.SERIES;
                          setState(() {});
                        },
                        child: Text("我的片單")),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        //show dialog
                        var result = showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return DialogSelectCategory(
                                searchListType: "節目",
                              );
                            });
                      },
                      child: Row(
                        children: [
                          Text(
                            "節目",
                            style: TextStyle(fontSize: 20.0),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.arrow_drop_down),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        var result = showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return DialogSelectCategory(
                                searchLisCategory: "所有類型",
                              );
                            });
                      },
                      child: Row(
                        children: [
                          Text(
                            "所有類型",
                            style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.white.withOpacity(0.7)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(Icons.arrow_drop_down),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
          textTheme: TextTheme(
              headline6: TextStyle(color: Colors.white, fontSize: 16.0)),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              "assets/netflix_n.png",
            ),
          ),
        ),
//        _buildLoading(),
        FutureBuilder(
            future: _getData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return SliverList(
                    delegate: SliverChildListDelegate([
                  MajorRecommendedVideo(),
                  WonderfulPreview(),
                  RecommendedMenu("現正熱播", _seriesList1, widget.onTapped),
                  RecommendedMenu("為您推薦", _seriesList2, widget.onTapped),
                  Top10List(),
                  SizedBox(
                    height: 30.0,
                  )
                ]));
              }

              return _buildLoading();
            })
      ]),
    );
  }

  Future _getData() {
    return Future.delayed(Duration(seconds: 2), () {});
  }

  Color _color = Colors.black.withOpacity(0.5);

  _buildLoading() {
    return SliverList(
      delegate: SliverChildListDelegate([
        Shimmer.fromColors(
          baseColor: Colors.grey[300].withOpacity(0.5),
          highlightColor: Colors.grey[100].withOpacity(0.5),
          direction: ShimmerDirection.ttb,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: _color,
                margin: EdgeInsets.all(8.0),
                width: 160,
                height: 80,
              ),
              Container(
                color: _color,
                margin: EdgeInsets.all(8.0),
                width: 200,
                height: 20,
              ),
              Container(
                color: _color,
                margin: EdgeInsets.all(8.0),
                width: 80,
                height: 30,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  color: _color,
                  margin: EdgeInsets.all(8.0),
                  width: 150,
                  height: 20,
                ),
              ),
              SizedBox(
                height: 120,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: List.generate(
                      4,
                      (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: _color,
                              radius: MediaQuery.of(context).size.width * 0.12,
                            ),
                          )),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  color: _color,
                  margin: EdgeInsets.all(8.0),
                  width: 150,
                  height: 20,
                ),
              ),
              SizedBox(
                height: 120,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: List.generate(
                    4,
                    (index) => Container(
                      height: 120,
                      width: 100,
                      color: _color,
                      margin: EdgeInsets.all(4.0),
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}
