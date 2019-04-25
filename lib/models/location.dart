import 'package:shared_preferences/shared_preferences.dart';

class Location {

  static final Location _instance = Location.internal();

  factory Location() => _instance;

  Location.internal();

  String geocode;
  String cityNm;
  String stCd;

  fromMap(Map map) {
    geocode = map['geocode'];
    cityNm = map['cityNm'];
    stCd = map['stCd'];
  }

  fromList(List list){
    geocode = list[0];
    cityNm = list[1];
    stCd = list[2];
  }

  List<String> asList(){
    return [ geocode, cityNm, stCd ];
  }
  
  Future<void> setStoredLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('location',asList());
  }

  Future<void> getStoredLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List list = prefs.getStringList('location');
    if(list != null) fromList(list);
  }

  @override
  String toString() {
    return "Location (geocode: $geocode, cityNm: $cityNm, stCd: $stCd)";
  }
}