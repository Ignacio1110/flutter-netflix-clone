// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'series_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Series _$SeriesFromJson(Map<String, dynamic> json) {
  return Series(
    (json['episodes'] as List)
        ?.map((e) =>
            e == null ? null : Episode.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    title: json['title'] as String,
    description: json['description'] as String,
    imageURL: json['imageURL'] as String,
    imageAssetsName: json['imageAssetsName'] as String,
    duration: json['duration'] as String,
  );
}

Map<String, dynamic> _$SeriesToJson(Series instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'duration': instance.duration,
      'imageURL': instance.imageURL,
      'imageAssetsName': instance.imageAssetsName,
      'episodes': instance.episodes,
    };
