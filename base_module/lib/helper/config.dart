class AppConfig {
  static const String apiTestUrl = "https://e-card.in/aadarsh/api/";
  static const String apiProdUrl = "https://e-card.in/aadarsh/api/";
  static const String apiTestKey = "testkey";
  static const String apiProdKey = "57c14bd7-8abc-4d2c-a4d9-30eb2c56c9e2";
  static const reverseAddressApi = "https://maps.googleapis.com/maps/api/geocode/json";
  static const String mapApiKey = "AIzaSyBceW2idxTf2cW7DGkrdHsg90NL9udR9Hw";
  static const bool isProduction = true;
  static String get baseUrl => isProduction ? apiProdUrl : apiTestUrl;
  static String get apiKey => isProduction ? apiProdKey : apiTestKey;
  static const String actionLogin = 'login';
  static const String actionGetRequestForApproval = 'request_for_approval';
}
