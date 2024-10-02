class ProfileModel {
  ProfileModel({
    required this.error,
    required this.message,
    required this.data,
  });

  final bool? error;
  final String? message;
  final ProfileData? data;

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      error: json["error"],
      message: json["message"],
      data: json["data"] == null ? null : ProfileData.fromJson(json["data"]),
    );
  }
}

class ProfileData {
  ProfileData({
    required this.id,
    required this.ipAddress,
    required this.username,
    required this.password,
    required this.email,
    required this.mobile,
    required this.image,
    required this.balance,
    required this.activationSelector,
    required this.activationCode,
    required this.forgottenPasswordSelector,
    required this.forgottenPasswordCode,
    required this.forgottenPasswordTime,
    required this.rememberSelector,
    required this.rememberCode,
    required this.createdOn,
    required this.lastLogin,
    required this.active,
    required this.company,
    required this.address,
    required this.bonusType,
    required this.bonus,
    required this.cashReceived,
    required this.dob,
    required this.countryCode,
    required this.city,
    required this.area,
    required this.street,
    required this.pincode,
    required this.serviceableZipcodes,
    required this.apikey,
    required this.referralCode,
    required this.friendsCode,
    required this.fcmId,
    required this.latitude,
    required this.longitude,
    required this.otp,
    required this.createdAt,
  });

  final String? id;
  final String? ipAddress;
  final String? username;
  final String? password;
  final String? email;
  final String? mobile;
  final dynamic image;
  final String? balance;
  final dynamic activationSelector;
  final dynamic activationCode;
  final dynamic forgottenPasswordSelector;
  final dynamic forgottenPasswordCode;
  final dynamic forgottenPasswordTime;
  final dynamic rememberSelector;
  final dynamic rememberCode;
  final String? createdOn;
  final String? lastLogin;
  final String? active;
  final String? company;
  final dynamic address;
  final String? bonusType;
  final dynamic bonus;
  final String? cashReceived;
  final dynamic dob;
  final String? countryCode;
  final String? city;
  final String? area;
  final dynamic street;
  final dynamic pincode;
  final dynamic serviceableZipcodes;
  final dynamic apikey;
  final String? referralCode;
  final dynamic friendsCode;
  final String? fcmId;
  final dynamic latitude;
  final dynamic longitude;
  final dynamic otp;
  final DateTime? createdAt;

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      id: json["id"],
      ipAddress: json["ip_address"],
      username: json["username"],
      password: json["password"],
      email: json["email"],
      mobile: json["mobile"],
      image: json["image"],
      balance: json["balance"],
      activationSelector: json["activation_selector"],
      activationCode: json["activation_code"],
      forgottenPasswordSelector: json["forgotten_password_selector"],
      forgottenPasswordCode: json["forgotten_password_code"],
      forgottenPasswordTime: json["forgotten_password_time"],
      rememberSelector: json["remember_selector"],
      rememberCode: json["remember_code"],
      createdOn: json["created_on"],
      lastLogin: json["last_login"],
      active: json["active"],
      company: json["company"],
      address: json["address"],
      bonusType: json["bonus_type"],
      bonus: json["bonus"],
      cashReceived: json["cash_received"],
      dob: json["dob"],
      countryCode: json["country_code"],
      city: json["city"],
      area: json["area"],
      street: json["street"],
      pincode: json["pincode"],
      serviceableZipcodes: json["serviceable_zipcodes"],
      apikey: json["apikey"],
      referralCode: json["referral_code"],
      friendsCode: json["friends_code"],
      fcmId: json["fcm_id"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      otp: json["otp"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
    );
  }
}
