part of 'forecast_bloc.dart';

abstract class ForecastState extends Equatable{}

class ForecastLoadingState extends ForecastState{
  @override
  List<Object?> get props => [];
}

class ForecastLoadedState extends ForecastState{
  final List<Forecast> forecast;

  ForecastLoadedState(this.forecast);

  @override
  List<Object?> get props => [forecast];
}

class ForecastErrorState extends ForecastState{
  final String error;

  ForecastErrorState(this.error);

  @override
  List<Object?> get props => [error];
}