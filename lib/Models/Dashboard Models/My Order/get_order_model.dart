class OrderModel {
  OrderModel({
    required this.error,
    required this.message,
    required this.total,
    required this.data,
  });

  final bool? error;
  final String? message;
  final String? total;
  final List<OrderDetailModel> data;

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      error: json["error"],
      message: json["message"],
      total:
          json["total"]?.toString(), // Convert total to String if it's an int
      data: json["data"] == null
          ? []
          : List<OrderDetailModel>.from(
              json["data"]!.map((x) => OrderDetailModel.fromJson(x))),
    );
  }
}

class OrderDetailModel {
  OrderDetailModel({
    required this.id,
    required this.userId,
    required this.addressId,
    required this.mobile,
    required this.total,
    required this.deliveryCharge,
    required this.isDeliveryChargeReturnable,
    required this.walletBalance,
    required this.promoCode,
    required this.promoDiscount,
    required this.discount,
    required this.totalPayable,
    required this.finalTotal,
    required this.paymentMethod,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.deliveryTime,
    required this.deliveryDate,
    required this.dateAdded,
    required this.otp,
    required this.email,
    required this.notes,
    required this.orderType,
    required this.visible,
    required this.username,
    required this.countryCode,
    required this.name,
    required this.type,
    required this.downloadAllowed,
    required this.orderRecipientPerson,
    required this.specialPrice,
    required this.price,
    required this.attachments,
    required this.courierAgency,
    required this.trackingId,
    required this.url,
    required this.isReturnable,
    required this.isCancelable,
    required this.isAlreadyReturned,
    required this.isAlreadyCancelled,
    required this.returnRequestSubmitted,
    required this.totalTaxPercent,
    required this.totalTaxAmount,
    required this.invoiceHtml,
    required this.orderItems,
  });

  final String? id;
  final String? userId;
  final dynamic addressId;
  final String? mobile;
  final String? total;
  final String? deliveryCharge;
  final String? isDeliveryChargeReturnable;
  final String? walletBalance;
  final dynamic promoCode;
  final String? promoDiscount;
  final String? discount;
  final String? totalPayable;
  final String? finalTotal;
  final String? paymentMethod;
  final String? latitude;
  final String? longitude;
  final String? address;
  final String? deliveryTime;
  final String? deliveryDate;
  final DateTime? dateAdded;
  final String? otp;
  final String? email;
  final String? notes;
  final String? orderType;
  final String? visible;
  final String? username;
  final String? countryCode;
  final String? name;
  final String? type;
  final String? downloadAllowed;
  final String? orderRecipientPerson;
  final String? specialPrice;
  final String? price;
  final List<dynamic> attachments;
  final String? courierAgency;
  final String? trackingId;
  final String? url;
  final String? isReturnable;
  final String? isCancelable;
  final String? isAlreadyReturned;
  final String? isAlreadyCancelled;
  final String? returnRequestSubmitted;
  final String? totalTaxPercent;
  final String? totalTaxAmount;
  final String? invoiceHtml;
  final List<OrderItem> orderItems;

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailModel(
      id: json["id"],
      userId: json["user_id"],
      addressId: json["address_id"],
      mobile: json["mobile"],
      total:
          json["total"]?.toString(), // Convert total to String if it's an int
      deliveryCharge: json["delivery_charge"]?.toString(),
      isDeliveryChargeReturnable: json["is_delivery_charge_returnable"],
      walletBalance: json["wallet_balance"]?.toString(),
      promoCode: json["promo_code"],
      promoDiscount: json["promo_discount"]?.toString(),
      discount: json["discount"]?.toString(),
      totalPayable: json["total_payable"]?.toString(),
      finalTotal: json["final_total"]?.toString(),
      paymentMethod: json["payment_method"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      address: json["address"],
      deliveryTime: json["delivery_time"],
      deliveryDate: json["delivery_date"],
      dateAdded: DateTime.tryParse(json["date_added"] ?? ""),
      otp: json["otp"],
      email: json["email"],
      notes: json["notes"],
      orderType: json["order_type"],
      visible: json["visible"],
      username: json["username"],
      countryCode: json["country_code"],
      name: json["name"],
      type: json["type"],
      downloadAllowed: json["download_allowed"],
      orderRecipientPerson: json["order_recipient_person"],
      specialPrice: json["special_price"]?.toString(),
      price: json["price"]?.toString(),
      attachments: json["attachments"] == null
          ? []
          : List<dynamic>.from(json["attachments"]!.map((x) => x)),
      courierAgency: json["courier_agency"],
      trackingId: json["tracking_id"],
      url: json["url"],
      isReturnable: json["is_returnable"],
      isCancelable: json["is_cancelable"],
      isAlreadyReturned: json["is_already_returned"],
      isAlreadyCancelled: json["is_already_cancelled"],
      returnRequestSubmitted: json["return_request_submitted"],
      totalTaxPercent: json["total_tax_percent"]?.toString(),
      totalTaxAmount: json["total_tax_amount"]?.toString(),
      invoiceHtml: json["invoice_html"],
      orderItems: json["order_items"] == null
          ? []
          : List<OrderItem>.from(
              json["order_items"]!.map((x) => OrderItem.fromJson(x))),
    );
  }
}

