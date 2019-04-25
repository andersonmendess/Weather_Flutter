import 'package:weather/models/location.dart';
import 'package:weather/models/weather.dart';
import 'package:weather/models/search.dart';
import 'dart:async';

class WeatherBloc {

  static final WeatherBloc _bloc = new WeatherBloc._internal();
  factory WeatherBloc(){
    return _bloc;
  }
  WeatherBloc._internal();

  Search search = Search();
  Location location = Location();
  Weather weather = Weather();

  var _weatherController = StreamController<Weather>.broadcast();
  var _weatherDNController = StreamController<String>.broadcast();
  var _searchController = StreamController<String>.broadcast();

  Stream get getLocations => _searchController.stream;
  Stream get getWeather => _weatherController.stream;
  Stream get getDayOrNight => _weatherDNController.stream;

  void main() async {
    await location.getStoredLocation();
    await weatherStart(location);
  }

  Future<void> weatherStart(location) async {
    await weather.fetchForecast(location);
    _weatherController.add(weather);
    dayOrNight();
  }

  void dayOrNight() {
    _weatherDNController.add(weather.dyNght);
  }

  void input(words) async {
    String res = await search.searchLocation(words);
    _searchController.add(res);
  }

  setLocation(Map newLocation) async {
    location.fromMap(newLocation);
    location.setStoredLocation();
    await weatherStart(location);
  }

  void dispose() {
    _weatherController.close();
    _weatherDNController.close();
    _searchController.close();
  }
}
