// To parse this JSON data, do
//
//     final products = productsFromJson(jsonString);

import 'dart:convert';

Products productsFromJson(String str) => Products.fromJson(json.decode(str));

String productsToJson(Products data) => json.encode(data.toJson());

class Products {
  final bool? success;
  final List<Datum>? Data;

  Products({this.success, this.Data});

  factory Products.fromJson(Map<String, dynamic> json) => Products(
    success: json["success"],
    Data: json["Data"] == null
        ? []
        : List<Datum>.from(json["Data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "Data": Data == null
        ? []
        : List<dynamic>.from(Data!.map((x) => x.toJson())),
  };
}

class Datum {
  final String? id;
  final String? name;
  final int? price;
  final String? description;
  final String? imageUrl;
  final String? rating;
  final String? size;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final Category? category;

  Datum({
    this.id,
    this.name,
    this.price,
    this.description,
    this.imageUrl,
    this.size,
    this.createdAt,
    this.rating,
    this.updatedAt,
    this.v,
    this.category,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    name: json["Name"],
    price: json["Price"],
    description: json["Description"],
    imageUrl: json["imageUrl"],
    rating: json["Rating"],
    size: json["Size"],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    category: json["Category"] is Map<String, dynamic>
        ? Category.fromJson(json["Category"])
        : null,
  );
  Map<String, dynamic> toJson() => {
    "_id": id,
    "Name": name,
    "Price": price,
    "Description": description,
    "imageUrl": imageUrl,
    "Rating": rating,
    "Size":size,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "Category": category?.toJson(),
  };
}

class Category {
  final String? id;
  final String? name;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  Category({this.id, this.name, this.createdAt, this.updatedAt, this.v});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["_id"],
    name: json["Name"],
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
    "Name": name,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
