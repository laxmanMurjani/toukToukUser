// To parse this JSON data, do
//
//     final discountListModel = discountListModelFromJson(jsonString);

import 'dart:convert';

List<DiscountListModel> discountListModelFromJson(String str) => List<DiscountListModel>.from(json.decode(str).map((x) => DiscountListModel.fromJson(x)));

String discountListModelToJson(List<DiscountListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DiscountListModel {
  int id;
  String name;
  String description;
  String percentage;
  String maxamount;
  String image;
  String status;
  String createdAt;
  String updatedAt;

  DiscountListModel({
    required this.id,
    required this.name,
    required this.description,
    required this.percentage,
    required this.maxamount,
    required this.image,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DiscountListModel.fromJson(Map<String, dynamic> json) => DiscountListModel(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    percentage: json["percentage"],
    maxamount: json["maxamount"],
    image: json["image"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "percentage": percentage,
    "maxamount": maxamount,
    "image": image,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
