import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/pages/city.dart';
import 'package:weather/pages/weather_for_3_days.dart';
import 'package:weather/widgets/details_weather.dart';

import '../bloc/weather_bloc.dart';
import '../repository/weather_repository.dart';
import '../widgets/toast_widget.dart';

class WeatherPage extends StatelessWidget {
  final SharedPreferences prefs;
  final snackBar = SnackBar(
    content: const Text('Yay! A SnackBar!'),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );

  WeatherPage({Key? key, required this.prefs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Weather",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w300,
            letterSpacing: 1,
            shadows: <Shadow>[
              Shadow(
                color: Colors.black26,
                offset: Offset(3, 3),
                blurRadius: 20,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          SizedBox(
            width: 40,
            child: InkWell(
              splashColor: Colors.transparent,
              child: const Icon(
                Icons.location_city_rounded,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CityPage()),
                );
              },
            ),
          ),
          SizedBox(
            width: 40,
            child: InkWell(
              splashColor: Colors.transparent,
              child: const Icon(
                Icons.wb_cloudy,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WeatherThreeDaysPage(
                            prefs: prefs,
                          )),
                );
              },
            ),
          ),
        ],
        elevation: 20,
        shadowColor: Colors.deepPurple[500],
        backgroundColor: Colors.deepPurple,
      ),
      body: BlocProvider(
        create: (context) => WeatherBloc(
          weatherRepository: RepositoryProvider.of<WeatherRepository>(context),
        )..add(LoadWeatherEvent(prefs.getString('city')!)),
        child: BlocListener<WeatherBloc, WeatherState>(
          listener: (context, state) {
            if (state is WeatherErrorState) {
              showToast(context, "Ошибка получения данных");
            }
          },
          child:
              BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
            if (state is WeatherLoadedState) {
              return Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                      Colors.deepPurple,
                      Colors.deepPurple,
                      Colors.deepPurpleAccent,
                    ])),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "${state.weather.getIconWeather()}",
                              height: 160,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "${state.weather.temp}°",
                                    style: const TextStyle(
                                      fontSize: 84,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w100,
                                      shadows: <Shadow>[
                                        Shadow(
                                          color: Colors.black26,
                                          offset: Offset(3, 3),
                                          blurRadius: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius: BorderRadius.circular(100),
                                      boxShadow: const <BoxShadow>[
                                        BoxShadow(
                                          color: Colors.black12,
                                          offset: Offset(3, 3),
                                          blurRadius: 20,
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      state.weather.weather,
                                      style: const TextStyle(
                                        letterSpacing: 1,
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 44,
                      ),
                      DetailsWeather(
                        weather: state.weather,
                      ),
                    ],
                  ),
                ),
              );
            }
            if (state is WeatherErrorState) {
              return Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                      Colors.deepPurple,
                      Colors.deepPurple,
                      Colors.deepPurpleAccent,
                    ])),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: const Center(
                  child: Text(
                    "Ошибка получения данных",
                    style: TextStyle(
                      letterSpacing: 1,
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              );
            }
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                    Colors.deepPurple,
                    Colors.deepPurple,
                    Colors.deepPurpleAccent,
                  ])),
            );
          }),
        ),
      ),
    );
  }
}
