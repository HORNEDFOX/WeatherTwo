part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable{}

class WeatherLoadingState extends WeatherState{
  @override
  List<Object?> get props => [];
}

class WeatherLoadedState extends WeatherState{
  final Weather weather;

  WeatherLoadedState(this.weather);

  @override
  List<Object?> get props => [weather];
}

class WeatherErrorState extends WeatherState{
  final String error;

  WeatherErrorState(this.error);

  @override
  List<Object?> get props => [error];
}