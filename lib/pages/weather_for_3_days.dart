import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/widgets/forecast_card.dart';

import '../bloc/forecast_bloc.dart';
import '../repository/weather_repository.dart';
import '../widgets/toast_widget.dart';

class WeatherThreeDaysPage extends StatelessWidget {
  final SharedPreferences prefs;

  const WeatherThreeDaysPage({Key? key, required this.prefs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForecastBloc(
        weatherRepository: RepositoryProvider.of<WeatherRepository>(context),
      )..add(LoadForecastEvent(prefs.getString('city')!)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Forecast",
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
          backgroundColor: Colors.deepPurple,
          elevation: 20,
          shadowColor: Colors.deepPurple[500],
        ),
        body: Container(
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
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              BlocListener<ForecastBloc, ForecastState>(
                listener: (context, state) {
                  if (state is ForecastErrorState) {
                    showToast(context, "Ошибка получения данных");
                  }
                },
                child: BlocBuilder<ForecastBloc, ForecastState>(
                  builder: (BuildContext, state) {
                    if (state is ForecastLoadedState) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            state.forecast.sort();
                            return ForecastCard(
                                state.forecast.elementAt(index));
                          },
                        ),
                      );
                    }
                    if (state is ForecastErrorState) {
                      return Expanded(
                        child: Container(
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
                        ),
                      );
                    }
                    return Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Colors.deepPurple,
                              Colors.deepPurple,
                              Colors.deepPurpleAccent,
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
