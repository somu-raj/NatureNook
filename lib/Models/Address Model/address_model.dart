class AddressModel {
  AddressModel({
    required this.error,
    required this.message,
    required this.data,
  });

  final bool? error;
  final String? message;
  final List<AddressData> data;

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      error: json["error"],
      message: json["message"],
      data: json["data"] == null
          ? []
          : List<AddressData>.from(
              json["data"]!.map((x) => AddressData.fromJson(x))),
    );
  }
}

class AddressData {
  AddressData({
    required this.id,
    required this.userId,
    required this.name,
    required this.type,
    required this.mobile,
    required this.alternateMobile,
    required this.address,
    required this.landmark,
    required this.areaId,
    required this.cityId,
    required this.pincode,
    required this.countryCode,
    required this.state,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.isDefault,
    required this.area,
    required this.minimumFreeDeliveryOrderAmount,
    required this.deliveryCharges,
    required this.city,
  });

  final String? id;
  final String? userId;
  final String? name;
  final String? type;
  final String? mobile;
  final String? alternateMobile;
  final String? address;
  final String? landmark;
  final String? areaId;
  final String? cityId;
  final String? pincode;
  final String? countryCode;
  final String? state;
  final String? country;
  final String? latitude;
  final String? longitude;
  final String? isDefault;
  final String? area;
  final String? minimumFreeDeliveryOrderAmount;
  final String? deliveryCharges;
  final String? city;

  factory AddressData.fromJson(Map<String, dynamic> json) {
    return AddressData(
      id: json["id"],
      userId: json["user_id"],
      name: json["name"],
      type: json["type"],
      mobile: json["mobile"],
      alternateMobile: json["alternate_mobile"],
      address: json["address"],
      landmark: json["landmark"],
      areaId: json["area_id"],
      cityId: json["city_id"],
      pincode: json["pincode"],
      countryCode: json["country_code"],
      state: json["state"],
      country: json["country"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      isDefault: json["is_default"],
      area: json["area"],
      minimumFreeDeliveryOrderAmount:
          json["minimum_free_delivery_order_amount"],
      deliveryCharges: json["delivery_charges"],
      city: json["city"],
    );
  }
}
