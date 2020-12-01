import 'package:flutter/material.dart';
import 'package:flutter_neflix_cover/home_page.dart';
import 'package:flutter_neflix_cover/model/series_model.dart';
import 'package:flutter_neflix_cover/series_detial_page.dart';

class HomeNavigator extends StatefulWidget {
  @override
  _HomeNavigatorState createState() => _HomeNavigatorState();
}

class _HomeNavigatorState extends State<HomeNavigator> {
  Series _selectedSeries;

  @override
  Widget build(BuildContext context) {
    //Navigator的构造函数中有一个pages参数。如果列表中的Page发生变化，Navigator就会更新堆栈的路由来匹配。
    return Navigator(
      pages: [
        MaterialPage(
            key: ValueKey('HomePage'),
            child: HomePage(
              onTapped: _handleSeriesTapped,
            )),
        // New:
        if (_selectedSeries != null)
          MaterialPage(
              key: ValueKey(_selectedSeries),
              child: SeriesDetailPage(series: _selectedSeries))
      ],
      onPopPage: (route, result) {
        print("route: $route result: $result");
        if (!route.didPop(result)) {
          return false;
        }

        // Update the list of pages by setting _selectedBook to null
        setState(() {
          _selectedSeries = null;
        });
        return true;
      },
    );
  }

  _handleSeriesTapped(Series series) {
    _selectedSeries = series;
    setState(() {});
  }
}
