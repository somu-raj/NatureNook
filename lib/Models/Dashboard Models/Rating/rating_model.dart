class RatingModel {
  RatingModel({
    required this.error,
    required this.message,
    required this.noOfRating,
    required this.total,
    required this.star1,
    required this.star2,
    required this.star3,
    required this.star4,
    required this.star5,
    required this.totalImages,
    required this.productRating,
    required this.data,
  });

  final bool? error;
  final String? message;
  final int? noOfRating;
  final String? total;
  final String? star1;
  final String? star2;
  final String? star3;
  final String? star4;
  final String? star5;
  final String? totalImages;
  final String? productRating;
  final List<RatingList> data;

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      error: json["error"],
      message: json["message"],
      noOfRating: json["no_of_rating"],
      total: json["total"],
      star1: json["star_1"],
      star2: json["star_2"],
      star3: json["star_3"],
      star4: json["star_4"],
      star5: json["star_5"],
      totalImages: json["total_images"],
      productRating: json["product_rating"],
      data: json["data"] == null
          ? []
          : List<RatingList>.from(
              json["data"]!.map((x) => RatingList.fromJson(x))),
    );
  }
}

class RatingList {
  RatingList({
    required this.id,
    required this.userId,
    required this.productId,
    required this.rating,
    required this.images,
    required this.comment,
    required this.dataAdded,
    required this.userName,
    required this.userProfile,
  });

  final String? id;
  final String? userId;
  final String? productId;
  final String? rating;
  final List<String> images;
  final String? comment;
  final DateTime? dataAdded;
  final String? userName;
  final String? userProfile;

  factory RatingList.fromJson(Map<String, dynamic> json) {
    return RatingList(
      id: json["id"],
      userId: json["user_id"],
      productId: json["product_id"],
      rating: json["rating"],
      images: json["images"] == null
          ? []
          : List<String>.from(json["images"]!.map((x) => x)),
      comment: json["comment"],
      dataAdded: DateTime.tryParse(json["data_added"] ?? ""),
      userName: json["user_name"],
      userProfile: json["user_profile"],
    );
  }
}
