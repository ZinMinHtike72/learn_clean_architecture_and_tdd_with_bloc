import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:learn_clean_architecture/data/models/weather_model.dart';
import 'package:learn_clean_architecture/domain/entities/weather.dart';

import '../../helpers/json_reader.dart';

//!Model Testing
void main() {
  final testWeatherModel = WeatherModel(
    cityName: "London",
    main: "Clear",
    description: "clear sky",
    iconCode: "01n",
    temperature: 288.64,
    pressure: 1017,
    humidity: 91,
  );
  test("should be a sub class of weather entities", () async {
    expect(testWeatherModel, isA<WeatherEntity>());
  });

  test(
    "should return a valid model json result",
    () async {
      final Map<String, dynamic> jsonMap = json.decode(
        readJson("helpers/dummy_data/dummy_weather_response.json"),
      );
      final result = WeatherModel.fromJson(jsonMap);

      expect(result, equals(testWeatherModel));
    },
  );

  test(
    "should return a json map containing return proper data",
    () async {
      final expectJson = {
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
      final result = testWeatherModel.toJson();
      expect(result, expectJson);
    },
  );
}