class OrderItem {
  OrderItem({
    required this.id,
    required this.userId,
    required this.orderId,
    required this.deliveryBoyId,
    required this.sellerId,
    required this.isCredited,
    required this.otp,
    required this.productName,
    required this.variantName,
    required this.productVariantId,
    required this.quantity,
    required this.price,
    required this.discountedPrice,
    required this.taxPercent,
    required this.taxAmount,
    required this.discount,
    required this.subTotal,
    required this.deliverBy,
    required this.updatedBy,
    required this.status,
    required this.adminCommissionAmount,
    required this.sellerCommissionAmount,
    required this.activeStatus,
    required this.hashLink,
    required this.isSent,
    required this.dateAdded,
    required this.productId,
    required this.isCancelable,
    required this.cancelableTill,
    required this.type,
    required this.slug,
    required this.downloadAllowed,
    required this.downloadLink,
    required this.storeName,
    required this.sellerLongitude,
    required this.sellerMobile,
    required this.sellerAddress,
    required this.sellerLatitude,
    required this.deliveryBoyName,
    required this.deliveryBoyNumber,
    required this.storeDescription,
    required this.sellerRating,
    required this.sellerProfile,
    required this.courierAgency,
    required this.trackingId,
    required this.url,
    required this.sellerName,
    required this.isReturnable,
    required this.specialPrice,
    required this.mainPrice,
    required this.image,
    required this.name,
    required this.productRating,
    required this.userRating,
    required this.userRatingImages,
    required this.userRatingComment,
    required this.orderCounter,
    required this.orderCancelCounter,
    required this.orderReturnCounter,
    required this.netAmount,
    required this.variantIds,
    required this.variantValues,
    required this.attrName,
    required this.imageSm,
    required this.imageMd,
    required this.isAlreadyReturned,
    required this.isAlreadyCancelled,
    required this.returnRequestSubmitted,
    required this.email,
  });

