// To parse this JSON data, do
//
//     final productDetailModelClass = productDetailModelClassFromJson(jsonString);

import 'dart:convert';

ProductDetailModelClass productDetailModelClassFromJson(String str) => ProductDetailModelClass.fromJson(json.decode(str));

String productDetailModelClassToJson(ProductDetailModelClass data) => json.encode(data.toJson());

class ProductDetailModelClass {
  int? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;
  Rating? rating;

  ProductDetailModelClass({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
  });

  factory ProductDetailModelClass.fromJson(Map<String, dynamic> json) => ProductDetailModelClass(
    id: json["id"] ?? 0,
    title: json["title"] ?? "",
    price: json["price"]?.toDouble() ?? 0.0,
    description: json["description"] ?? "",
    category: json["category"] ?? "",
    image: json["image"] ?? "",
    rating: json.containsKey("rating") ? json["rating"] != null ? Rating.fromJson(json["rating"]) :null :null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    "description": description,
    "category": category,
    "image": image,
    "rating": rating!.toJson(),
  };
}

class Rating {
  double? rate;
  int? count;

  Rating({
    this.rate,
    this.count,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
    rate: json["rate"]?.toDouble() ?? 0.0,
    count: json["count"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "rate": rate,
    "count": count,
  };
}
