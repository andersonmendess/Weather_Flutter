import 'package:bloc_pattern/bloc_pattern.dart';
import 'dart:convert';
import 'dart:async';
import 'package:weather/models/search.dart';
import 'package:weather/models/weather.dart';

class SearchBloc implements BlocBase {

  Search search = Search();

  Weather weather;

  SearchBloc();

  
  var _searchController = StreamController<String>();

  Stream get getLocations => _searchController.stream;

void input(words) async {
  String res = await search.searchLocale(words);
  _searchController.add(res);
}

setLocation(String location) {
  Search().saveLocation(location);
  print("SAVED: $location");
}

  @override
  void dispose() {
    _searchController.close();
  }
}