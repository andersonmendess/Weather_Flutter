import 'package:bloc_pattern/bloc_pattern.dart';
import 'dart:async';
import 'package:weather/models/search.dart';

class SearchBloc implements BlocBase {

  Search search = Search();

  var _searchController = StreamController<String>.broadcast();

  Stream get getLocations => _searchController.stream;

void input(words) async {
  String res = await search.searchLocation(words);
  _searchController.add(res);
}

setLocation(String location) {
  search.saveLocation(location);
  print("SAVED: $location");
}

  @override
  void dispose() {
    _searchController.close();
  }
}