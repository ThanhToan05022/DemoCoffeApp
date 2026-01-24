// To parse this JSON data, do
//
//     final orderHistoryModel = orderHistoryModelFromJson(jsonString);

import 'dart:convert';

OrderHistoryModel orderHistoryModelFromJson(String str) =>
    OrderHistoryModel.fromJson(json.decode(str));

String orderHistoryModelToJson(OrderHistoryModel data) =>
    json.encode(data.toJson());

class OrderHistoryModel {
  final bool? success;
  final List<Datum>? data;

  OrderHistoryModel({this.success, this.data});

  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) =>
      OrderHistoryModel(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  final String? orderId;
  final DateTime? date;
  final List<Item>? items;
  final int? totalPrice;

  Datum({this.orderId, this.date, this.items, this.totalPrice});

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    orderId: json["orderId"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    items: json["items"] == null
        ? []
        : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
    totalPrice: json["totalPrice"],
  );

  Map<String, dynamic> toJson() => {
    "orderId": orderId,
    "date": date?.toIso8601String(),
    "items": items == null
        ? []
        : List<dynamic>.from(items!.map((x) => x.toJson())),
    "totalPrice": totalPrice,
  };
}

class Item {
  final Product? product;
  final Size? size;
  final int? quantity;
  final int? price;
  final int? lineTotal;

  Item({this.product, this.size, this.quantity, this.price, this.lineTotal});

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    product: json["product"] == null ? null : Product.fromJson(json["product"]),
    size: sizeValues.map[json["size"]],
    quantity: json["quantity"],
    price: json["price"],
    lineTotal: json["lineTotal"],
  );

  Map<String, dynamic> toJson() => {
    "product": product?.toJson(),
    "size": sizeValues.reverse[size],
    "quantity": quantity,
    "price": price,
    "lineTotal": lineTotal,
  };
}

class Product {
  final Id? id;
  final Name? name;
  final int? price;
  final Description? description;
  final Category? category;
  final String? rating;
  final Size? size;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? imageUrl;

  Product({
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

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: idValues.map[json["_id"]],
    name: nameValues.map[json["Name"]],
    price: json["Price"],
    description: descriptionValues.map[json["Description"]],
    category: categoryValues.map[json["Category"]],
    rating: json["Rating"],
    size: sizeValues.map[json["Size"]],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    imageUrl: json["imageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "_id": idValues.reverse[id],
    "Name": nameValues.reverse[name],
    "Price": price,
    "Description": descriptionValues.reverse[description],
    "Category": categoryValues.reverse[category],
    "Rating": rating,
    "Size": sizeValues.reverse[size],
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "imageUrl": imageUrl,
  };
}

enum Category {
  THE_692_E566_A430_E10_A99_ADDE68_E,
  THE_692_E56_FB430_E10_A99_ADDE694,
}

final categoryValues = EnumValues({
  "692e566a430e10a99adde68e": Category.THE_692_E566_A430_E10_A99_ADDE68_E,
  "692e56fb430e10a99adde694": Category.THE_692_E56_FB430_E10_A99_ADDE694,
});

enum Description { MEDIUM_ROASTED, WITH_STEAMED_MILK }

final descriptionValues = EnumValues({
  "Medium Roasted": Description.MEDIUM_ROASTED,
  "With Steamed Milk": Description.WITH_STEAMED_MILK,
});

enum Id {
  THE_693_AA4_B4_DBCFEB42_C2_DD4_FBF,
  THE_693_AA7_CADBCFEB42_C2_DD4_FC7,
}

final idValues = EnumValues({
  "693aa4b4dbcfeb42c2dd4fbf": Id.THE_693_AA4_B4_DBCFEB42_C2_DD4_FBF,
  "693aa7cadbcfeb42c2dd4fc7": Id.THE_693_AA7_CADBCFEB42_C2_DD4_FC7,
});

enum Name { CAPPUCCINO, ROBUSTA_BEANS }

final nameValues = EnumValues({
  "Cappuccino": Name.CAPPUCCINO,
  "Robusta Beans": Name.ROBUSTA_BEANS,
});

enum Size { M }

final sizeValues = EnumValues({"M": Size.M});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
