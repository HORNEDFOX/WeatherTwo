import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/forecast.dart';
import '../repository/weather_repository.dart';

part 'forecast_event.dart';
part 'forecast_state.dart';

class ForecastBloc extends Bloc<ForecastEvent,ForecastState>{

  final WeatherRepository _weatherRepository;

  ForecastBloc({required WeatherRepository weatherRepository})
      : _weatherRepository = weatherRepository,
        super(ForecastLoadingState())
  {
    on<LoadForecastEvent>(_onLoadForecastEvent);
  }

  Future<void> _onLoadForecastEvent(LoadForecastEvent event, Emitter<ForecastState> emit) async {
    try {
      final List<Forecast> forecast = await _weatherRepository.getForecast(event.city);
      emit(ForecastLoadedState(forecast));
    } catch (e) {
      emit(ForecastErrorState(e.toString()));
    }
  }
}