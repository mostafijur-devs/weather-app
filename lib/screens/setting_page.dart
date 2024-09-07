import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/customwidgets/current_weather_widget.dart';
import 'package:weather_app/weather_provider.dart';

class SettingPage extends StatefulWidget {
  static const String routeName ='/setting';

  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool isOn = false;
  @override
  void didChangeDependencies() {
    context.read<WeatherProvider>().getTempStatus().then((value) {
      setState(() {
        isOn=value;
      });
    },);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFEEBCF).withOpacity(.6),
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Setting'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            value: isOn,
            onChanged: (value) async {
              setState(() {
                isOn = value;
              });
             await context.read<WeatherProvider>().setTempStatus(value);
              context.read<WeatherProvider>().getUnit(value);
              context.read<WeatherProvider>().getWeatherData();

            },
            title: Text('Show Tempereture in Fahrenheit'),
            subtitle: Text('Defualt is Celcius'),
          )
        ],
      ),
    );
  }
}
