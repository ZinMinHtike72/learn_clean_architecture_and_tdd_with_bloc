import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_clean_architecture/core/error/failure.dart';
import 'package:learn_clean_architecture/domain/entities/weather.dart';
import 'package:learn_clean_architecture/domain/usecases/get_current_weather.dart';
import 'package:learn_clean_architecture/presentation/bloc/weather_bloc.dart';
import 'package:learn_clean_architecture/presentation/bloc/weather_event.dart';
import 'package:learn_clean_architecture/presentation/bloc/weather_state.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';

import 'weather_bloc_test.mocks.dart';

@GenerateMocks(
  [
    GetCurrentWeatherUseCase,
  ],
)
void main() {
  late MockGetCurrentWeatherUseCase mockGetCurrentWeatherUseCase;

  setUp(() {
    mockGetCurrentWeatherUseCase = MockGetCurrentWeatherUseCase();
  });

  late WeatherBloc weatherBloc;

  setUp(() {
    mockGetCurrentWeatherUseCase = MockGetCurrentWeatherUseCase();
    weatherBloc = WeatherBloc(mockGetCurrentWeatherUseCase);
  });

  const testWeatherModel = WeatherEntity(
    cityName: "London",
    main: "Clear",
    description: "clear sky",
    iconCode: "01n",
    temperature: 288.64,
    pressure: 1017,
    humidity: 91,
  );

  const testCityName = 'New York';
  test(
    "initial state should be empty",
    () {
      expect(weatherBloc.state, WeatherEmpty());
    },
  );

  blocTest<WeatherBloc, WeatherState>(
    'should emits [WeatherLoading,WeatherLoades] when data is gotten successful!',
    build: () {
      when(mockGetCurrentWeatherUseCase.execute(testCityName)).thenAnswer(
        (_) async => const Right(testWeatherModel),
      );

      return weatherBloc;
    },
    act: (bloc) => bloc.add(const OnCityChanged(testCityName)),
    wait: const Duration(milliseconds: 500),
    expect: () => [WeatherLoading(), const WeatherLoaded(testWeatherModel)],
  );

  blocTest<WeatherBloc, WeatherState>(
    'should emits [WeatherLoading,WeatherFailure] when data is gotten unsuccessful!',
    build: () {
      when(mockGetCurrentWeatherUseCase.execute(testCityName)).thenAnswer(
        (_) async => const Left(ServerFailure("Server Failure")),
      );

      return weatherBloc;
    },
    act: (bloc) => bloc.add(const OnCityChanged(testCityName)),
    wait: const Duration(milliseconds: 500),
    expect: () =>
        [WeatherLoading(), const WeatherLoadFailure("Server Failure")],
  );
}
