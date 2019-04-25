import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:weather/models/location.dart';
import 'package:weather/models/weather.dart';
import 'package:weather/models/search.dart';
import 'dart:async';

class WeatherBloc implements BlocBase {

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
    await weather.fetchForecast(location);
    dayOrNight(weather);
    _weatherController.add(weather);
  }

  void dayOrNight(Weather w) {
    _weatherDNController.add(w.dyNght);
  }

  void input(words) async {
    String res = await search.searchLocation(words);
    _searchController.add(res);
  }

  setLocation(Map newLocation) async {
    location.fromMap(newLocation);
    location.setStoredLocation();
  }

  @override
  void dispose() {
    _weatherController.close();
    _weatherDNController.close();
    _searchController.close();
  }
}
