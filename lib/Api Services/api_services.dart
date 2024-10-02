

class ApiServices {
   final String _baseUrl =   const String.fromEnvironment("BASE_URL") /*dotenv.env["BASE_URL"] ?? ""*/;

  String get baseUrl => _baseUrl;

  //api url

  ///auth
  String get login => "$baseUrl/login";
  String get verifyNewUser => "$baseUrl/verify_user";
  String get verifyOtp => "$baseUrl/verify_number";
  String get registerNewUser => "$baseUrl/register_user";
  String get getProfile => "$baseUrl/get_user_profile";
  String get updateProfile => "$baseUrl/update_user";
  String get changePassword => "$baseUrl/change_password";
   String get deleteAccount => "$baseUrl/delete_user";
   String get forgotPassword => "$baseUrl/forgot_otp";
   String get resetPassword => "$baseUrl/forgot_password";

  ///home
  String get getSliderImages => "$baseUrl/get_slider_images";
  String get getCategory => "$baseUrl/get_categories";
  String get getBrands => "$baseUrl/get_sellers";
  String get getSections => "$baseUrl/get_sections";
  String get getProducts => "$baseUrl/get_products";
  String get getTags => "$baseUrl/get_tags";

  ///cart
  String get getCart => "$baseUrl/get_user_cart";
  String get getAllPinCodes => "$baseUrl/get_zipcodes";
  String get addToCart => "$baseUrl/manage_cart";
  String get removeFromCart => "$baseUrl/remove_from_cart";
  String get promoCodeApply => "$baseUrl/validate_promo_code";

  ///manage address
  String get getAddresses => "$baseUrl/get_address";
  String get getPostOfficesData => "http://www.postalpincode.in/api/pincode/";
  String get addNewAddress => "$baseUrl/add_address";
  String get deleteAddress => "$baseUrl/delete_address";
  String get updateAddress => "$baseUrl/update_address";

  /// Order manage
  String get checkDeliverable => "$baseUrl/is_product_delivarable";
  String get getOrder => "$baseUrl/get_orders";
  String get placeOrder => "$baseUrl/place_order";
  String get cancelReturnItem => "$baseUrl/update_order_item_status";

  /// setting manage
  String get getSetting => "$baseUrl/get_settings";

  /// getFaqs manage
  String get getFaqs => "$baseUrl/get_faqs";

  /// getFaqs manage
  String get addRating => "$baseUrl/set_product_rating";
  String get getRating => "$baseUrl/get_product_rating";

  /// getTransactions manage
  String get getTransaction => "$baseUrl/transactions";

  /// get Wallet manage
  String get getWallet => "$baseUrl/get_wallet";

  /// get Notification apo
  String get getNotification => "$baseUrl/get_notifications";
}
