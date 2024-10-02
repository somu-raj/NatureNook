
import 'package:intl/intl.dart';

class CartModel {
  CartModel({
    required this.error,
    required this.message,
    required this.totalQuantity,
    required this.subTotal,
    required this.deliveryCharge,
    required this.taxPercentage,
    required this.taxAmount,
    required this.overallAmount,
    required this.totalArr,
    required this.variantId,
    required this.data,
    required this.promoCodes,
  });

  final bool? error;
  final String? message;
  final String? totalQuantity;
  final String? subTotal;
  final num deliveryCharge;
  final String? taxPercentage;
  final String? taxAmount;
  final num? overallAmount;
  final num? totalArr;
  final List<String> variantId;
  final List<CartData> data;
  final List<PromoData> promoCodes;

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      error: json["error"],
      message: json["message"],
      totalQuantity: json["total_quantity"],
      subTotal: json["sub_total"],
      deliveryCharge: num.parse(json["delivery_charge"]??'0'),
      taxPercentage: json["tax_percentage"],
      taxAmount: json["tax_amount"],
      overallAmount: num.parse(json["overall_amount"] ?? "0"),
      totalArr: json["total_arr"],
      variantId: json["variant_id"] == null
          ? []
          : List<String>.from(json["variant_id"]!.map((x) => x)),
      data: json["data"] == null
          ? []
          : List<CartData>.from(json["data"]!.map((x) => CartData.fromJson(x))),
      promoCodes: json["promo_codes"] == null
          ? []
          : List<PromoData>.from(json["promo_codes"]!.map((x) => PromoData.fromJson(x))),
    );
  }
}

class CartData {
  CartData({
    required this.id,
    required this.userId,
    required this.productVariantId,
    required this.qty,
    required this.isSavedForLater,
    required this.dateCreated,
    required this.isPricesInclusiveTax,
    required this.name,
    required this.type,
    required this.image,
    required this.shortDescription,
    required this.minimumOrderQuantity,
    required this.quantityStepSize,
    required this.totalAllowedQuantity,
    required this.price,
    required this.specialPrice,
    required this.taxPercentage,
    required this.netAmount,
    required this.taxAmount,
    required this.subTotal,
    required this.productVariants,
    required this.productDetails,
  });

  final String? id;
  final String? userId;
  final String? productVariantId;
  final String? qty;
  final String? isSavedForLater;
  final DateTime? dateCreated;
  final String? isPricesInclusiveTax;
  final String? name;
  final String? type;
  final String? image;
  final String? shortDescription;
  final String? minimumOrderQuantity;
  final String? quantityStepSize;
  final String? totalAllowedQuantity;
  final dynamic price;
  final dynamic specialPrice;
  final String? taxPercentage;
  final num? netAmount;
  final num? taxAmount;
  final num? subTotal;
  final List<ProductVariant> productVariants;
  final List<ProductDetail> productDetails;

  factory CartData.fromJson(Map<String, dynamic> json) {
    return CartData(
      id: json["id"],
      userId: json["user_id"],
      productVariantId: json["product_variant_id"],
      qty: json["qty"],
      isSavedForLater: json["is_saved_for_later"],
      dateCreated: DateTime.tryParse(json["date_created"] ?? ""),
      isPricesInclusiveTax: json["is_prices_inclusive_tax"],
      name: json["name"],
      type: json["type"],
      image: json["image"],
      shortDescription: json["short_description"],
      minimumOrderQuantity: json["minimum_order_quantity"],
      quantityStepSize: json["quantity_step_size"],
      totalAllowedQuantity: json["total_allowed_quantity"],
      price: json["price"],
      specialPrice: json["special_price"],
      taxPercentage: json["tax_percentage"],
      netAmount: json["net_amount"],
      taxAmount: json["tax_amount"],
      subTotal: json["sub_total"],
      productVariants: json["product_variants"] == null
          ? []
          : List<ProductVariant>.from(
              json["product_variants"]!.map((x) => ProductVariant.fromJson(x))),
      productDetails: json["product_details"] == null
          ? []
          : List<ProductDetail>.from(
              json["product_details"]!.map((x) => ProductDetail.fromJson(x))),
    );
  }
}

