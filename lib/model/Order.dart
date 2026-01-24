// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
  final bool? success;
  final String? message;
  final Cart? cart;

  Order({
    this.success,
    this.message,
    this.cart,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    success: json["success"],
    message: json["message"],
    cart: json["cart"] == null ? null : Cart.fromJson(json["cart"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "cart": cart?.toJson(),
  };
}

class Cart {
  final String? id;
  final String? user;
   int? totalPrice;
  final List<Item>? items;
  final DateTime? orderDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  Cart({
    this.id,
    this.user,
    this.totalPrice,
    this.items,
    this.orderDate,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
    id: json["_id"],
    user: json["user"],
    totalPrice: json["totalPrice"],
    items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
    orderDate: json["orderDate"] == null ? null : DateTime.parse(json["orderDate"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user": user,
    "totalPrice": totalPrice,
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
    "orderDate": orderDate?.toIso8601String(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Item {
  final String? id;
  final ProductsClass? products;
   int? quantity;
  final String? size;
  final int? price;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  Item({
    this.id,
    this.products,
    this.quantity,
    this.size,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["_id"],
    products: json["products"] == null ? null : ProductsClass.fromJson(json["products"]),
    quantity: json["quantity"],
    size: json["Size"],
    price: json["price"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "products": products?.toJson(),
    "quantity": quantity,
    "Size": size,
    "price": price,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class ProductsClass {
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

  ProductsClass({
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

  factory ProductsClass.fromJson(Map<String, dynamic> json) => ProductsClass(
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
