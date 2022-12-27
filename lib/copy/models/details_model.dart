// To parse this JSON data, do
//
//     final detailsModel = detailsModelFromJson(jsonString);

import 'dart:convert';

DetailsModel detailsModelFromJson(String str) => DetailsModel.fromJson(json.decode(str));

String detailsModelToJson(DetailsModel data) => json.encode(data.toJson());

class DetailsModel {
  DetailsModel({
    required this.blog,
  });

  Blog blog;

  factory DetailsModel.fromJson(Map<String, dynamic> json) => DetailsModel(
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
  });

  bool success;
  String msg;
  Data data;

  factory Blog.fromJson(Map<String, dynamic> json) => Blog(
    success: json["success"],
    msg: json["msg"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "msg": msg,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.details,
    required this.related,
  });

  Details details;
  List<Details> related;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    details: Details.fromJson(json["details"]),
    related: List<Details>.from(json["related"].map((x) => Details.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "details": details.toJson(),
    "related": List<dynamic>.from(related.map((x) => x.toJson())),
  };
}

class Details {
  Details({
    required this.id,
    required this.subject,
    required this.viewersCount,
    required this.content,
    required this.photo,
    required this.shortDesc,
    required this.category,
  });

  int id;
  String subject;
  int viewersCount;
  String content;
  String shortDesc;
  String photo;
  Category category;

  factory Details.fromJson(Map<String, dynamic> json) => Details(
    id: json["id"],
    subject: json["subject"],
    viewersCount: json["viewers_count"],
    content: json["content"],
    photo: json["photo"],
    shortDesc: json["short_desc"],
    category: Category.fromJson(json["category"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "subject": subject,
    "viewers_count": viewersCount,
    "content": content,
    "photo": photo,
    "short_desc": shortDesc,
    "category": category.toJson(),
  };
}

class Category {
  Category({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
