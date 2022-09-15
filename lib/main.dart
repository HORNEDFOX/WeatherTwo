import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/pages/city.dart';
import 'package:weather/pages/weather.dart';
import 'package:weather/repository/city_repository.dart';
import 'package:weather/repository/weather_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var city = prefs.getString('city');
  runApp(
    RepositoryProvider(
      create: (context) => CityRepository(),
      child: RepositoryProvider(
        create: (context) => WeatherRepository(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: city == null ? CityPage() : WeatherPage(prefs: prefs),
        ),
      ),
    ),
  );
}
