import 'package:weather/models/weather.dart';
import 'package:weather/models/forecast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  String _apiKey = "d8313d90053c823b1fb6d1376a458e11";
  String _apiKeyForecast = '1369dd6b5ae78fc9952261ab9aa236b4';

  Future<Weather> fetchCurrentWeather(String city) async {
    var url =
        'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$_apiKey&units=metric';
    final response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather');
    }
  }

  Future<List<Forecast>> fetchHourlyWeather(String city) async {
    var url =
        'http://api.openweathermap.org/data/2.5/forecast/daily?q=$city&cnt=3&appid=$_apiKeyForecast&units=metric';
    final response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<Forecast> data = (jsonData['list'] as List<dynamic>).map((item) {
          return Forecast.fromJson(item);
      }).toList();
      return data;
    } else {
      throw Exception('Failed to load weather');
    }
  }
}