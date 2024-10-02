class GetSettingModel {
  GetSettingModel({
    required this.error,
    required this.message,
    required this.data,
  });

  final bool? error;
  final String? message;
  final SettingData? data;

  factory GetSettingModel.fromJson(Map<String, dynamic> json) {
    return GetSettingModel(
      error: json["error"],
      message: json["message"],
      data: json["data"] == null ? null : SettingData.fromJson(json["data"]),
    );
  }
}

class SettingData {
  SettingData({
    required this.logo,
    required this.privacyPolicy,
    required this.termsConditions,
    required this.fcmServerKey,
    required this.contactUs,
    required this.aboutUs,
    required this.currency,
    required this.timeSlotConfig,
    required this.userData,
    required this.systemSettings,
    required this.shippingPolicy,
    required this.returnPolicy,
    required this.tags,
  });

  final List<String> logo;
  final List<String> privacyPolicy;
  final List<String> termsConditions;
  final List<String> fcmServerKey;
  final List<String> contactUs;
  final List<String> aboutUs;
  final List<String> currency;
  final List<TimeSlotConfig> timeSlotConfig;
  final List<UserDatum> userData;
  final List<SystemSetting> systemSettings;
  final List<String> shippingPolicy;
  final List<String> returnPolicy;
  final List<String> tags;

  factory SettingData.fromJson(Map<String, dynamic> json) {
    return SettingData(
      logo: json["logo"] == null
          ? []
          : List<String>.from(json["logo"]!.map((x) => x)),
      privacyPolicy: json["privacy_policy"] == null
          ? []
          : List<String>.from(json["privacy_policy"]!.map((x) => x)),
      termsConditions: json["terms_conditions"] == null
          ? []
          : List<String>.from(json["terms_conditions"]!.map((x) => x)),
      fcmServerKey: json["fcm_server_key"] == null
          ? []
          : List<String>.from(json["fcm_server_key"]!.map((x) => x)),
      contactUs: json["contact_us"] == null
          ? []
          : List<String>.from(json["contact_us"]!.map((x) => x)),
      aboutUs: json["about_us"] == null
          ? []
          : List<String>.from(json["about_us"]!.map((x) => x)),
      currency: json["currency"] == null
          ? []
          : List<String>.from(json["currency"]!.map((x) => x)),
      timeSlotConfig: json["time_slot_config"] == null
          ? []
          : List<TimeSlotConfig>.from(
              json["time_slot_config"]!.map((x) => TimeSlotConfig.fromJson(x))),
      userData: json["user_data"] == null
          ? []
          : List<UserDatum>.from(
              json["user_data"]!.map((x) => UserDatum.fromJson(x))),
      systemSettings: json["system_settings"] == null
          ? []
          : List<SystemSetting>.from(
              json["system_settings"]!.map((x) => SystemSetting.fromJson(x))),
      shippingPolicy: json["shipping_policy"] == null
          ? []
          : List<String>.from(json["shipping_policy"]!.map((x) => x)),
      returnPolicy: json["return_policy"] == null
          ? []
          : List<String>.from(json["return_policy"]!.map((x) => x)),
      tags: json["tags"] == null
          ? []
          : List<String>.from(json["tags"]!.map((x) => x)),
    );
  }
}

class SystemSetting {
  SystemSetting({
    required this.systemConfigurations,
    required this.systemTimezoneGmt,
    required this.systemConfigurationsId,
    required this.appName,
    required this.supportNumber,
    required this.supportEmail,
    required this.currentVersion,
    required this.currentVersionIos,
    required this.isVersionSystemOn,
    required this.areaWiseDeliveryCharge,
    required this.currency,
    required this.deliveryCharge,
    required this.minAmount,
    required this.systemTimezone,
    required this.isReferEarnOn,
    required this.minReferEarnOrderAmount,
    required this.referEarnBonus,
    required this.referEarnMethod,
    required this.maxReferEarnAmount,
    required this.referEarnBonusTimes,
    required this.welcomeWalletBalanceOn,
    required this.walletBalanceAmount,
    required this.minimumCartAmt,
    required this.lowStockLimit,
    required this.maxItemsCart,
    required this.deliveryBoyBonusPercentage,
    required this.maxProductReturnDays,
    required this.isDeliveryBoyOtpSettingOn,
    required this.isSingleSellerOrder,
    required this.isCustomerAppUnderMaintenance,
    required this.inspectElement,
    required this.isSellerAppUnderMaintenance,
    required this.isDeliveryBoyAppUnderMaintenance,
    required this.messageForCustomerApp,
    required this.messageForSellerApp,
    required this.messageForDeliveryBoyApp,
    required this.cartBtnOnList,
    required this.expandProductImages,
    required this.taxName,
    required this.taxNumber,
    required this.companyName,
    required this.companyUrl,
    required this.supportedLocals,
    required this.decimalPoint,
  });

