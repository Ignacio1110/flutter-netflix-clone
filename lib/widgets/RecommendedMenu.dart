import 'package:flutter/material.dart';
import 'package:flutter_neflix_cover/model/series_model.dart';

import '../series_detial_page.dart';

class RecommendedMenu extends StatefulWidget {
  final String title;
  final List<Series> seriesList;
  ValueChanged<Series> onTapped;

  RecommendedMenu(this.title, this.seriesList, this.onTapped);

  @override
  _RecommendedMenuState createState() => _RecommendedMenuState();
}

class _RecommendedMenuState extends State<RecommendedMenu> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 24.0),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            widget.title,
            style: TextStyle(fontSize: 24.0),
          ),
        ),
        SizedBox(
          height: 150,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(8, (index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Ink(
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                          image: AssetImage(
                              "assets/videolist/videolist${index + 1}.jpg"),
                          fit: BoxFit.cover)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8.0),
                    onTap: () {
                      widget.onTapped(widget.seriesList[index]);
                    },
//                    onTap: () {
//                      Navigator.of(context).push(MaterialPageRoute(
//                          builder: (BuildContext context) =>
//                              SeriesDetailPage()));
//                    },
                    onLongPress: () {
//                      Scaffold
//                          .of(context)
//                          .showSnackBar(SnackBar(content: Text("動畫名字")));
//                      _globalKey.currentState
//                          .showSnackBar(SnackBar(content: Text("動畫名字")));
                    },
//                child:Container(width: 100,height: 100,),
                  ),
                ),
              );
            }),
          ),
        )
      ],
    );
  }
}
