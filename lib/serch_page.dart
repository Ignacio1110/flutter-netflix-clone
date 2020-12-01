import 'package:flutter/material.dart';
import 'package:flutter_neflix_cover/model/episode.dart';
import 'package:flutter_neflix_cover/model/series_model.dart';
import 'package:transparent_image/transparent_image.dart';

class SearchingPage extends StatefulWidget {
  @override
  _SearchingPageState createState() => _SearchingPageState();
}

class _SearchingPageState extends State<SearchingPage> {
  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            color: Color(0xff333333),
            child: ListTile(
              leading: Icon(
                Icons.search,
                color: Colors.grey,
              ),
              title: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: '搜索節目、電影、類型等。',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  border: InputBorder.none,
                ),
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.mic,
                  color: Colors.grey,
                ),
                onPressed: () {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "熱門搜尋",
              style: TextStyle(fontSize: 22.0),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Series>>(
                stream: _getSeries(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4.0),
                                  child: Container(
                                      color: Colors.white.withOpacity(0.3),
                                      width: 160,
                                      height: 80,
                                      child: _buildNetworkImage(
                                          snapshot.data[index])),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "${snapshot.data[index].title}",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.white.withOpacity(0.8)),
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.play_arrow,
                                size: 32,
                              )
                            ],
                          );
                        });
                  }
                  return Center(
                    child: SizedBox(
                      width: 50.0,
                      height: 50.0,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.red),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    ));
  }

  _buildImage(int index) {
    return Image.asset("assets/videolist/videolist${index + 1}.jpg",
        fit: BoxFit.cover);
  }

  Stream<List<Series>> _getSeries() {
    print('_getSeries');
    return Stream.fromFuture(Future.delayed(Duration(seconds: 3), () {
      return _listSeries;
    }));
  }

  _buildNetworkImage(Series series) {
//    return Image.network(imageURL);
    return FadeInImage.memoryNetwork(
      placeholder: kTransparentImage,
      image: series.imageURL,
      fit: BoxFit.cover,
      imageErrorBuilder: (context, error, s) {
        print('something: $error}');
        return Text('error $s');
      },
      fadeInDuration: Duration(milliseconds: 300),
    );
  }

  List<Series> _listSeries = [
    Series([Episode()],
        title: "拉契特：黯衣天使",
        imageURL:
            "https://obs.line-scdn.net/0hTaFTyJ2mC057LSILS990GUF7CCFIQRhNHxtaTThDVXoBHk8aEhtAIFh4BS4ETUwQEktAKF8pEH8EGRgfQkNA/w644"),
    Series([Episode()],
        title: "陽光普照",
        imageURL:
            "https://doqvf81n9htmm.cloudfront.net/data/changchi_177/7-16/730/1005/%EF%BC%91%EF%BC%92/87/facebook-Linked_Image___72954903_3186658091349282_6845006129731207168_n.jpg"),
    Series([Episode()],
        title: "神棄之地",
        imageURL:
            "https://www.dramaqueen.com.tw/images/news/2020080410365397773076abd275c809e0995179aefec877cf.jpg"),
    Series([Episode()],
        title: "誰先愛上他的",
        imageURL:
            "https://miro.medium.com/max/1200/1*r-DPHU8cySquWm3exXOIOQ.jpeg"),
    Series([Episode()],
        title: "智能社會：進退兩難",
        imageURL:
            'https://kevinmoleaf.weebly.com/uploads/2/6/2/4/26248190/the-socdilemmadilemmaial-dilemma-1200_orig.jpg'),
    Series([Episode()],
        title: "拉契特：黯衣天使",
        imageURL:
            "https://obs.line-scdn.net/0hTaFTyJ2mC057LSILS990GUF7CCFIQRhNHxtaTThDVXoBHk8aEhtAIFh4BS4ETUwQEktAKF8pEH8EGRgfQkNA/w644"),
    Series([Episode()],
        title: "陽光普照",
        imageURL:
            "https://doqvf81n9htmm.cloudfront.net/data/changchi_177/7-16/730/1005/%EF%BC%91%EF%BC%92/87/facebook-Linked_Image___72954903_3186658091349282_6845006129731207168_n.jpg"),
    Series([Episode()],
        title: "神棄之地",
        imageURL:
            "https://www.dramaqueen.com.tw/images/news/2020080410365397773076abd275c809e0995179aefec877cf.jpg"),
    Series([Episode()],
        title: "誰先愛上他的",
        imageURL:
            "https://miro.medium.com/max/1200/1*r-DPHU8cySquWm3exXOIOQ.jpeg"),
    Series([Episode()],
        title: "智能社會：進退兩難",
        imageURL:
            'https://kevinmoleaf.weebly.com/uploads/2/6/2/4/26248190/the-socdilemmadilemmaial-dilemma-1200_orig.jpg')
  ];
//  String imageURL =
//      ;
}
