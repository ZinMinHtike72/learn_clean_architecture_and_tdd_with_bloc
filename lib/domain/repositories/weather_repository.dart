import 'package:dartz/dartz.dart';
import 'package:learn_clean_architecture/core/error/failure.dart';
import 'package:learn_clean_architecture/domain/entities/weather.dart';

abstract class WeatherRepository {
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String city);
}
