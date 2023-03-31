// To parse this JSON data, do
//
//     final stories = storiesFromJson(jsonString);

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'stories.g.dart';

Stories storiesFromJson(String str) => Stories.fromJson(json.decode(str));

String storiesToJson(Stories data) => json.encode(data.toJson());

@JsonSerializable()
class Stories {
  Stories({
    required this.error,
    required this.message,
    required this.listStory,
  });

  bool error;
  String message;
  List<ListStory> listStory;

  factory Stories.fromJson(Map<String, dynamic> json) =>
      _$StoriesFromJson(json);

  Map<String, dynamic> toJson() => _$StoriesToJson(this);
}

@JsonSerializable()
class ListStory {
  ListStory({
    required this.id,
    required this.name,
    required this.description,
    required this.photoUrl,
    required this.createdAt,
    required this.lat,
    required this.lon,
  });

  String id;
  String name;
  String description;
  String photoUrl;
  DateTime createdAt;
  dynamic lat;
  dynamic lon;

  factory ListStory.fromJson(Map<String, dynamic> json) =>
      _$ListStoryFromJson(json);

  Map<String, dynamic> toJson() => _$ListStoryToJson(this);
}

// To parse this JSON data, do
//
//     final addStory = addStoryFromJson(jsonString);

@JsonSerializable()
class UploadResponse {
  final bool error;
  final String message;

  UploadResponse({
    required this.error,
    required this.message,
  });

  factory UploadResponse.fromMap(Map<String, dynamic> map) {
    return UploadResponse(
      error: map['error'] ?? false,
      message: map['message'] ?? '',
    );
  }

  factory UploadResponse.fromJson(String source) =>
    UploadResponse.fromMap(json.decode(source));
}

//// detail story
// To parse this JSON data, do
//
//     final detailstory = detailstoryFromJson(jsonString);

Detailstory detailstoryFromJson(String str) =>
    Detailstory.fromJson(json.decode(str));

String detailstoryToJson(Detailstory data) => json.encode(data.toJson());

@JsonSerializable()
class Detailstory {
  Detailstory({
    required this.error,
    required this.message,
    required this.story,
  });

  bool error;
  String message;
  Story story;

  factory Detailstory.fromJson(Map<String, dynamic> json) =>
      _$DetailstoryFromJson(json);

  Map<String, dynamic> toJson() => _$DetailstoryToJson(this);
}

@JsonSerializable()
class Story {
  Story({
    required this.id,
    required this.name,
    required this.description,
    required this.photoUrl,
    required this.createdAt,
    required this.lat,
    required this.lon,
  });

  String id;
  String name;
  String description;
  String photoUrl;
  DateTime createdAt;
  dynamic lat;
  dynamic lon;

  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);

  Map<String, dynamic> toJson() => _$StoryToJson(this);
}
