import 'package:flutter/material.dart';
import 'package:weather_app/location.dart';
import 'package:weather_app/mainScreen.dart';
import 'package:weather_app/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  LocationHelper locationData;

  Future<void> getLocation() async {
    locationData = LocationHelper();
    await locationData.getCurrentLocation();
    if (locationData.latitude == null || locationData.longitude == null) {
      print("Failed to get GPS coord.");
    }
  }

  Future<void> getWeatherData() async {
    // 1. Get GPS coordinates
    // 2. API call
    // 3. Json response Parsing
    // 4. Parsed to be transfered to Main Screen

    // Use alt+enter in case of errors
    await getLocation();
    WeatherData weatherData = WeatherData(locationData: locationData);
    await weatherData.getCurrentTemperature();

    if (weatherData.currentTemperature == null ||
        weatherData.currentCondition == null) {
      // todo: Handle no weather
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return MainScreen(weatherData: weatherData,);
        },
      ),
    );
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
        ),
      ),
    );
  }
}
