import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:weather/models/city.dart';

class CityService {
  Future<List<City>> getCity() async {
    final String response =
        await rootBundle.loadString('assets/city.list.json');
    final jsonData = await json.decode(response);
    final List<City> data = (jsonData as List<dynamic>).map((item) {
      return City.fromJson(item);
    }).toList();
    return data;
  }
}
