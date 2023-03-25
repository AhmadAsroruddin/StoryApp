// To parse this JSON data, do
//
//     final stories = storiesFromJson(jsonString);

import 'dart:convert';

Stories storiesFromJson(String str) => Stories.fromJson(json.decode(str));

String storiesToJson(Stories data) => json.encode(data.toJson());

class Stories {
  Stories({
    required this.error,
    required this.message,
    required this.listStory,
  });

  bool error;
  String message;
  List<ListStory> listStory;

  factory Stories.fromJson(Map<String, dynamic> json) => Stories(
        error: json["error"],
        message: json["message"],
        listStory: List<ListStory>.from(
            json["listStory"].map((x) => ListStory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "listStory": List<dynamic>.from(listStory.map((x) => x.toJson())),
      };
}

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

  factory ListStory.fromJson(Map<String, dynamic> json) => ListStory(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        photoUrl: json["photoUrl"],
        createdAt: DateTime.parse(json["createdAt"]),
        lat: json["lat"],
        lon: json["lon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "photoUrl": photoUrl,
        "createdAt": createdAt.toIso8601String(),
        "lat": lat,
        "lon": lon,
      };
}

// To parse this JSON data, do
//
//     final addStory = addStoryFromJson(jsonString);


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

Detailstory detailstoryFromJson(String str) => Detailstory.fromJson(json.decode(str));

String detailstoryToJson(Detailstory data) => json.encode(data.toJson());

class Detailstory {
    Detailstory({
        required this.error,
        required this.message,
        required this.story,
    });

    bool error;
    String message;
    Story story;

    factory Detailstory.fromJson(Map<String, dynamic> json) => Detailstory(
        error: json["error"],
        message: json["message"],
        story: Story.fromJson(json["story"]),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "story": story.toJson(),
    };
}

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

    factory Story.fromJson(Map<String, dynamic> json) => Story(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        photoUrl: json["photoUrl"],
        createdAt: DateTime.parse(json["createdAt"]),
        lat: json["lat"],
        lon: json["lon"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "photoUrl": photoUrl,
        "createdAt": createdAt.toIso8601String(),
        "lat": lat,
        "lon": lon,
    };
}
