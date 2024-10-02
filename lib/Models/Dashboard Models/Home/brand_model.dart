class BrandModel {
  BrandModel({
    required this.error,
    required this.message,
    required this.total,
    required this.data,
  });

  final bool? error;
  final String? message;
  final String? total;
  final List<BrandData> data;

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      error: json["error"],
      message: json["message"],
      total: json["total"],
      data: json["data"] == null
          ? []
          : List<BrandData>.from(
              json["data"]!.map((x) => BrandData.fromJson(x))),
    );
  }
}

class BrandData {
  BrandData({
    required this.sellerId,
    required this.sellerName,
    required this.email,
    required this.mobile,
    required this.slug,
    required this.sellerRating,
    required this.noOfRatings,
    required this.storeName,
    required this.storeUrl,
    required this.storeDescription,
    required this.sellerProfile,
    required this.balance,
    required this.totalProducts,
  });

  final String? sellerId;
  final String? sellerName;
  final String? email;
  final String? mobile;
  final String? slug;
  final String? sellerRating;
  final String? noOfRatings;
  final String? storeName;
  final String? storeUrl;
  final String? storeDescription;
  final String? sellerProfile;
  final String? balance;
  final String? totalProducts;

  factory BrandData.fromJson(Map<String, dynamic> json) {
    return BrandData(
      sellerId: json["seller_id"],
      sellerName: json["seller_name"],
      email: json["email"],
      mobile: json["mobile"],
      slug: json["slug"],
      sellerRating: json["seller_rating"],
      noOfRatings: json["no_of_ratings"],
      storeName: json["store_name"],
      storeUrl: json["store_url"],
      storeDescription: json["store_description"],
      sellerProfile: json["seller_profile"],
      balance: json["balance"],
      totalProducts: json["total_products"],
    );
  }
}
