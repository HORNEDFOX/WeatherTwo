import '../models/forecast.dart';
import '../models/weather.dart';
import '../services/weather_service.dart';

class WeatherRepository {
  final WeatherService _weatherService = WeatherService();

  Future<Weather> getCurrentWeather(String city) =>
      _weatherService.fetchCurrentWeather(city);

  Future<List<Forecast>> getForecast(String city) =>
      _weatherService.fetchHourlyWeather(city);
}