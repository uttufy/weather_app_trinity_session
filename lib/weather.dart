import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'location.dart';

class WeatherDisplayData {
  Icon weatherIcon;
  AssetImage weatherImage;

  WeatherDisplayData({@required this.weatherIcon, @required this.weatherImage});
}

class WeatherData {
  WeatherData({@required this.locationData});

  LocationHelper locationData;
  double currentTemperature;
  int currentCondition;

  Future<void> getCurrentTemperature() async {
    Response response = await get(
        'http://api.openweathermap.org/data/2.5/weather?lat=${locationData.latitude}&lon=${locationData.longitude}&appid=59d473b5185d6137e0b852f2cb72dd8b&units=metric');

    if (response.statusCode == 200) {
      String data = response.body;
      var currentWeather = jsonDecode(data);

      try {
        currentTemperature = currentWeather['main']['temp'].toDouble();
        currentCondition = currentWeather['weather'][0]['id'];
      } catch (e) {
        print(e);
      }
    } else {
      print('Could not fetch temperature!');
    }
  }

  WeatherDisplayData getWeatherDisplayData() {
    if (currentCondition < 600) {
      return WeatherDisplayData(
        weatherIcon: Icon(Icons.cloud),
        weatherImage: AssetImage('asset/cloud.jpg'),
      );
    } else {
      var now = new DateTime.now();

      if (now.hour >= 15) {
        return WeatherDisplayData(
          weatherImage: AssetImage('asset/night.jpg'),
          weatherIcon: Icon(Icons.motion_photos_on_outlined),
        );
      } else {
        return WeatherDisplayData(
          weatherIcon: Icon(Icons.flash_auto),
          weatherImage: AssetImage('asset/sunny.jpg'),
        );
      }
    }
  }
}
