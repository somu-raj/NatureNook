class NotificationModel {
  NotificationModel({
    required this.error,
    required this.message,
    required this.total,
    required this.data,
  });
  final bool? error;
  final String? message;
  final String? total;
  final List<NotificationData> data;
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      error: json["error"],
      message: json["message"],
      total: json["total"],
      data: json["data"] == null
          ? []
          : List<NotificationData>.from(
              json["data"]!.map((x) => NotificationData.fromJson(x))),
    );
  }
}

class NotificationData {
  NotificationData({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.typeId,
    required this.sendTo,
    required this.usersId,
    required this.image,
    required this.dateSent,
  });
  final String? id;
  final String? title;
  final String? message;
  final String? type;
  final String? typeId;
  final String? sendTo;
  final String? usersId;
  final String? image;
  final DateTime? dateSent;
  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      id: json["id"],
      title: json["title"],
      message: json["message"],
      type: json["type"],
      typeId: json["type_id"],
      sendTo: json["send_to"],
      usersId: json["users_id"],
      image: json["image"],
      dateSent: DateTime.tryParse(json["date_sent"] ?? ""),
    );
  }
}
