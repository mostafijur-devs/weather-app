import 'package:flutter/material.dart';
import 'package:weather_app/screens/weather_home_page.dart';

class WeatherLoginPage extends StatelessWidget {
  const WeatherLoginPage({super.key});
  static const String routeName ='/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xFFFEEBCF).withOpacity(.8),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 150,
            ),
            // Image.asset('assets/images/login.png',height: 200,width: 200,),
            Container(
             decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            // Set the shadow for the container
              boxShadow: [
              BoxShadow(
                color: Color(0xFFFEEBCF).withOpacity(.6), // Shadow color
                spreadRadius: 20, // How much the shadow should spread
                blurRadius: 35, // How blurry the shadow should be
                offset: Offset(0, 3), // X and Y offset
              ),
            ],
          ),
          // Image Widget
          child: Image.asset(
            'assets/images/login.png',
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
            Spacer(),
            Text('Weather',style: TextStyle(fontSize: 70,fontWeight:FontWeight.w700 ),),
            Text('Forecasts',style: TextStyle(fontSize: 70,fontWeight:FontWeight.w700 ),),
            Text('Get real-time weather updates anytime, anywhere ',style: TextStyle(fontSize: 25,fontWeight:FontWeight.w700 ),),
            // Text('Weather',style: TextStyle(fontSize: 70,fontWeight:FontWeight.w700 ),),
            // Text('Weather',style: TextStyle(fontSize: 70,fontWeight:FontWeight.w700 ),),
            ElevatedButton(onPressed: () {
            Navigator.pushNamed(context, WeatherHomePage.routeName);
            }, child: Container(height: 50,
                width: double.infinity,
                child: Center(child: Text('Get Starts')))),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),

    );
  }
}
