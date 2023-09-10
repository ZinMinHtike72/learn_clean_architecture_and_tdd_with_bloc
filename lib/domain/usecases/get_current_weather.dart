import 'package:dartz/dartz.dart';
import 'package:learn_clean_architecture/core/error/failure.dart';
import 'package:learn_clean_architecture/domain/entities/weather.dart';
import 'package:learn_clean_architecture/domain/repositories/weather_repository.dart';

class GetCurrentWeatherUseCase {
  final WeatherRepository weatherRepository;

  GetCurrentWeatherUseCase(this.weatherRepository);
  Future<Either<Failure, WeatherEntity>> execute(String cityName) async {
    return weatherRepository.getCurrentWeather(cityName);
  }
}
