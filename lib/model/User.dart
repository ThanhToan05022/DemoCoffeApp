// To parse this JSON data, do
//
//     final userProfileModel = userProfileModelFromJson(jsonString);

import 'dart:convert';

import 'package:projectflutter2/model/Order.dart';

UserProfileModel userProfileModelFromJson(String str) =>
    UserProfileModel.fromJson(json.decode(str));

String userProfileModelToJson(UserProfileModel data) =>
    json.encode(data.toJson());

class UserProfileModel {
  final bool? success;
  final Profile? profile;
  final String? token;

  UserProfileModel({this.success, this.profile, this.token});

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        success: json["success"],
        profile: json["profile"] == null
            ? null
            : Profile.fromJson(json["profile"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "profile": profile?.toJson(),
    "token": token,
  };

  @override
  String toString() =>
      'UserProfileModel(success: $success, profile: $profile,token: $token)';
}

class Profile {
  final String? id;
  final String? name;
  final String? email;
  final String? password;
  final String? avatar;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final List<Order>? cart;

  Profile({
    this.id,
    this.name,
    this.email,
    this.password,
    this.avatar,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.cart,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    password: json["password"],
    avatar: json["avatar"],
    cart: json["cart"] == null ? [] : List<Order>.from(json["cart"]),
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "password": password,
    "avatar": avatar,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "cart": cart?.map((x) => x.toJson()).toList() ?? [],
  };

  @override
  String toString() =>
      'Profile(id: $id, name: $name, email: $email, avatar: $avatar, createdAt: $createdAt, updatedAt: $updatedAt)';
}
