import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/forecast.dart';

Widget ForecastCard(Forecast date) {
  return Card(
    color: Colors.transparent,
    elevation: 0,
    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
    child: Container(
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
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(
              children: [
                Text("${date.temp}°", style: const TextStyle(
                  fontSize: 50,
                  color: Colors.white,
                  fontWeight: FontWeight.w100,
                  shadows: <Shadow>[
                    Shadow(
                      color: Colors.black26,
                      offset: Offset(3, 3),
                      blurRadius: 20,
                    ),
                  ],
                ),),
                Image.asset('${date.getIconWeather()}', height: 80,),
              ],
            ),
          ),
          Text(DateFormat('dd.MM.yyyy').format(date.date), style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w100,
            shadows: <Shadow>[
              Shadow(
                color: Colors.black26,
                offset: Offset(3, 3),
                blurRadius: 20,
              ),
            ],
          ),),
        ],
      ),
    ),
  );
}