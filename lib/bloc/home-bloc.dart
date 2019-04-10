import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:weather/models/storage.dart';
import 'dart:async';
import 'package:weather/models/weather.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeBloc implements BlocBase {
  HomeBloc(){
    updateHomeWeather();
    main();
  }

  void main() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await Weather().fetchForecast(prefs.getStringList('location'));
  }

  var _weatherController = StreamController<String>.broadcast();

  Stream get getWeather => _weatherController.stream;

  void updateHomeWeather() {
    Storage().getData().then((d){
      _weatherController.add(d);
    });
  }

  @override
  void dispose() {
    _weatherController.close();
  }
}
