// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

RegisterModel registerModelFromJson(String str) => RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  RegisterModel({
    required this.blog,
  });

  Blog blog;

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
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
    required this.username,
    required this.email,
    required this.userGroupId,
    required this.id,
    required this.token,
  });

  String username;
  String email;
  int userGroupId;
  int id;
  String token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    username: json["username"],
    email: json["email"],
    userGroupId: json["user_group_id"],
    id: json["id"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "email": email,
    "user_group_id": userGroupId,
    "id": id,
    "token": token,
  };
}
