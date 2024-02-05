class ServerConfig{
  /// BASE_URL
  static String prodImgUrl = "https://ishatiprod.softcube.co.in/";
  static String qaImgUrl = "https://ishatiqa.softcube.co.in/";

  // static String mainImgUrl = "https://1appnam.com/";

  static String mainImgUrl = "https://isati.s3.amazonaws.com/";


  static String imageUrl = mainImgUrl;

  static String qa = "https://ishatiqa.softcube.co.in/api/v1";
  static String prod = "https://ishatiprod.softcube.co.in/api/v1";
  static String mainUrl = "http://146.0.249.62:8282/api/v1";

  static String baseUrl = mainUrl;

  /// API_URL
  static String get loginUrl => "$baseUrl/user/login";
  static String get registerUrl => "$baseUrl/restaurant_user/sign_up";
  static String get forgotUrl => "$baseUrl/restaurant_user/send_otp";
  static String get sendOtpUrl => "$baseUrl/restaurant_user/send_otp_without_auth";
  static String get verifyOtpUrl => "$baseUrl/restaurant_user/verify_otp";
  static String get getRestaurantTermsUrl => "$baseUrl/get_restaurant_terms";
  static String get getTagUrl => "$baseUrl/get_terms";
  static String get changePasswordUrl => "$baseUrl/restaurant_user/reset_password";
  static String get updateUserUrl => "$baseUrl/restaurant_user/update_profile";

  ///User
  static String get getUserDetailsUrl => "$baseUrl/restaurant_user/user_details";

  /// category
  static String get getBusinessCategoryList => "$baseUrl/restaurant_user/get_business_category_list";
  static String get getMasterCategoryList => "$baseUrl/restaurant_user/get_master_category_list";
  static String get addCategory => "$baseUrl/restaurant_user/add_category";
  static String get deleteCategory => "$baseUrl/restaurant_user/delete_category";
  static String get detailCategory => "$baseUrl/restaurant_user/get_category_detail";
  static String get deleteImageCategory => "$baseUrl/restaurant_user/delete_category_image";
  static String get updateCategory => "$baseUrl/restaurant_user/update_category";

  /// Restaurant
  static String get setStatus => "$baseUrl/restaurant_user/set_status";
  static String get detailRestaurantCategory => "$baseUrl/restaurant_user/get_restaurant_details";
  static String get updateRestaurantCategory => "$baseUrl/restaurant_user/update_restaurant_details";
  static String get deleteRestaurantImage => "$baseUrl/restaurant_user/delete_restaurant_image";

  /// Item
  static String get itemListUrl => "$baseUrl/restaurant_user/get_item_list";
  static String get updateItemUrl => "$baseUrl/restaurant_user/update_item";
  static String get deleteItemImageUrl => "$baseUrl/restaurant_user/delete_item_image";
  static String get deleteItemUrl => "$baseUrl/restaurant_user/delete_item";
  static String get itemDetailUrl => "$baseUrl/restaurant_user/get_item_detail";
  static String get addItemUrl => "$baseUrl/restaurant_user/add_item";

  ///Order
  static String get orderListUrl => "$baseUrl/restaurant_user/order_list";
  static String get orderDetailsUrl => "$baseUrl/restaurant_user/orders_details";
  static String get changeOrderStatusUrl => "$baseUrl/restaurant_user/change_order_status";
  static String get orderItemStatusUrl => "$baseUrl/restaurant_user/change_order_item_status";

  /// Report
  static String get reportListUrl => "$baseUrl/restaurant_user/report_list";

  ///setting
  static String get logOutAccountUrl => "$baseUrl/restaurant_user/logout";
  static String get deleteAccountUrl => "$baseUrl/restaurant_user/delete_account";
  static String get appSettingUrl => "$baseUrl/restaurant_user/get_app_setting";
  static String get updateFcmTokenUrl => "$baseUrl/restaurant_user/update_device_token";

}