import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_neflix_cover/model/episode.dart';
import 'package:flutter_neflix_cover/model/series_model.dart';

class SeriesDetailPage extends StatefulWidget {
  Series series;
  SeriesDetailPage({this.series});
  @override
  _SeriesDetailPageState createState() => _SeriesDetailPageState();
}

class _SeriesDetailPageState extends State<SeriesDetailPage>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  List<Episode> _listEpisodes = List();

  void generateEpisodes() {
    for (int i = 0; i < 26; i++) {
      _listEpisodes.add(
        Episode(
            name: "${i + 1}。第${i + 1}集",
            description: "梅普露和莎莉於第二次活動中打倒「銀翼」後，從在牠的鳥巢中得到的「幻獸的蛋」中孵化的寵物狐狸。"
                "擅長幻術以及分身系的技能，其中最具代表性的技能就是在第四次活動中將因使用「流滲的混沌」系列技能中的「暴虐」而怪物化的梅普露變成好幾隻，並造成大量敵對玩家心理陰影的「幻影世界（Phantom World）」。",
            imageAssetsName: "assets/videolist/videolist7.jpg",
            duration: "22分鐘"),
      );
    }
  }

  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      initialIndex: selectedIndex,
      length: 2,
      vsync: this,
    );
    super.initState();
    generateEpisodes();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            _buildMainDetail(),
            Divider(
              color: Colors.grey.withOpacity(0.5),
              thickness: 2.0,
              height: 2.0,
            ),
            TabBar(
              indicator: BoxDecoration(
                  border: Border(
                top: BorderSide(color: Colors.red, width: 4.0),
              )),
              controller: _tabController,
              tabs: [
                Tab(
                  text: "集數",
                ),
                Tab(
                  text: "類似影片",
                ),
              ],
              isScrollable: true,
              onTap: (int index) {
                setState(() {
                  selectedIndex = index;
                  _tabController.animateTo(index);
                });
              },
            ),
            IndexedStack(
              children: [
                _buildAllEpisodes(),
                _buildRelatedSeries(),
              ],
              index: selectedIndex,
            ),
//            IndexedStack(
//              children: [
//                Visibility(
//                  child: _buildAllEpisodes(),
//                  visible: selectedIndex == 0,
//                  maintainState: true,
//                ),
//                Visibility(
//                  child: _buildRelatedSeries(),
//                  visible: selectedIndex == 1,
//                  maintainState: true,
//                ),
////                _buildIndexedStackChildren(0),
////                _buildIndexedStackChildren(1),
//              ],
//              index: selectedIndex,
//            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAllEpisodes() {
    //集數或者類似影片
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(4.0)),
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text("第一季"),
                ),
                Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
        for (Episode i in _listEpisodes) _buildEachEpisode(i),
      ],
    );
  }

  Widget _buildRelatedSeries() {
    return GridView.count(
      shrinkWrap: true,
      primary: false,
      padding: const EdgeInsets.symmetric(vertical: 20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 3,
      childAspectRatio: 9 / 12,
      children: List.generate(12, (index) => _buildEachRelatedSeries()),
    );
  }

  _buildEachRelatedSeries() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          image: DecorationImage(
              image: AssetImage("assets/videolist/videolist${Random().nextInt(7)+1}.jpg"),fit: BoxFit.cover)),
    );
  }

  _buildEachEpisode(Episode data) {
    //每一集的樣子
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    data.imageAssetsName,
                    width: 120,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                Icon(
                  Icons.play_circle_outline,
                  size: 40.0,
                )
              ],
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text("${data.name}"), Text("${data.duration}")],
            )),
            Icon(Icons.file_download)
          ],
        ),
        Text(
          data.description,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 12),
        ),
        SizedBox(
          height: 8.0,
        )
      ],
    );
  }

  Widget _buildMainDetail() {
    return Container(
      height: MediaQuery.of(context).size.height * .8,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/videophoto2.jpg",
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AspectRatio(
                        aspectRatio: 9 / 16,
                        child: Image.asset(
                          "assets/videophoto2.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "98%適合您",
                      style: TextStyle(color: Colors.green),
                    ),
                    Text(" 2020 "),
                    Text(" 13+ "),
                    Text(" 1季 ")
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    "第1季上線",
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4.0),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 4.0),
                    width: double.infinity,
                    padding: EdgeInsets.all(4.0),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.play_arrow,
                          size: 30,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          "播放",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        )
                      ],
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4.0),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 4.0),
                    width: double.infinity,
                    padding: EdgeInsets.all(4.0),
                    color: Color(0xff555555),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.file_download,
                          size: 30,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          "下載第1季第1集",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                    "主角本條楓在好友白峰理沙推薦下開始遊玩遊戲「NewWorld Online」，創建了名為「梅普露」的角色。作為遊戲初學者，梅普露選擇了不受歡迎的大盾當武器，並因為怕痛而將所有資源用於增進防禦能力，這種形式讓她學到了各種特殊技能並取得罕見裝備，進而在遊戲中創下傳說。",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "主演：本渡楓，野口瑠璃子，早見沙織",
                      style: TextStyle(color: Colors.grey),
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add),
                          Text('我的片單'),
                          SizedBox(
                            width: 80,
                          )
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.thumb_up),
                          Text("評分"),
                          SizedBox(
                            width: 80.0,
                          )
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.share),
                          Text("分享"),
                          SizedBox(
                            width: 80.0,
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
