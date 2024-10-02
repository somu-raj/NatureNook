class CategoryModel {
  CategoryModel({
    required this.message,
    required this.error,
    required this.total,
    required this.data,
    required this.popularCategories,
  });

  final String? message;
  final bool? error;
  final int? total;
  final List<CatData> data;
  final List<CatData> popularCategories;

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      message: json["message"],
      error: json["error"],
      total: json["total"],
      data: json["data"] == null
          ? []
          : List<CatData>.from(json["data"]!.map((x) => CatData.fromJson(x))),
      popularCategories: json["popular_categories"] == null
          ? []
          : List<CatData>.from(
              json["popular_categories"]!.map((x) => CatData.fromJson(x))),
    );
  }
}

class CatData {
  CatData({
    required this.id,
    required this.name,
    required this.parentId,
    required this.slug,
    required this.image,
    required this.banner,
    required this.rowOrder,
    required this.status,
    required this.clicks,
    required this.children,
    required this.text,
    required this.state,
    required this.icon,
    required this.level,
    required this.total,
  });

  final String? id;
  final String? name;
  final String? parentId;
  final String? slug;
  final String? image;
  final String? banner;
  final String? rowOrder;
  final String? status;
  final String? clicks;
  final List<dynamic> children;
  final String? text;
  final State? state;
  final String? icon;
  final int? level;
  final int? total;

  factory CatData.fromJson(Map<String, dynamic> json) {
    return CatData(
      id: json["id"],
      name: json["name"],
      parentId: json["parent_id"],
      slug: json["slug"],
      image: json["image"],
      banner: json["banner"],
      rowOrder: json["row_order"],
      status: json["status"],
      clicks: json["clicks"],
      children: json["children"] == null
          ? []
          : List<dynamic>.from(json["children"]!.map((x) => x)),
      text: json["text"],
      state: json["state"] == null ? null : State.fromJson(json["state"]),
      icon: json["icon"],
      level: json["level"],
      total: json["total"],
    );
  }
}

class State {
  State({
    required this.opened,
  });

  final bool? opened;

  factory State.fromJson(Map<String, dynamic> json) {
    return State(
      opened: json["opened"],
    );
  }
}
