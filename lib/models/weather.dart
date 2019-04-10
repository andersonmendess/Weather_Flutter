import 'dart:convert';
import 'package:weather/models/storage.dart';
import 'package:http/http.dart' as http;

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

  Weather.fromMap(Map map) {
    city = map['city'];
    country = map['country'];
    icon = map['icon'];
    temp = map['temp'];
    status = map['status'];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      "city": city,
      "country": country,
      "icon": icon,
      "temp": temp,
      "status": status,
    };
    return map;
  }

  Future<void> fetchForecast(List location) async {
    if (location[0] == null) return;

    http.Response response = await http.get(base + location[0]);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body)['MOData'];

      temp = data['tmpC'].toString();
      status = data['wx'];
      icon = handleIcon(status);
      city = location[1];
      country = location[2];
      print(location);

      await Storage().saveData(Weather());
    }
  }

  String handleIcon(icons) {
    switch (icons) {
      case 'Parcial. nublado':
        return 'partly_cloudy';
        break;
      case 'Chuva forte':
        return 'rain_heavy';
        break;
      case 'Chuva fraca':
        return 'rain_light';
        break;
      case 'Encoberto':
        return 'partly_cloudy';
        break;
      case 'Nublado':
        return 'cloudy';
        break;
      case 'Limpo':
        return 'partly_cloudy';
        break;
      case 'Chuva':
        return 'rain_heavy';
        break;
      case 'Ensolarado':
        return 'sunny';
        break;
      case 'Nevoeiro':
        return 'fog';
        break;
      case 'Pancada de chuva':
        return 'rainy-weather';
        break;
      default:
        return 'unknown';
    }
  }

  @override
  String toString() {
    return "Weather (icon: $icon, temp: $temp, status: $status)";
  }
}