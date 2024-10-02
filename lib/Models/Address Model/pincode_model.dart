class PincodeModel {
  PincodeModel({
    required this.error,
    required this.message,
    required this.total,
    required this.data,
  });

  final bool? error;
  final String? message;
  final String? total;
  final List<PincodeData> data;

  factory PincodeModel.fromJson(Map<String, dynamic> json) {
    return PincodeModel(
      error: json["error"],
      message: json["message"],
      total: json["total"],
      data: json["data"] == null
          ? []
          : List<PincodeData>.from(
              json["data"]!.map((x) => PincodeData.fromJson(x))),
    );
  }
}

class PincodeData {
  PincodeData({
    required this.id,
    required this.zipcode,
    required this.dateCreated,
  });

  final String? id;
  final String? zipcode;
  final DateTime? dateCreated;

  factory PincodeData.fromJson(Map<String, dynamic> json) {
    return PincodeData(
      id: json["id"],
      zipcode: json["zipcode"],
      dateCreated: DateTime.tryParse(json["date_created"] ?? ""),
    );
  }
}
