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
  static String get getstatuswisecount => "$baseUrl/task/getstatuswisecount";
  static String get getlistwithtimedata => "$baseUrl/task/getlistwithtimedata";
  static String get projectTermGetList => "$baseUrl/projectterm/getlist";
  static String get createTask => "$baseUrl/task/save";
  static String get forgotpassword => "$baseUrl/user/forgotpassword";
  static String get updatePasswordUrl => "$baseUrl/user/forgotpassword";
  static String get projectGetList => "$baseUrl/project/getlist";
  static String get startTask => "$baseUrl/task/taskstarttimer";
  static String get stopTask => "$baseUrl/task/taskstoptimer";
  static String get taskDetails => "$baseUrl/task/getdetailsbyid";
  static String get getRunningDetails => "$baseUrl/timer/getrunningtaskdetails";
  static String get subPointCheckUnCheck => "$baseUrl/tasksubpoint/checkuncheck";
}