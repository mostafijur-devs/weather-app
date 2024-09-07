import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/utils/helper_functions.dart';

import '../utils/constants.dart';
import '../weather_models/forecast_weather.dart';

class ForecastWeatherWidgets extends StatelessWidget {
  const ForecastWeatherWidgets(
      {super.key, required this.items, required this.symbol});

  final List<ForecastItem> items;
  final String symbol;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          elevation: 7,
          color: Color(0xffF3C8A8).withOpacity(.8),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 10,
            ),
            child: Column(
              children: [
                Text(getFormattedDataTime(item.dt!, pattern: 'EEE ')),
                Text(getFormattedDataTime(item.dt!, pattern: 'h:mm ')),
                CachedNetworkImage(
                  imageUrl: getIconUrl(item.weather!.first.icon!),
                  width: 50,
                  height: 50,
                  placeholder: (context, url) => const CircularProgressIndicator(color: Colors.blueGrey,),
                  errorWidget: (context, url, error) => const Icon(Icons.error,size: 40,),
                ),
                Text("${item.main!.temp!.round()}$degree")
              ],
            ),
          ),
        );
      },
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:weather_app/utils/helper_functions.dart';
//
// import '../weather_models/forecast_weather.dart';
//
// class ForecastWeatherView extends StatelessWidget {
//   const ForecastWeatherView({
//     super.key,
//     required this.items,
//     required this.symbol,
//   });
//
//   final List<ForecastItem> items;
//   final String symbol;
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 200.0,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: items.length,
//         itemBuilder: (context, index) {
//           final item = items[index];
//           return Card(
//             color: Colors.black45,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 children: [
//                   Text(getFormattedDataTime(item.dt!, pattern: 'EEE hh:mm a')),
//                   Image.network(getIconUrl(item.weather!.first.icon!), width: 40, height: 40,),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
