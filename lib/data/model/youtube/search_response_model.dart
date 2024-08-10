import 'dart:convert';
import 'package:oktvv2/presentation/utility/constants.dart';

SearchResponseModel searchResponseModelFromJson(String str) => SearchResponseModel.fromJson(json.decode(str));

String searchResponseModelToJson(SearchResponseModel data) => json.encode(data.toJson());

class SearchResponseModel {
  String kind;
  String etag;
  String nextPageToken;
  String regionCode;
  PageInfo pageInfo;
  List<Item> items;

  SearchResponseModel({
    required this.kind,
    required this.etag,
    required this.nextPageToken,
    required this.regionCode,
    required this.pageInfo,
    required this.items,
  });

  factory SearchResponseModel.fromJson(Map<String, dynamic> json) => SearchResponseModel(
    kind: json[AppStrings.kind],
    etag: json[AppStrings.etag],
    nextPageToken: json[AppStrings.nextPageToken],
    regionCode: json[AppStrings.regionCode],
    pageInfo: PageInfo.fromJson(json[AppStrings.pageInfo]),
    items: List<Item>.from(json[AppStrings.items].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    AppStrings.kind: kind,
    AppStrings.etag: etag,
    AppStrings.nextPageToken: nextPageToken,
    AppStrings.regionCode: regionCode,
    AppStrings.pageInfo: pageInfo.toJson(),
    AppStrings.items: List<Item>.from(items.map((x) => x.toJson())),
  };
}

class Item {
  String kind;
  String etag;
  Id id;
  Snippet snippet;

  Item({
    required this.kind,
    required this.etag,
    required this.id,
    required this.snippet,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    kind: json[AppStrings.kind],
    etag: json[AppStrings.etag],
    id: Id.fromJson(json[AppStrings.id]),
    snippet: Snippet.fromJson(json[AppStrings.snippet]),
  );

  Map<String, dynamic> toJson() => {
    AppStrings.kind: kind,
    AppStrings.etag: etag,
    AppStrings.id: id.toJson(),
    AppStrings.snippet: snippet.toJson(),
  };
}

class Id {
  String kind;
  String videoId;

  Id({
    required this.kind,
    required this.videoId,
  });

  factory Id.fromJson(Map<String, dynamic> json) => Id(
    kind: json[AppStrings.kind],
    videoId: json[AppStrings.videoId],
  );

  Map<String, dynamic> toJson() => {
    AppStrings.kind: kind,
    AppStrings.videoId: videoId,
  };
}

class Snippet {
  DateTime publishedAt;
  String channelId;
  String title;
  String description;
  Thumbnails thumbnails;
  String channelTitle;
  String liveBroadcastContent;
  DateTime publishTime;

  Snippet({
    required this.publishedAt,
    required this.channelId,
    required this.title,
    required this.description,
    required this.thumbnails,
    required this.channelTitle,
    required this.liveBroadcastContent,
    required this.publishTime,
  });

  factory Snippet.fromJson(Map<String, dynamic> json) => Snippet(
    publishedAt: DateTime.parse(json[AppStrings.publishedAt]),
    channelId: json[AppStrings.channelId],
    title: json[AppStrings.title],
    description: json[AppStrings.description],
    thumbnails: Thumbnails.fromJson(json[AppStrings.thumbnails]),
    channelTitle: json[AppStrings.channelTitle],
    liveBroadcastContent: json[AppStrings.liveBroadcastContent],
    publishTime: DateTime.parse(json[AppStrings.publishTime]),
  );

  Map<String, dynamic> toJson() => {
    AppStrings.publishedAt: publishedAt.toIso8601String(),
    AppStrings.channelId: channelId,
    AppStrings.title: title,
    AppStrings.description: description,
    AppStrings.thumbnails: thumbnails.toJson(),
    AppStrings.channelTitle: channelTitle,
    AppStrings.liveBroadcastContent: liveBroadcastContent,
    AppStrings.publishTime: publishTime.toIso8601String(),
  };
}

class Thumbnails {
  Default thumbnailsDefault;
  Default medium;
  Default high;

  Thumbnails({
    required this.thumbnailsDefault,
    required this.medium,
    required this.high,
  });

  factory Thumbnails.fromJson(Map<String, dynamic> json) => Thumbnails(
    thumbnailsDefault: Default.fromJson(json[AppStrings.strDefault]),
    medium: Default.fromJson(json[AppStrings.medium]),
    high: Default.fromJson(json[AppStrings.high]),
  );

  Map<String, dynamic> toJson() => {
    AppStrings.strDefault: thumbnailsDefault.toJson(),
    AppStrings.medium: medium.toJson(),
    AppStrings.high: high.toJson(),
  };
}

class Default {
  String url;
  int width;
  int height;

  Default({
    required this.url,
    required this.width,
    required this.height,
  });

  factory Default.fromJson(Map<String, dynamic> json) => Default(
    url: json[AppStrings.url],
    width: json[AppStrings.width],
    height: json[AppStrings.height],
  );

  Map<String, dynamic> toJson() => {
    AppStrings.url: url,
    AppStrings.width: width,
    AppStrings.height: height,
  };
}

class PageInfo {
  int totalResults;
  int resultsPerPage;

  PageInfo({
    required this.totalResults,
    required this.resultsPerPage,
  });

  factory PageInfo.fromJson(Map<String, dynamic> json) => PageInfo(
    totalResults: json[AppStrings.totalResults],
    resultsPerPage: json[AppStrings.resultsPerPage],
  );

  Map<String, dynamic> toJson() => {
    AppStrings.totalResults: totalResults,
    AppStrings.resultsPerPage: resultsPerPage,
  };
}
