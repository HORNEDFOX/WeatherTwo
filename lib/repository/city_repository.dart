import 'package:weather/models/city.dart';
import '../services/city_services.dart';

class CityRepository {
  final CityService _cityService = CityService();

  Future<List<City>> getCity() => _cityService.getCity();
}