class ProductDetail {
  ProductDetail({
    required this.total,
    required this.sales,
    required this.stockType,
    required this.isPricesInclusiveTax,
    required this.type,
    required this.attrValueIds,
    required this.sellerRating,
    required this.sellerSlug,
    required this.sellerNoOfRatings,
    required this.sellerProfile,
    required this.storeName,
    required this.storeDescription,
    required this.sellerId,
    required this.sellerName,
    required this.id,
    required this.stock,
    required this.name,
    required this.categoryId,
    required this.shortDescription,
    required this.slug,
    required this.description,
    required this.totalAllowedQuantity,
    required this.status,
    required this.deliverableType,
    required this.deliverableZipcodes,
    required this.minimumOrderQuantity,
    required this.sku,
    required this.quantityStepSize,
    required this.codAllowed,
    required this.rowOrder,
    required this.rating,
    required this.noOfRatings,
    required this.image,
    required this.isReturnable,
    required this.isCancelable,
    required this.cancelableTill,
    required this.indicator,
    required this.otherImages,
    required this.videoType,
    required this.video,
    required this.tags,
    required this.warrantyPeriod,
    required this.guaranteePeriod,
    required this.madeIn,
    required this.hsnCode,
    required this.downloadAllowed,
    required this.downloadType,
    required this.downloadLink,
    required this.brand,
    required this.availability,
    required this.categoryName,
    required this.taxPercentage,
    required this.taxId,
    required this.reviewImages,
    required this.attributes,
    required this.variants,
    required this.totalStock,
    required this.minMaxPrice,
    required this.relativePath,
    required this.otherImagesRelativePath,
    required this.videoRelativePath,
    required this.totalProduct,
    required this.deliverableZipcodesIds,
    required this.isDeliverable,
    required this.isPurchased,
    required this.isFavorite,
    required this.imageMd,
    required this.imageSm,
    required this.otherImagesMd,
    required this.otherImagesSm,
    required this.variantAttributes,
    required this.netAmount,
  });

  final String? total;
  final String? sales;
  final String? stockType;
  final String? isPricesInclusiveTax;
  final String? type;
  final String? attrValueIds;
  final String? sellerRating;
  final String? sellerSlug;
  final String? sellerNoOfRatings;
  final String? sellerProfile;
  final String? storeName;
  final String? storeDescription;
  final String? sellerId;
  final String? sellerName;
  final String? id;
  final String? stock;
  final String? name;
  final String? categoryId;
  final String? shortDescription;
  final String? slug;
  final String? description;
  final String? totalAllowedQuantity;
  final String? status;
  final String? deliverableType;
  final String? deliverableZipcodes;
  final String? minimumOrderQuantity;
  final String? sku;
  final String? quantityStepSize;
  final String? codAllowed;
  final String? rowOrder;
  final String? rating;
  final String? noOfRatings;
  final String? image;
  final String? isReturnable;
  final String? isCancelable;
  final String? cancelableTill;
  final String? indicator;
  final List<String> otherImages;
  final String? videoType;
  final String? video;
  final List<String> tags;
  final String? warrantyPeriod;
  final String? guaranteePeriod;
  final String? madeIn;
  final String? hsnCode;
  final String? downloadAllowed;
  final String? downloadType;
  final String? downloadLink;
  final String? brand;
  final String? availability;
  final String? categoryName;
  final String? taxPercentage;
  final String? taxId;
  final List<dynamic> reviewImages;
  final List<dynamic> attributes;
  final List<Variant> variants;
  final String? totalStock;
  final MinMaxPrice? minMaxPrice;
  final String? relativePath;
  final List<String> otherImagesRelativePath;
  final String? videoRelativePath;
  final String? totalProduct;
  final String? deliverableZipcodesIds;
  final bool? isDeliverable;
  final bool? isPurchased;
  final num? isFavorite;
  final String? imageMd;
  final String? imageSm;
  final List<String> otherImagesMd;
  final List<String> otherImagesSm;
  final List<dynamic> variantAttributes;
  final num? netAmount;

