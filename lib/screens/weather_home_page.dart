import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/customwidgets/app_background.dart';
import 'package:weather_app/customwidgets/current_weather_widget.dart';
import 'package:weather_app/customwidgets/forecast_weather_widgets.dart';
import 'package:weather_app/screens/setting_page.dart';
import '../utils/constants.dart';
import '../utils/helper_functions.dart';
import '../weather_provider.dart';

// @override
// void initState() {
//   context.read<WeatherProvider>().determinePosition().then(
//     (value) {
//       context.read<WeatherProvider>().getWeatherData();
//     },
//   );
//   // TODO: implement initState
// }

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({super.key});
  static const String routeName = '/home';

  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  late StreamSubscription<List<ConnectivityResult>> subscription;
  bool isConnected = true;

  Future<void> getData ( ) async{
    if( await isConnectivityInternet()){
      await  context.read<WeatherProvider>().determinePosition();
      final stutas = await context.read<WeatherProvider>().getTempStatus();
      context.read<WeatherProvider>().getUnit(stutas);
      context.read<WeatherProvider>().getWeatherData();
    }
    else{
      setState(() {
        isConnected = false;
      });
    }
  }
  Future<bool> isConnectivityInternet () async {
    final result = await Connectivity().checkConnectivity();
    return result.contains(ConnectivityResult.mobile) || result.contains(ConnectivityResult.wifi);

  }

  @override
  void didChangeDependencies() {
    subscription = Connectivity().onConnectivityChanged.listen((result) {
      if(result.contains(ConnectivityResult.wifi) || result.contains(ConnectivityResult.mobile)){
        setState(() {
          isConnected = true;
          getData();
          context.read<WeatherProvider>().getWeatherData();

        });
      }
      else {
        setState(() {
          isConnected = false;
        });
      }
    },);
    getData();
    super.didChangeDependencies();
  }
  // bool isConnected = true;
  @override
  Widget build(BuildContext context) {

    context.read<WeatherProvider>().getWeatherData();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Text('Weather App'),
        ),
        actions: [
          IconButton(onPressed: () {
            getData();

          }, icon: Icon(Icons.location_on)),
          IconButton(onPressed: () {
            showSearch(context: context,
                delegate: _countrySearchDelegated())
                .then((value) async {
                  if (value != null && value.isNotEmpty) {
                    await context.read<WeatherProvider>().convertCityToAddress(value);
                    context.read<WeatherProvider>().getWeatherData();
                  }
            },);

          }, icon: Icon(Icons.search_sharp)),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, SettingPage.routeName),
            icon: Icon(Icons.settings),
          )
        ],
      ),
      body: Consumer<WeatherProvider>(
          builder: (context, value, child) => value.hasDataLoaded
              ? Stack(
                  children: [
                    AppBackground(),

                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 20, bottom: 5),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [

                              Expanded(
                                flex: 10,
                                child: CurrentWeatherWidget(
                                  currentWeather: value.currentWeather!,
                                  symbol: degree,
                                )),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Today weather'),
                                  TextButton(
                                      onPressed: () {},
                                      child: Text('More forecast weather -->'))
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: ForecastWeatherWidgets(
                                items: value.forecastWeather!.list!,
                                symbol: value.unitSymbol,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    if(!isConnected) Container(
                        height: double.infinity,
                        width: double.infinity,
                        color: Colors.black.withOpacity(0.7),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Container(
                              width: double.infinity,
                              height: 30,
                              color: Colors.black.withOpacity(0.5),
                              child: Center(
                                child: Text('Internet connection is failed',style:
                                TextStyle(color: Colors.white),),
                              ),
                            ),
                          ),
                        )),
                  ],
                )

   : Center(child: isConnected ? const CircularProgressIndicator()
          : const Text('Internet is not connected'))),
    );
  }
  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}

class _countrySearchDelegated extends SearchDelegate<String>{
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () {
        query = '';

      }, icon: Icon(Icons.clear)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
   return
     IconButton(onPressed: () {
       close(context, query);

     }, icon: Icon(Icons.arrow_back));

  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return ListTile();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final filteredList = query.isEmpty ? countriesName :
        countriesName.where((country) =>country.toLowerCase().startsWith(query.toLowerCase()),).toList();
    return ListView.builder(
      itemCount: filteredList.length,
      itemBuilder: (context, index) {
        final country = filteredList[index];
        return ListTile(
          title: Text(country),
          onTap: () {
            close(context, country);
          },
        );

    },);
  }
}
