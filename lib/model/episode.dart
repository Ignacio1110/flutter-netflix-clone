import 'package:json_annotation/json_annotation.dart';

part 'episode.g.dart';

@JsonSerializable()
class Episode {
  Episode(
      {this.name,
      this.description,
      this.imageURL,
      this.imageAssetsName,
      this.duration});

  String name;
  String description;
  String duration;
  String imageURL;
  @JsonKey(name: 'image_assets_name')
  String imageAssetsName;

  factory Episode.fromJson(Map<String, dynamic> json) =>
      _$EpisodeFromJson(json);

  Map<String, dynamic> toJson() => _$EpisodeToJson(this);

  factory Episode.fromSqlite(String string) => Episode(
        name: "ss",
      );
}
