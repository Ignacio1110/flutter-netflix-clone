// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Episode _$EpisodeFromJson(Map<String, dynamic> json) {
  return Episode(
    name: json['name'] as String,
    description: json['description'] as String,
    imageURL: json['imageURL'] as String,
    imageAssetsName: json['image_assets_name'] as String,
    duration: json['duration'] as String,
  );
}

Map<String, dynamic> _$EpisodeToJson(Episode instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'duration': instance.duration,
      'imageURL': instance.imageURL,
      'image_assets_name': instance.imageAssetsName,
    };
