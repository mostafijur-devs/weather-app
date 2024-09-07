import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/utils/helper_functions.dart';
import 'package:weather_app/weather_models/current_weather.dart';
import 'package:weather_app/weather_provider.dart';
import '../utils/constants.dart';

class CurrentWeatherWidget extends StatelessWidget {
  const CurrentWeatherWidget({super.key, required this.currentWeather, required this.symbol });

  final CurrentWeather currentWeather;
  final String symbol;

  @override
  Widget build(BuildContext context) {
    return  Consumer<WeatherProvider>(
      builder: (context, value, child) =>Container(
        // decoration: BoxDecoration(
        //   border: Border(top:BorderSide(width: 1,color: Colors.orangeAccent))
        // ),

        child: ListView(
          children: [
            Card(
              elevation: 10,
              color: Color(0xffFCDCC2).withOpacity(.5),
              child: ListTile(
                leading: Image.asset(
                  'assets/images/sunshine.png',
                  width: 25,
                  height: 25,
                ),
                title: Text('Sun Rise'),
                trailing: Text(
                  getFormattedDataTime(value.currentWeather!.sys!.sunrise!.round(),pattern: 'hh mm a'),
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            Card(
              elevation: 5,
              color: Color(0xffFCDCC2).withOpacity(.5),
              child: ListTile(
                leading: Image.asset(
                  'assets/images/sunset.png',
                  width: 25,
                  height: 25,
                ),
                title: Text('Sun Set'),
                trailing: Text(
                  getFormattedDataTime(value.currentWeather!.sys!.sunset!.round(),pattern: 'hh mm a'),
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            Card(
              elevation: 5,
              color: Color(0xffFCDCC2).withOpacity(.5),
              child: ListTile(
                leading: Image.asset(
                  'assets/images/storm.png',
                  width: 25,
                  height: 25,
                ),
                title: Text('Wind'),
                trailing: Text(
                  '${value.currentWeather!.wind!.speed}km',
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ),
            Card(
              elevation: 5,
              color: Color(0xffFCDCC2).withOpacity(.5),
              child: ListTile(
                leading: Image.asset(
                  'assets/images/humidity.png',
                  width: 25,
                  height: 25,
                ),
                title: Text('Humidity'),
                trailing: Text(
                  '${value.currentWeather!.main!.humidity}%',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Card(
              elevation: 5,
              color: Color(0xffFCDCC2).withOpacity(.5),
              child: ListTile(
                leading: Image.asset(
                  'assets/images/rain.png',
                  width: 25,
                  height: 25,
                ),
                title: Text('Rain'),
                trailing: Text(
                  '${value.currentWeather!.main!.humidity}%',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }
}
