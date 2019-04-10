import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:weather/models/storage.dart';
import 'dart:async';
import 'package:weather/models/weather.dart';

class HomeBloc implements BlocBase {

  HomeBloc(){
     Storage().getDataW().then((e){
      print(e);
      _weatherController.add(e);
    });
  }

  var _weatherController = StreamController<String>();

  Stream get getWeather => _weatherController.stream;

  @override
  void dispose() {
    _weatherController.close();
  }
}