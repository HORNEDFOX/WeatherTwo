part of 'city_bloc.dart';

abstract class CityEvent extends Equatable{
  const CityEvent();
}

class LoadCityEvent extends CityEvent{
  @override
  List<Object> get props => [];
}