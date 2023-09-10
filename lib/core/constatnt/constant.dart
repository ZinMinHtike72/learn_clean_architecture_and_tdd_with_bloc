class Urls {
  static const String baseUrl = "https://api.openweathermap.org/data/2.5";
  static const String apiKey = "957d8661f1a15865e29ef42377c4ccd5";
  static String currentWeatherByName(String city) {
    return "$baseUrl/weather?q=$city&appid=$apiKey";
  }

  static String weatherIcon(String iconCode) {
    return "https://openweathermap.org/img/wn/$iconCode@2x.png";
  }
}

// https://api.openweathermap.org/data/2.5/weather?q=London,uk&APPID=957d8661f1a15865e29ef42377c4ccd5
