class PostOfficeModel {
  PostOfficeModel({
    required this.message,
    required this.status,
    required this.postOffices,
  });

  final String? message;
  final String? status;
  final List<PostOffice> postOffices;

  factory PostOfficeModel.fromJson(Map<String, dynamic> json) {
    return PostOfficeModel(
      message: json["Message"],
      status: json["Status"],
      postOffices: json["PostOffice"] == null
          ? []
          : List<PostOffice>.from(
              json["PostOffice"]!.map((x) => PostOffice.fromJson(x))),
    );
  }
}

class PostOffice {
  PostOffice({
    required this.name,
    required this.description,
    required this.branchType,
    required this.deliveryStatus,
    required this.taluk,
    required this.circle,
    required this.district,
    required this.division,
    required this.region,
    required this.state,
    required this.country,
  });

  final String? name;
  final String? description;
  final String? branchType;
  final String? deliveryStatus;
  final String? taluk;
  final String? circle;
  final String? district;
  final String? division;
  final String? region;
  final String? state;
  final String? country;

  factory PostOffice.fromJson(Map<String, dynamic> json) {
    return PostOffice(
      name: json["Name"],
      description: json["Description"],
      branchType: json["BranchType"],
      deliveryStatus: json["DeliveryStatus"],
      taluk: json["Taluk"],
      circle: json["Circle"],
      district: json["District"],
      division: json["Division"],
      region: json["Region"],
      state: json["State"],
      country: json["Country"],
    );
  }
}
