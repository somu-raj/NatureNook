// Project imports:
import 'package:nature_nook_app/Models/Dashboard%20Models/Product/products_model.dart';

class SectionModel {
  SectionModel({
    required this.error,
    required this.message,
    required this.minPrice,
    required this.maxPrice,
    required this.data,
  });

  final bool? error;
  final String? message;
  final String? minPrice;
  final String? maxPrice;
  final List<SectionData> data;

  factory SectionModel.fromJson(Map<String, dynamic> json) {
    return SectionModel(
      error: json["error"],
      message: json["message"],
      minPrice: json["min_price"],
      maxPrice: json["max_price"],
      data: json["data"] == null
          ? []
          : List<SectionData>.from(
              json["data"]!.map((x) => SectionData.fromJson(x))),
    );
  }
}

class SectionData {
  SectionData({
    required this.id,
    required this.title,
    required this.shortDescription,
    required this.style,
    required this.productIds,
    required this.rowOrder,
    required this.categories,
    required this.productType,
    required this.dateAdded,
    required this.total,
    required this.filters,
    required this.productDetails,
  });

  final String? id;
  final String? title;
  final String? shortDescription;
  final String? style;
  final String? productIds;
  final String? rowOrder;
  final String? categories;
  final String? productType;
  final DateTime? dateAdded;
  final String? total;
  final List<dynamic> filters;
  final List<Product> productDetails;

  factory SectionData.fromJson(Map<String, dynamic> json) {
    return SectionData(
      id: json["id"],
      title: json["title"],
      shortDescription: json["short_description"],
      style: json["style"],
      productIds: json["product_ids"],
      rowOrder: json["row_order"],
      categories: json["categories"],
      productType: json["product_type"],
      dateAdded: DateTime.tryParse(json["date_added"] ?? ""),
      total: json["total"],
      filters: json["filters"] == null
          ? []
          : List<dynamic>.from(json["filters"]!.map((x) => x)),
      productDetails: json["product_details"] == null
          ? []
          : List<Product>.from(
              json["product_details"]!.map((x) => Product.fromJson(x))),
    );
  }
}
