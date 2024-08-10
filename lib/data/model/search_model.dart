// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'dart:convert';

SearchModel searchModelFromJson(String str) => SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
  String channelId;
  String channelTitle;
  String description;
  Thumbnails thumbnails;
  String title;
  String videoId;

  SearchModel({
    required this.channelId,
    required this.channelTitle,
    required this.description,
    required this.thumbnails,
    required this.title,
    required this.videoId,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
    channelId: json["channelId"],
    channelTitle: json["channelTitle"],
    description: json["description"],
    thumbnails: Thumbnails.fromJson(json["thumbnails"]),
    title: json["title"],
    videoId: json["videoId"],
  );

  Map<String, dynamic> toJson() => {
    "channelId": channelId,
    "channelTitle": channelTitle,
    "description": description,
    "thumbnails": thumbnails.toJson(),
    "title": title,
    "videoId": videoId,
  };
}

class Thumbnails {
  Default thumbnailsDefault;
  Default high;
  Default medium;

  Thumbnails({
    required this.thumbnailsDefault,
    required this.high,
    required this.medium,
  });

  factory Thumbnails.fromJson(Map<String, dynamic> json) => Thumbnails(
    thumbnailsDefault: Default.fromJson(json["default"]),
    high: Default.fromJson(json["high"]),
    medium: Default.fromJson(json["medium"]),
  );

  Map<String, dynamic> toJson() => {
    "default": thumbnailsDefault.toJson(),
    "high": high.toJson(),
    "medium": medium.toJson(),
  };
}

class Default {
  int height;
  String url;
  int width;

  Default({
    required this.height,
    required this.url,
    required this.width,
  });

  factory Default.fromJson(Map<String, dynamic> json) => Default(
    height: json["height"],
    url: json["url"],
    width: json["width"],
  );

  Map<String, dynamic> toJson() => {
    "height": height,
    "url": url,
    "width": width,
  };
}
