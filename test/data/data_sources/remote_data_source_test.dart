
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:learn_clean_architecture/core/constatnt/constant.dart';
import 'package:learn_clean_architecture/core/error/expection.dart';
import 'package:learn_clean_architecture/data/data_sources/weather_remote_data_source.dart';
import 'package:learn_clean_architecture/data/models/weather_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/json_reader.dart';
import 'remote_data_source_test.mocks.dart';

//!Api Testing
@GenerateMocks([], customMocks: [MockSpec<http.Client>(as: #MockHttpClient)])
void main() {
  late MockHttpClient mockHttpClient;
  late WeatherRemoteDataSourceImpl weatherRemoteDataSourceImpl;

  setUp(
    () {
      mockHttpClient = MockHttpClient();
      weatherRemoteDataSourceImpl =
          WeatherRemoteDataSourceImpl(client: mockHttpClient);
    },
  );

  group(
    "get current weather",
    () {
      test('should return weather model when  response code is 200', () async {
        //arrange
        when(
          mockHttpClient.get(
            Uri.parse(
              Urls.currentWeatherByName("London"),
            ),
          ),
        ).thenAnswer(
          (_) async => http.Response(
              readJson("helpers/dummy_data/dummy_weather_response.json"), 200),
        );
        //act

        final actualData =
            await weatherRemoteDataSourceImpl.getCurrentWeather("London");

        //assert
        expect(actualData, isA<WeatherModel>());
      });
      test('should throw server exception when response code is 404', () async {
        // Arrange
        when(
          mockHttpClient.get(
            Uri.parse(
              Urls.currentWeatherByName("New York"),
            ),
          ),
        ).thenAnswer(
          (_) async => http.Response(
              "Not Found", 404), // Corrected response code and message
        );
        // Act
        final actual =
            weatherRemoteDataSourceImpl.getCurrentWeather("New York");

        // Assert
        expect(
          actual,
          throwsA(isA<ServerException>()),
        );
      });
    },
  );
}
