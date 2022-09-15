import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/weather.dart';
import '../repository/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent,WeatherState>{

  final WeatherRepository _weatherRepository;

  WeatherBloc({required WeatherRepository weatherRepository})
      : _weatherRepository = weatherRepository,
        super(WeatherLoadingState())
  {
    on<LoadWeatherEvent>(_onLoadWeatherEvent);
  }

  Future<void> _onLoadWeatherEvent(LoadWeatherEvent event, Emitter<WeatherState> emit) async {
    try {
      final Weather weather = await _weatherRepository.getCurrentWeather(event.city);
      emit(WeatherLoadedState(weather));
    } catch (e) {
      emit(WeatherErrorState(e.toString()));
    }
  }
}