import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_clean_architecture/domain/entities/weather.dart';
import 'package:learn_clean_architecture/domain/repositories/weather_repository.dart';
import 'package:learn_clean_architecture/domain/usecases/get_current_weather.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_current_weather_test.mocks.dart';

@GenerateMocks([WeatherRepository])
void main() {
  late GetCurrentWeatherUseCase getCurrentWeatherUseCase;
  late MockWeatherRepository mockWeatherRepository;

  setUp(
    () {
      mockWeatherRepository = MockWeatherRepository();
      getCurrentWeatherUseCase =
          GetCurrentWeatherUseCase(mockWeatherRepository);
    },
  );

  const testCityName = "NewYork";

  const testWeatherDetail = WeatherEntity(
    cityName: testCityName,
    main: "NY",
    description: "This is Description",
    iconCode: "hii",
    temperature: 12,
    pressure: 20,
    humidity: 20,
  );
  test(
    "should get current weather detail from the repository",
    () async {
      when(mockWeatherRepository.getCurrentWeather(testCityName)).thenAnswer(
        (realInvocation) async => const Right(testWeatherDetail),
      );

      final result = await getCurrentWeatherUseCase.execute(testCityName);

      expect(result, const Right(testWeatherDetail));
    },
  );
}
