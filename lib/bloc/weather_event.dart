part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable{
  const WeatherEvent();
}

class LoadWeatherEvent extends WeatherEvent{
  late String city;

  LoadWeatherEvent(this.city);

  @override
  List<Object> get props => [city];
}