  final String? id;
  final String? userId;
  final String? orderId;
  final String? deliveryBoyId;
  final String? sellerId;
  final String? isCredited;
  final String? otp;
  final String? productName;
  final String? variantName;
  final String? productVariantId;
  final String? quantity;
  final String? price;
  final String? discountedPrice;
  final String? taxPercent;
  final dynamic taxAmount;
  final String? discount;
  final String? subTotal;
  final String? deliverBy;
  final String? updatedBy;
  final List<List<String>> status;
  final String? adminCommissionAmount;
  final String? sellerCommissionAmount;
  final String? activeStatus;
  final String? hashLink;
  final String? isSent;
  final DateTime? dateAdded;
  final String? productId;
  final String? isCancelable;
  final String? cancelableTill;
  final String? type;
  final String? slug;
  final String? downloadAllowed;
  final String? downloadLink;
  final String? storeName;
  final String? sellerLongitude;
  final String? sellerMobile;
  final String? sellerAddress;
  final String? sellerLatitude;
  final String? deliveryBoyName;
  final String? deliveryBoyNumber;
  final String? storeDescription;
  final String? sellerRating;
  final String? sellerProfile;
  final String? courierAgency;
  final String? trackingId;
  final String? url;
  final String? sellerName;
  final String? isReturnable;
  final String? specialPrice;
  final String? mainPrice;
  final String? image;
  final String? name;
  final String? productRating;
  final String? userRating;
  final List<String> userRatingImages;
  final String? userRatingComment;
  final String? orderCounter;
  final String? orderCancelCounter;
  final String? orderReturnCounter;
  final num? netAmount;
  final String? variantIds;
  final String? variantValues;
  final String? attrName;
  final String? imageSm;
  final String? imageMd;
  final String? isAlreadyReturned;
  final String? isAlreadyCancelled;
  final String? returnRequestSubmitted;
  final String? email;

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json["id"],
      userId: json["user_id"],
      orderId: json["order_id"],
      deliveryBoyId: json["delivery_boy_id"],
      sellerId: json["seller_id"],
      isCredited: json["is_credited"],
      otp: json["otp"],
      productName: json["product_name"],
      variantName: json["variant_name"],
      productVariantId: json["product_variant_id"],
      quantity: json["quantity"],
      price: json["price"],
      discountedPrice: json["discounted_price"],
      taxPercent: json["tax_percent"]?.toString(),
      taxAmount: json["tax_amount"],
      discount: json["discount"],
      subTotal: json["sub_total"],
      deliverBy: json["deliver_by"],
      updatedBy: json["updated_by"],
      status: json["status"] == null
          ? []
          : List<List<String>>.from(
              json["status"].map((x) => List<String>.from(x))),
      adminCommissionAmount: json["admin_commission_amount"],
      sellerCommissionAmount: json["seller_commission_amount"],
      activeStatus: json["active_status"],
      hashLink: json["hash_link"],
      isSent: json["is_sent"],
      dateAdded: json["date_added"] != null
          ? DateTime.tryParse(json["date_added"])
          : null,
      productId: json["product_id"],
      isCancelable: json["is_cancelable"],
      cancelableTill: json["cancelable_till"],
      type: json["type"],
      slug: json["slug"],
      downloadAllowed: json["download_allowed"],
      downloadLink: json["download_link"],
      storeName: json["store_name"],
      sellerLongitude: json["seller_longitude"],
      sellerMobile: json["seller_mobile"],
      sellerAddress: json["seller_address"],
      sellerLatitude: json["seller_latitude"],
      deliveryBoyName: json["delivery_boy_name"],
      deliveryBoyNumber: json["delivery_boy_number"],
      storeDescription: json["store_description"],
      sellerRating: json["seller_rating"],
      sellerProfile: json["seller_profile"],
      courierAgency: json["courier_agency"],
      trackingId: json["tracking_id"],
      url: json["url"],
      sellerName: json["seller_name"],
      isReturnable: json["is_returnable"],
      specialPrice: json["special_price"],
      mainPrice: json["main_price"],
      image: json["image"],
      name: json["name"],
      productRating: json["product_rating"],
      userRating: json["user_rating"],
      userRatingImages: json["user_rating_images"] == null
          ? []
          : List<String>.from(
              json["user_rating_images"].map((x) => x.toString())),
      userRatingComment: json["user_rating_comment"],
      orderCounter: json["order_counter"],
      orderCancelCounter: json["order_cancel_counter"],
      orderReturnCounter: json["order_return_counter"],
      netAmount: json["net_amount"],
      variantIds: json["varaint_ids"],
      variantValues: json["variant_values"],
      attrName: json["attr_name"],
      imageSm: json["image_sm"],
      imageMd: json["image_md"],
      isAlreadyReturned: json["is_already_returned"],
      isAlreadyCancelled: json["is_already_cancelled"],
      returnRequestSubmitted: json["return_request_submitted"],
      email: json["email"],
    );
  }
}
