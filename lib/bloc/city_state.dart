part of 'city_bloc.dart';

abstract class CityState extends Equatable{}

class CityLoadingState extends CityState{
  @override
  List<Object?> get props => [];
}

class CityLoadedState extends CityState{
  final List<City> city;

  CityLoadedState(this.city);

  @override
  List<Object?> get props => [city];
}

class CityErrorState extends CityState{
  final String error;

  CityErrorState(this.error);

  @override
  List<Object?> get props => [error];
}