  factory ProductDetail.fromJson(Map<String, dynamic> json) {
    return ProductDetail(
      total: json["total"],
      sales: json["sales"],
      stockType: json["stock_type"],
      isPricesInclusiveTax: json["is_prices_inclusive_tax"],
      type: json["type"],
      attrValueIds: json["attr_value_ids"],
      sellerRating: json["seller_rating"],
      sellerSlug: json["seller_slug"],
      sellerNoOfRatings: json["seller_no_of_ratings"],
      sellerProfile: json["seller_profile"],
      storeName: json["store_name"],
      storeDescription: json["store_description"],
      sellerId: json["seller_id"],
      sellerName: json["seller_name"],
      id: json["id"],
      stock: json["stock"],
      name: json["name"],
      categoryId: json["category_id"],
      shortDescription: json["short_description"],
      slug: json["slug"],
      description: json["description"],
      totalAllowedQuantity: json["total_allowed_quantity"],
      status: json["status"],
      deliverableType: json["deliverable_type"],
      deliverableZipcodes: json["deliverable_zipcodes"],
      minimumOrderQuantity: json["minimum_order_quantity"],
      sku: json["sku"],
      quantityStepSize: json["quantity_step_size"],
      codAllowed: json["cod_allowed"],
      rowOrder: json["row_order"],
      rating: json["rating"],
      noOfRatings: json["no_of_ratings"],
      image: json["image"],
      isReturnable: json["is_returnable"],
      isCancelable: json["is_cancelable"],
      cancelableTill: json["cancelable_till"],
      indicator: json["indicator"],
      otherImages: json["other_images"] == null
          ? []
          : List<String>.from(json["other_images"]!.map((x) => x)),
      videoType: json["video_type"],
      video: json["video"],
      tags: json["tags"] == null
          ? []
          : List<String>.from(json["tags"]!.map((x) => x)),
      warrantyPeriod: json["warranty_period"],
      guaranteePeriod: json["guarantee_period"],
      madeIn: json["made_in"],
      hsnCode: json["hsn_code"],
      downloadAllowed: json["download_allowed"],
      downloadType: json["download_type"],
      downloadLink: json["download_link"],
      brand: json["brand"],
      availability: json["availability"],
      categoryName: json["category_name"],
      taxPercentage: json["tax_percentage"],
      taxId: json["tax_id"],
      reviewImages: json["review_images"] == null
          ? []
          : List<dynamic>.from(json["review_images"]!.map((x) => x)),
      attributes: json["attributes"] == null
          ? []
          : List<dynamic>.from(json["attributes"]!.map((x) => x)),
      variants: json["variants"] == null
          ? []
          : List<Variant>.from(
              json["variants"]!.map((x) => Variant.fromJson(x))),
      totalStock: json["total_stock"],
      minMaxPrice: json["min_max_price"] == null
          ? null
          : MinMaxPrice.fromJson(json["min_max_price"]),
      relativePath: json["relative_path"],
      otherImagesRelativePath: json["other_images_relative_path"] == null
          ? []
          : List<String>.from(
              json["other_images_relative_path"]!.map((x) => x)),
      videoRelativePath: json["video_relative_path"],
      totalProduct: json["total_product"],
      deliverableZipcodesIds: json["deliverable_zipcodes_ids"],
      isDeliverable: json["is_deliverable"],
      isPurchased: json["is_purchased"],
      isFavorite: json["is_favorite"],
      imageMd: json["image_md"],
      imageSm: json["image_sm"],
      otherImagesMd: json["other_images_md"] == null
          ? []
          : List<String>.from(json["other_images_md"]!.map((x) => x)),
      otherImagesSm: json["other_images_sm"] == null
          ? []
          : List<String>.from(json["other_images_sm"]!.map((x) => x)),
      variantAttributes: json["variant_attributes"] == null
          ? []
          : List<dynamic>.from(json["variant_attributes"]!.map((x) => x)),
      netAmount: json["net_amount"],
    );
  }
}

class MinMaxPrice {
  MinMaxPrice({
    required this.minPrice,
    required this.maxPrice,
    required this.specialPrice,
    required this.maxSpecialPrice,
    required this.discountInPercentage,
  });

  final num? minPrice;
  final num? maxPrice;
  final num? specialPrice;
  final num? maxSpecialPrice;
  final num? discountInPercentage;

  factory MinMaxPrice.fromJson(Map<String, dynamic> json) {
    return MinMaxPrice(
      minPrice: json["min_price"],
      maxPrice: json["max_price"],
      specialPrice: json["special_price"],
      maxSpecialPrice: json["max_special_price"],
      discountInPercentage: json["discount_in_percentage"],
    );
  }
}

class Variant {
  Variant({
    required this.id,
    required this.productId,
    required this.attributeValueIds,
    required this.attributeSet,
    required this.price,
    required this.specialPrice,
    required this.sku,
    required this.stock,
    required this.images,
    required this.availability,
    required this.status,
    required this.dateAdded,
    required this.variantIds,
    required this.attrName,
    required this.variantValues,
    required this.swatcheType,
    required this.swatcheValue,
    required this.imagesMd,
    required this.imagesSm,
    required this.variantRelativePath,
    required this.cartCount,
    required this.isPurchased,
  });

  final String? id;
  final String? productId;
  final String? attributeValueIds;
  final String? attributeSet;
  final String? price;
  final String? specialPrice;
  final String? sku;
  final String? stock;
  final List<dynamic> images;
  final String? availability;
  final String? status;
  final DateTime? dateAdded;
  final String? variantIds;
  final String? attrName;
  final String? variantValues;
  final String? swatcheType;
  final String? swatcheValue;
  final List<dynamic> imagesMd;
  final List<dynamic> imagesSm;
  final List<dynamic> variantRelativePath;
  final String? cartCount;
  final num? isPurchased;

