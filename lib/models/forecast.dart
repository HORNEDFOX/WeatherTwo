class Forecast extends Comparable{
  final DateTime date;
  final int temp;
  final String weather;

  Forecast({required this.date, required this.weather, required this.temp});

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      temp: double.parse(json['temp']['day'].toString()).toInt(),
      weather: json['weather'][0]['main'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
    );
  }

  String getIconWeather() {
    if (weather == "Clouds") {
      if (date.hour >= 6 && date.hour <= 17) {
        return "assets/images/cloud_sun.png";
      } else {
        return "assets/images/cloud_moon.png";
      }
    } else if (weather == "Snow") {
      if (date.hour >= 6 && date.hour <= 17) {
        return "assets/images/snow_sun.png";
      } else {
        return "assets/images/snow_moon.png";
      }
    } else if (weather == "Clear") {
      if (date.hour >= 6 && date.hour <= 17) {
        return "assets/images/sunny.png";
      } else {
        return "assets/images/moon.png";
      }
    } else if (weather == "Rain") {
      if (date.hour >= 6 && date.hour <= 17) {
        return "assets/images/rain_sun.png";
      } else {
        return "assets/images/rain_moon.png";
      }
    }

    return "";
  }

  void display() {
    print("Погода: $weather");
    print("Температура: $temp°C");
    print("$date");
    print("\n______________________________________________\n");
  }

  @override
  int compareTo(other) {
    if (temp < other.temp) {
      return -1;
    }

    if (temp > other.temp) {
      return 1;
    }

    return 0;
  }
}