import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:weather/models/location.dart';

class Weather {
  final String base = "https://dsx.weather.com/wxd/v2/MORecord/pt_BR/";

  static final Weather _instance = Weather.internal();

  factory Weather() => _instance;

  Weather.internal();
  String city;
  String country;
  String icon;
  String temp;
  String status;
  String dyNght;

  Weather.fromMap(Map map) {
    city = map['city'];
    country = map['country'];
    icon = map['icon'];
    temp = map['temp'];
    status = map['status'];
    dyNght = map['dyNght'];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      "city": city,
      "country": country,
      "icon": icon,
      "temp": temp,
      "status": status,
      "dyNght": dyNght,
    };
    return map;
  }

  Future<void> fetchForecast(Location location) async {
    if (location.geocode == null) return null;

    http.Response response = await http.get(base + location.geocode);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body)['MOData'];

      temp = data['tmpC'].toString();
      status = data['wx'];
      dyNght = data['dyNght'];
      icon = handleIcon(status, dyNght);
      city = location.cityNm;
      country = location.stCd;
    }
    
  }

  String handleIcon(icons, dyNght) {

    int index;

    Map<String, List> conditions = {
      'Parcial. nublado': ['partly-cloudy','partly-cloudy-night'],
      'Chuva forte': ['storm-weather-day', 'storm-weather-night'],
      'Chuva fraca': ['rainy-day', 'rainy-night'],
      'Encoberto' : ['cloudy-weather','cloudy-weather'],
      'Nublado': ['cloudy-weather','cloudy-weather'],
      'Limpo' : ['clear-day', 'clear-night'],
      'Chuva': ['rainy-day', 'rainy-night'],
      'Ensolarado': ['clear-day','clear-day'],
      'Nevoeiro': ['haze-day', 'haze-night'],
      'Pancada de chuva': ['showcase', 'storm-weather-night']
    };

    if(dyNght == 'D') index = 0; else index = 1; 

    return conditions[icons][index] ?? 'unknown';

  }

  @override
  String toString() {
    return "Weather (icon: $icon, temp: $temp, status: $status)";
  }
}