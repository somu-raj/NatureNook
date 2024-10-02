class GetFaqsModel {
  GetFaqsModel({
    required this.error,
    required this.message,
    required this.total,
    required this.data,
  });

  final bool? error;
  final String? message;
  final String? total;
  final List<FaqsDataList> data;

  factory GetFaqsModel.fromJson(Map<String, dynamic> json) {
    return GetFaqsModel(
      error: json["error"],
      message: json["message"],
      total: json["total"],
      data: json["data"] == null
          ? []
          : List<FaqsDataList>.from(
              json["data"]!.map((x) => FaqsDataList.fromJson(x))),
    );
  }
}

class FaqsDataList {
  FaqsDataList({
    required this.id,
    required this.question,
    required this.answer,
    required this.status,
  });

  final String? id;
  final String? question;
  final String? answer;
  final String? status;

  factory FaqsDataList.fromJson(Map<String, dynamic> json) {
    return FaqsDataList(
      id: json["id"],
      question: json["question"],
      answer: json["answer"],
      status: json["status"],
    );
  }
}
