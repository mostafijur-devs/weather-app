import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/screens/setting_page.dart';
import 'package:weather_app/screens/weather_home_page.dart';
import 'package:weather_app/screens/weather_login_page.dart';
import 'package:weather_app/weather_provider.dart';

void main (){
  //You only need to call this method
  // if you need the binding to be initialized before calling runApp.
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp //screens fixed the portrait mode
  ]);
  runApp(ChangeNotifierProvider(
    create: (context) => WeatherProvider(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Weather app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.dark
        ),
        useMaterial3: true,
      ),
      // home: const WeatherLoginPage(),
      initialRoute: WeatherHomePage.routeName,
      routes: {
        WeatherLoginPage.routeName : (context)=> WeatherLoginPage(),
        WeatherHomePage.routeName : (context) => WeatherHomePage(),
        SettingPage.routeName : (context) => SettingPage()
      },
    );
  }
}
