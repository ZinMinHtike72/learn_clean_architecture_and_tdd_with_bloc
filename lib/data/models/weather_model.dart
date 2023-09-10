
import 'package:learn_clean_architecture/domain/entities/weather.dart';

class WeatherModel extends WeatherEntity {
  WeatherModel({
    required super.cityName,
    required super.main,
    required super.description,
    required super.iconCode,
    required super.temperature,
    required super.pressure,
    required super.humidity,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        cityName: json["name"],
        main: json['weather'][0]["main"],
        description: json["weather"][0]["description"],
        iconCode: json["weather"][0]['icon'],
        temperature: json['main']['temp'],
        pressure: json['main']['pressure'],
        humidity: json['main']['humidity'],
      );

  Map<String, dynamic> toJson() => {
        "coord": {"lon": -0.1257, "lat": 51.5085},
        "weather": [
          {
            "main": "Clear",
            "description": "clear sky",
            "icon": "01n",
          }
        ],
        "main": {
          "temp": 288.64,
          "pressure": 1017,
          "humidity": 91,
        },
        "name": "London",
      };

  WeatherEntity toEntitiy() => WeatherEntity(
        cityName: "New York",
        main: "Clouds",
        description: "few clouds",
        iconCode: "02d",
        temperature: 302.28,
        pressure: 1009,
        humidity: 70,
      );
}
