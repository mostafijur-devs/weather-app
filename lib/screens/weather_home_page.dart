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

class WeatherHomePage extends StatelessWidget {
  const WeatherHomePage({super.key});
  static const String routeName = '/home';

  Future<void> getData (BuildContext context) async{
   await  context.read<WeatherProvider>().determinePosition();
   final stutas = await context.read<WeatherProvider>().getTempStatus();
   context.read<WeatherProvider>().getUnit(stutas);
   context.read<WeatherProvider>().getWeatherData();
  }

  // bool isConnected = true;
  @override
  Widget build(BuildContext context) {
    getData(context);
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
            getData(context);

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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${value.currentWeather!.name} , ${value.currentWeather!.sys?.country}',
                                  style: TextStyle(fontSize: 30),
                                ),
                                Text(
                                  getFormattedDataTime(
                                      value.currentWeather!.dt!),
                                  style: TextStyle(fontSize: 20),
                                ),
                                Row(
                                  children: [
                                    Image.network(
                                      getIconUrl(
                                        value.currentWeather!.weather!.first
                                            .icon!,
                                      ),
                                      height: 170,
                                      width: 170,
                                      fit: BoxFit.fill,
                                      color: Colors.cyan,
                                    ),
                                    Expanded(
                                      child: Text(
                                        '${value.currentWeather!.main!.temp!.round()}$degree${value.unitSymbol}',
                                        style: TextStyle(fontSize: 70),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Expanded(
                                flex: 2,
                                child: CurrentWeatherWidget(
                                  currentWeather: value.currentWeather!,
                                  symbol: degree,
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Today weather'),
                                TextButton(
                                    onPressed: () {},
                                    child: Text('More forecast weather -->'))
                              ],
                            ),
                            Expanded(
                              child: ForecastWeatherWidgets(
                                items: value.forecastWeather!.list!,
                                symbol: value.unitSymbol,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )

   : Center(child: CircularProgressIndicator())),
    );
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
