import 'package:flutter_neflix_cover/model/episode.dart';
import 'package:json_annotation/json_annotation.dart';

part 'series_model.g.dart';

@JsonSerializable()
class Series{
  Series(this.episodes,{this.title, this.description, this.imageURL, this.imageAssetsName,this.duration});

  String title;
  String description;
  String duration;
  String imageURL;
  String imageAssetsName;

  List<Episode> episodes;

}