  final String? systemConfigurations;
  final String? systemTimezoneGmt;
  final String? systemConfigurationsId;
  final String? appName;
  final String? supportNumber;
  final String? supportEmail;
  final String? currentVersion;
  final String? currentVersionIos;
  final String? isVersionSystemOn;
  final String? areaWiseDeliveryCharge;
  final String? currency;
  final String? deliveryCharge;
  final String? minAmount;
  final String? systemTimezone;
  final String? isReferEarnOn;
  final String? minReferEarnOrderAmount;
  final String? referEarnBonus;
  final String? referEarnMethod;
  final String? maxReferEarnAmount;
  final String? referEarnBonusTimes;
  final String? welcomeWalletBalanceOn;
  final String? walletBalanceAmount;
  final String? minimumCartAmt;
  final String? lowStockLimit;
  final String? maxItemsCart;
  final String? deliveryBoyBonusPercentage;
  final String? maxProductReturnDays;
  final String? isDeliveryBoyOtpSettingOn;
  final String? isSingleSellerOrder;
  final String? isCustomerAppUnderMaintenance;
  final String? inspectElement;
  final String? isSellerAppUnderMaintenance;
  final String? isDeliveryBoyAppUnderMaintenance;
  final String? messageForCustomerApp;
  final String? messageForSellerApp;
  final String? messageForDeliveryBoyApp;
  final String? cartBtnOnList;
  final String? expandProductImages;
  final String? taxName;
  final String? taxNumber;
  final String? companyName;
  final String? companyUrl;
  final String? supportedLocals;
  final String? decimalPoint;

  factory SystemSetting.fromJson(Map<String, dynamic> json) {
    return SystemSetting(
      systemConfigurations: json["system_configurations"],
      systemTimezoneGmt: json["system_timezone_gmt"],
      systemConfigurationsId: json["system_configurations_id"],
      appName: json["app_name"],
      supportNumber: json["support_number"],
      supportEmail: json["support_email"],
      currentVersion: json["current_version"],
      currentVersionIos: json["current_version_ios"],
      isVersionSystemOn: json["is_version_system_on"],
      areaWiseDeliveryCharge: json["area_wise_delivery_charge"],
      currency: json["currency"],
      deliveryCharge: json["delivery_charge"],
      minAmount: json["min_amount"],
      systemTimezone: json["system_timezone"],
      isReferEarnOn: json["is_refer_earn_on"],
      minReferEarnOrderAmount: json["min_refer_earn_order_amount"],
      referEarnBonus: json["refer_earn_bonus"],
      referEarnMethod: json["refer_earn_method"],
      maxReferEarnAmount: json["max_refer_earn_amount"],
      referEarnBonusTimes: json["refer_earn_bonus_times"],
      welcomeWalletBalanceOn: json["welcome_wallet_balance_on"],
      walletBalanceAmount: json["wallet_balance_amount"],
      minimumCartAmt: json["minimum_cart_amt"],
      lowStockLimit: json["low_stock_limit"],
      maxItemsCart: json["max_items_cart"],
      deliveryBoyBonusPercentage: json["delivery_boy_bonus_percentage"],
      maxProductReturnDays: json["max_product_return_days"],
      isDeliveryBoyOtpSettingOn: json["is_delivery_boy_otp_setting_on"],
      isSingleSellerOrder: json["is_single_seller_order"],
      isCustomerAppUnderMaintenance: json["is_customer_app_under_maintenance"],
      inspectElement: json["inspect_element"],
      isSellerAppUnderMaintenance: json["is_seller_app_under_maintenance"],
      isDeliveryBoyAppUnderMaintenance:
          json["is_delivery_boy_app_under_maintenance"],
      messageForCustomerApp: json["message_for_customer_app"],
      messageForSellerApp: json["message_for_seller_app"],
      messageForDeliveryBoyApp: json["message_for_delivery_boy_app"],
      cartBtnOnList: json["cart_btn_on_list"],
      expandProductImages: json["expand_product_images"],
      taxName: json["tax_name"],
      taxNumber: json["tax_number"],
      companyName: json["company_name"],
      companyUrl: json["company_url"],
      supportedLocals: json["supported_locals"],
      decimalPoint: json["decimal_point"],
    );
  }
}

class TimeSlotConfig {
  TimeSlotConfig({
    required this.timeSlotConfig,
    required this.isTimeSlotsEnabled,
    required this.deliveryStartsFrom,
    required this.allowedDays,
  });

  final String? timeSlotConfig;
  final String? isTimeSlotsEnabled;
  final String? deliveryStartsFrom;
  final String? allowedDays;

  factory TimeSlotConfig.fromJson(Map<String, dynamic> json) {
    return TimeSlotConfig(
      timeSlotConfig: json["time_slot_config"],
      isTimeSlotsEnabled: json["is_time_slots_enabled"],
      deliveryStartsFrom: json["delivery_starts_from"],
      allowedDays: json["allowed_days"],
    );
  }
}

class UserDatum {
  UserDatum({
    required this.id,
    required this.username,
    required this.email,
    required this.mobile,
    required this.balance,
    required this.dob,
    required this.referralCode,
    required this.friendsCode,
    required this.cities,
    required this.area,
    required this.street,
    required this.pincode,
    required this.cartTotalItems,
  });

  final String? id;
  final String? username;
  final dynamic email;
  final String? mobile;
  final String? balance;
  final dynamic dob;
  final dynamic referralCode;
  final dynamic friendsCode;
  final String? cities;
  final String? area;
  final String? street;
  final String? pincode;
  final String? cartTotalItems;

  factory UserDatum.fromJson(Map<String, dynamic> json) {
    return UserDatum(
      id: json["id"],
      username: json["username"],
      email: json["email"],
      mobile: json["mobile"],
      balance: json["balance"],
      dob: json["dob"],
      referralCode: json["referral_code"],
      friendsCode: json["friends_code"],
      cities: json["cities"],
      area: json["area"],
      street: json["street"],
      pincode: json["pincode"],
      cartTotalItems: json["cart_total_items"],
    );
  }
}
