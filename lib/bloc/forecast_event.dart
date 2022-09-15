part of 'forecast_bloc.dart';

abstract class ForecastEvent extends Equatable{
  const ForecastEvent();
}

class LoadForecastEvent extends ForecastEvent{
  late String city;

  LoadForecastEvent(this.city);

  @override
  List<Object> get props => [city];
}