  factory Variant.fromJson(Map<String, dynamic> json) {
    return Variant(
      id: json["id"],
      productId: json["product_id"],
      attributeValueIds: json["attribute_value_ids"],
      attributeSet: json["attribute_set"],
      price: json["price"],
      specialPrice: json["special_price"],
      sku: json["sku"],
      stock: json["stock"],
      images: json["images"] == null
          ? []
          : List<dynamic>.from(json["images"]!.map((x) => x)),
      availability: json["availability"],
      status: json["status"],
      dateAdded: DateTime.tryParse(json["date_added"] ?? ""),
      variantIds: json["variant_ids"],
      attrName: json["attr_name"],
      variantValues: json["variant_values"],
      swatcheType: json["swatche_type"],
      swatcheValue: json["swatche_value"],
      imagesMd: json["images_md"] == null
          ? []
          : List<dynamic>.from(json["images_md"]!.map((x) => x)),
      imagesSm: json["images_sm"] == null
          ? []
          : List<dynamic>.from(json["images_sm"]!.map((x) => x)),
      variantRelativePath: json["variant_relative_path"] == null
          ? []
          : List<dynamic>.from(json["variant_relative_path"]!.map((x) => x)),
      cartCount: json["cart_count"],
      isPurchased: json["is_purchased"],
    );
  }
}

class ProductVariant {
  ProductVariant({
    required this.id,
    required this.productId,
    required this.attributeValueIds,
    required this.attributeSet,
    required this.price,
    required this.specialPrice,
    required this.sku,
    required this.stock,
    required this.images,
    required this.availability,
    required this.status,
    required this.dateAdded,
    required this.varaintIds,
    required this.attrName,
    required this.variantValues,
  });

  final String? id;
  final String? productId;
  final String? attributeValueIds;
  final String? attributeSet;
  final String? price;
  final String? specialPrice;
  final String? sku;
  final String? stock;
  final String? images;
  final String? availability;
  final String? status;
  final DateTime? dateAdded;
  final String? varaintIds;
  final String? attrName;
  final String? variantValues;

  factory ProductVariant.fromJson(Map<String, dynamic> json) {
    return ProductVariant(
      id: json["id"],
      productId: json["product_id"],
      attributeValueIds: json["attribute_value_ids"],
      attributeSet: json["attribute_set"],
      price: json["price"],
      specialPrice: json["special_price"],
      sku: json["sku"],
      stock: json["stock"],
      images: json["images"],
      availability: json["availability"],
      status: json["status"],
      dateAdded: DateTime.tryParse(json["date_added"] ?? ""),
      varaintIds: json["varaint_ids"],
      attrName: json["attr_name"],
      variantValues: json["variant_values"],
    );
  }
}

class PromoData {
  PromoData({
     this.id,
     this.promoCode,
     this.message,
     this.startDate,
     this.endDate,
     this.discount,
     this.repeatUsage,
     this.minOrderAmt,
     this.noOfUsers,
     this.discountType,
     this.maxDiscountAmt,
     this.image,
     this.noOfRepeatUsage,
     this.status,
     this.isCashback,
     this.listPromocode,
     this.remainingDays,
  });

  final String? id;
  final String? promoCode;
  final String? message;
  final String? startDate;
  final String? endDate;
  final num? discount;
  final String? repeatUsage;
  final String? minOrderAmt;
  final String? noOfUsers;
  final String? discountType;
  final String? maxDiscountAmt;
  final String? image;
  final String? noOfRepeatUsage;
  final String? status;
  final String? isCashback;
  final String? listPromocode;
  final String? remainingDays;

  factory PromoData.fromJson(Map<String, dynamic> json){
    return PromoData(
      id: json["id"],
      promoCode: json["promo_code"],
      message: json["message"],
      startDate: (json["start_date"]??'').isEmpty ?'': DateFormat('dd-MMM-yyyy').format(DateTime.parse(json["start_date"])),
      endDate: (json["end_date"]??'').isEmpty ?'': DateFormat('dd-MMM-yyyy').format(DateTime.parse(json["end_date"])),
      discount: num.parse(json["discount"]??'0'),
      repeatUsage: json["repeat_usage"],
      minOrderAmt: json["min_order_amt"],
      noOfUsers: json["no_of_users"],
      discountType: json["discount_type"],
      maxDiscountAmt: json["max_discount_amt"],
      image: json["image"],
      noOfRepeatUsage: json["no_of_repeat_usage"],
      status: json["status"],
      isCashback: json["is_cashback"],
      listPromocode: json["list_promocode"],
      remainingDays: json["remaining_days"],
    );
  }

}

