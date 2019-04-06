import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:weather/utils/storage.dart';
import 'dart:async';

class WeatherController implements BlocBase {

  String weatherData;
  String geoCode;

  WeatherController() {
    update();
  }

  var _wController = StreamController<String>();

  Stream<String> get getWeather => _wController.stream;
  Sink<String> get setWeather => _wController.sink;


  void update() {
    Storage().readFile().then( (data){
      setWeather.add(data);
    });
  }

  @override
  void dispose() {
    _wController.close();
  }


}