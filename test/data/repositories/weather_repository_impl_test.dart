import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_clean_architecture/core/error/expection.dart';
import 'package:learn_clean_architecture/core/error/failure.dart';
import 'package:learn_clean_architecture/data/data_sources/weather_remote_data_source.dart';
import 'package:learn_clean_architecture/data/models/weather_model.dart';
import 'package:learn_clean_architecture/data/repositories/weather_respository_impl.dart';
import 'package:learn_clean_architecture/domain/entities/weather.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'weather_repository_impl_test.mocks.dart';

//!impl testing
@GenerateMocks([WeatherRemoteDataSource])
void main() {
  late MockWeatherRemoteDataSource mockWeatherRemoteDataSource;
  late WeatherRepositoryImpl weatherRepositoryImpl;

  setUp(() {
    mockWeatherRemoteDataSource = MockWeatherRemoteDataSource();
    weatherRepositoryImpl = WeatherRepositoryImpl(
        weatherRemoteDataSource: mockWeatherRemoteDataSource);
  });

  const testCityName = "New York";

  final testWeatherModel = WeatherModel(
    cityName: "New York",
    main: "Clouds",
    description: "few clouds",
    iconCode: "02d",
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  final testWeatherEntity = WeatherEntity(
    cityName: "New York",
    main: "Clouds",
    description: "few clouds",
    iconCode: "02d",
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  group(
    "get currrent weather",
    () {
      test(
        "should return current weather entity when a call to datasource is successful!",
        () async {
          //arrange
          when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
              .thenAnswer(
            (_) async => testWeatherModel,
          );
          //act
          final result =
              await weatherRepositoryImpl.getCurrentWeather(testCityName);
          //assert
          expect(result, equals(Right(testWeatherEntity)));
        },
      );

      test(
        "should return server failure  when a call to data source is unsuccessful!",
        () async {
          //arrange
          when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
              .thenThrow(ServerException());
          //act
          final result =
              await weatherRepositoryImpl.getCurrentWeather(testCityName);
          //assert
          expect(
            result,
            equals(
              const Left(
                ServerFailure("An error occur"),
              ),
            ),
          );
        },
      );

      test(
        "should return connection failure when device have no internet !",
        () async {
          //arrange
          when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
              .thenThrow(
            const SocketException("Error Occur"),
          );
          //act
          final result =
              await weatherRepositoryImpl.getCurrentWeather(testCityName);

          //assert
          expect(
            result,
            equals(
              const Left(
                ConnectionFailure("Error Occur"),
              ),
            ),
          );
        },
      );
    },
  );
}
