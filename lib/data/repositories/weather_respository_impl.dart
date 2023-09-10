import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:learn_clean_architecture/core/error/expection.dart';
import 'package:learn_clean_architecture/core/error/failure.dart';
import 'package:learn_clean_architecture/data/data_sources/weather_remote_data_source.dart';
import 'package:learn_clean_architecture/domain/entities/weather.dart';
import 'package:learn_clean_architecture/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource weatherRemoteDataSource;

  const WeatherRepositoryImpl({required this.weatherRemoteDataSource});
  @override
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String city) async {
    try {
      final result = await weatherRemoteDataSource.getCurrentWeather(city);
      return Right(result.toEntitiy());
    } on ServerException {
      return const Left(ServerFailure("An error occur"));
    } on SocketException {
      return const Left(ConnectionFailure("Error Occur"));
    }
  }
}
