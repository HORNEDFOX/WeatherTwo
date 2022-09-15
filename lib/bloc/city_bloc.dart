import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/city.dart';
import '../repository/city_repository.dart';

part 'city_event.dart';
part 'city_state.dart';

class CityBloc extends Bloc<CityEvent,CityState>{

  final CityRepository _cityRepository;

  CityBloc({required CityRepository cityRepository})
      : _cityRepository = cityRepository,
        super(CityLoadingState())
  {
    on<LoadCityEvent>(_onLoadCityEvent);
  }

  Future<void> _onLoadCityEvent(LoadCityEvent event, Emitter<CityState> emit) async {
    try {
      final List<City> city = await _cityRepository.getCity();
      emit(CityLoadedState(city));
    } catch (e) {
      emit(CityErrorState(e.toString()));
    }
  }
}