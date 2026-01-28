// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  final bool? success;
  final List<History>? data;

  Welcome({
    this.success,
    this.data,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    success: json["success"],
    data: json["data"] == null ? [] : List<History>.from(json["data"]!.map((x) => History.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class History {
  final String? orderId;
  final DateTime? date;
  final List<Item>? items;
  final int? totalPrice;

  History({
    this.orderId,
    this.date,
    this.items,
    this.totalPrice,
  });

  factory History.fromJson(Map<String, dynamic> json) => History(
    orderId: json["orderId"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
    totalPrice: json["totalPrice"],
  );

  Map<String, dynamic> toJson() => {
    "orderId": orderId,
    "date": date?.toIso8601String(),
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
    "totalPrice": totalPrice,
  };
}

class Item {
  final Products? products;
  final int? quantity;
  final int? price;

  Item({
    this.products,
    this.quantity,
    this.price,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    products: json["products"] == null ? null : Products.fromJson(json["products"]),
    quantity: json["quantity"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "products": products?.toJson(),
    "quantity": quantity,
    "price": price,
  };
}

class Products {
  final String? id;
  final String? name;
  final int? price;
  final String? description;
  final String? category;
  final String? rating;
  final String? size;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? imageUrl;

  Products({
    this.id,
    this.name,
    this.price,
    this.description,
    this.category,
    this.rating,
    this.size,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.imageUrl,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
    id: json["_id"],
    name: json["Name"],
    price: json["Price"],
    description: json["Description"],
    category: json["Category"],
    rating: json["Rating"],
    size: json["Size"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    imageUrl: json["imageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "Name": name,
    "Price": price,
    "Description": description,
    "Category": category,
    "Rating": rating,
    "Size": size,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "imageUrl": imageUrl,
  };
}
