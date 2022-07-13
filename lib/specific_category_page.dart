import 'package:flutter/material.dart';
import 'package:flutter_neflix_cover/widgets/major_recommended_video.dart';
import 'package:flutter_neflix_cover/widgets/recommended_menu.dart';
import 'package:flutter_neflix_cover/widgets/top_10_list.dart';
import 'package:flutter_neflix_cover/widgets/wonderful_preview.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

import 'model/episode.dart';
import 'model/series_model.dart';

class SpecificCategoryPage extends StatefulWidget {
  @override
  _SpecificCategoryPageState createState() => _SpecificCategoryPageState();
}

class _SpecificCategoryPageState extends State<SpecificCategoryPage> {
  GlobalKey<ScaffoldState> _globalKey =
      GlobalKey(debugLabel: "test scaffoldState");

  LinkedScrollControllerGroup _controllers;
  ScrollController _sliverAppbar;
  ScrollController _listView;

  Series _series1;
  Series _series2;

  @override
  void initState() {
    _series1 = Series([Episode()], title: "現正熱播");
    _series2 = Series([Episode()], title: "為您推薦");

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
    return Scaffold(
      key: _globalKey,
      body: CustomScrollView(slivers: [
        SliverAppBar(
          floating: true,
          pinned: false,
          snap: false,
          backgroundColor: Colors.transparent,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("節目"),
              Hero(tag: "dash", child: Text("電影")),
              Text("我的片單"),
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
        SliverList(
            delegate: SliverChildListDelegate([
          MajorRecommendedVideo(),
          WonderfulPreview(),
//          RecommendedMenu(_series1),
//          RecommendedMenu(_series2),
          Top10List(),
          SizedBox(
            height: 30.0,
          )
        ])),
      ]),
    );
  }
}
