// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

import 'dart:convert';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  HomeModel({
    required this.blog,
  });

  Blog blog;

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
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
  Data data;
  Pagination pagination;

  factory Blog.fromJson(Map<String, dynamic> json) => Blog(
    success: json["success"],
    msg: json["msg"],
    data: Data.fromJson(json["data"]),
    pagination: Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "msg": msg,
    "data": data.toJson(),
    "pagination": pagination.toJson(),
  };
}

class Data {
  Data({
    required this.categories,
    required this.articles,
  });

  List<Category> categories;
  List<Article> articles;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
    articles: List<Article>.from(json["articles"].map((x) => Article.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
    "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
  };
}

class Article {
  Article({
    required this.id,
    required this.subject,
    required this.viewersCount,
    required this.photo,
    required this.shortDesc,
    required this.category,
  });

  int id;
  String subject;
  int viewersCount;
  String photo;
  String shortDesc;
  Category category;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
    id: json["id"],
    subject: json["subject"],
    viewersCount: json["viewers_count"],
    photo: json["photo"],
    shortDesc: json["short_desc"],
    category: Category.fromJson(json["category"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "subject": subject,
    "viewers_count": viewersCount,
    "photo": photo,
    "short_desc": shortDesc,
    "category": category.toJson(),
  };
}

class Category {
  Category({
    required this.id,
    required this.name,
    required this.photo,
  });

  int id;
  String name;
  String photo;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    photo: json["photo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "photo": photo,
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
