// To parse this JSON data, do
//
//     final videosModel = videosModelFromJson(jsonString);

import 'dart:convert';

VideosModel videosModelFromJson(String str) => VideosModel.fromJson(json.decode(str));

String videosModelToJson(VideosModel data) => json.encode(data.toJson());

class VideosModel {
  VideosModel({
    required this.blog,
  });

  Blog blog;

  factory VideosModel.fromJson(Map<String, dynamic> json) => VideosModel(
    blog: Blog.fromJson(json["blog"]),
  );

  Map<String, dynamic> toJson() => {
    "blog": blog.toJson(),
  };
}

class Blog {
  Blog({
    required this.success,
    required this.msg,
    required this.data,
    required this.pagination,
  });

  bool success;
  String msg;
  List<Datum> data;
  Pagination pagination;

  factory Blog.fromJson(Map<String, dynamic> json) => Blog(
    success: json["success"],
    msg: json["msg"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    pagination: Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "pagination": pagination.toJson(),
  };
}

class Datum {
  Datum({
    required this.id,
    required this.subject,
    required this.viewersCount,
    required this.viedoLink,
    required this.shortDesc,
    required this.category,
  });

  int id;
  String subject;
  int viewersCount;
  String viedoLink;
  String shortDesc;
  Categor category;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    subject: json["subject"],
    viewersCount: json["viewers_count"],
    viedoLink: json["viedo_link"],
    shortDesc: json["short_desc"],
    category: Categor.fromJson(json["category"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "subject": subject,
    "viewers_count": viewersCount,
    "viedo_link": viedoLink,
    "short_desc": shortDesc,
    "category": category.toJson(),
  };
}

class Categor {
  Categor({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Categor.fromJson(Map<String, dynamic> json) => Categor(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class Pagination {
  Pagination({
    required this.count,
    required this.end,
  });

  int count;
  int end;


  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    count: json["count"],
    end: json["end"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "end": end,
  };
}

