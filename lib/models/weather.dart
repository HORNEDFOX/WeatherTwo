import 'package:weather/models/forecast.dart';

class Weather extends Forecast{
  final String city;
  final String country;
  final int humidity;
  final int windSpeed;
  final int wind;
  final int pressure;

  Weather({required String weather, required int temp, required DateTime date, required this.city, required this.country, required this.humidity, required this.windSpeed, required this.wind, required this.pressure}) : super(weather: weather, temp: temp, date: date);

  @override
  factory Weather.fromJson(Map<String, dynamic> json){
    return Weather(
      city: json['name'],
      country: json['sys']['country'],
      temp: double.parse(json['main']['temp'].toString()).toInt(),
      weather: json['weather'][0]['main'] as String,
      humidity: json['main']['humidity'] as int,
      windSpeed: double.parse(json['wind']['speed'].toString()).toInt(),
      wind: json['wind']['deg'] as int,
      pressure: json['main']['pressure'] as int,
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
    );
  }

  String windDirection()
  {
    if(wind == 360 || wind == 0)
    {
      return "N";
    }else if(wind > 0 && wind < 90)
    {
      return "NE";
    }else if(wind ==  90)
    {
      return "E";
    }else if(wind > 90 && wind < 180)
    {
      return "SE";
    }else if(wind == 180)
    {
      return "S";
    }else if(wind > 180 && wind < 270)
    {
      return "SW";
    }else if(wind == 270)
    {
      return "W";
    }else if(wind > 270 && wind < 360)
    {
      return "NW";
    }
    return "No data";
  }

  @override
  void display()
  {
    print("Город: $city");
    print("Страна: $country");
    print("Погода: $weather");
    print("Температура: $temp°C");
    print("Влажность: $humidity%");
    print("Скорость ветра: $windSpeed km/h");
    print("Градусы: $wind");
    print("Направление ветра: " + windDirection());
    print("Атмосферное давление: $pressure hPA");
    print("\n______________________________________________\n");
  }
}