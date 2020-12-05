import 'package:flutter/material.dart';
import 'package:weather_app/location.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  LocationHelper locationData ;

  Future<void> getLocation() async {
    locationData = LocationHelper();
    await locationData.getCurrentLocation();
    if (locationData.latitude == null || locationData.longitude == null) {
      print("Failed to get GPS coord.");
    }
  }


  void getWeatherData(){
    // 1. Get GPS coordinates
    // 2. API call
    // 3. Json response Parsing
    // 4. Parsed to be transfered to Main Screen

  }

  @override
  void initState() {
    super.initState();
    getWeatherData();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
          child: CircularProgressIndicator(
        backgroundColor: Colors.orange,
      ),),
    );
  }
}
