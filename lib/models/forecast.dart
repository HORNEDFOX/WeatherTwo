class Forecast extends Comparable{
  final DateTime date; //Дата
  final int temp; //Температура
  final String weather; //Описание погоды

  //Конструктор с параметрами
  Forecast({required this.date, required this.weather, required this.temp});

  //Фабричный конструктор, принимающий json и десериализующий их
  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      temp: double.parse(json['temp']['day'].toString()).toInt(),
      weather: json['weather'][0]['main'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
    );
  }

  //Функция выбора иконки погоды согласно времени суток
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

  //Функция для сортировки списка погоды согласно температуре
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