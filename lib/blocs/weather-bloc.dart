import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:weather/models/storage.dart';
import 'dart:async';
import 'dart:convert';
import 'package:weather/models/weather.dart';
import 'package:weather/models/search.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WeatherBloc implements BlocBase {
  Search search = Search();

  var _weatherController = StreamController<String>.broadcast();
  var _weatherDNController = StreamController<String>.broadcast();
  var _searchController = StreamController<String>.broadcast();

  Stream get getLocations => _searchController.stream;
  Stream get getWeather => _weatherController.stream;
  Stream get getDayOrNight => _weatherDNController.stream;

  void main() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await Weather().fetchForecast(prefs.getStringList('location'));
    Storage().getData().then((d) {
      dayOrNight(d);
      _weatherController.add(d);
    });
  }

  void dayOrNight(data) {
    String dn = json.decode(data)['dyNght'];
    dn == 'N' ? dn = 'Night' : dn = 'Day';
    _weatherDNController.add(dn);
  }

  void input(words) async {
    String res = await search.searchLocation(words);
    _searchController.add(res);
  }

  setLocation(String location) async {
    await search.saveLocation(location);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data =
        await Weather().fetchForecast(prefs.getStringList('location'));
    _weatherController.add(data);
    dayOrNight(data);
  }

  @override
  void dispose() {
    _weatherController.close();
    _weatherDNController.close();
    _searchController.close();
  }
}
