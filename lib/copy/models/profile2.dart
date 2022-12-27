// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileModel({
    required this.blog,
  });

  Blog blog;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
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
    required this.userId,
    required this.username,
    required this.email,
    required this.userGroupId,
    required this.uqid,
  });

  int userId;
  String username;
  String email;
  int userGroupId;
  String uqid;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userId: json["user_id"],
    username: json["username"],
    email: json["email"],
    userGroupId: json["user_group_id"],
    uqid: json["uqid"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "username": username,
    "email": email,
    "user_group_id": userGroupId,
    "uqid": uqid,
  };
}
