import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';

class WStorage {

  static final WStorage _instance = WStorage.internal();

  factory WStorage() => _instance;

  WStorage.internal();


  void getData() {
    readFile().then((data) {
      Map<String, dynamic> dados = json.decode(data);
      print(dados['city']);
    });
  }


  void setData(Weather w) {
    saveFile(w);
  }

  Future<File> getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

  Future<File> saveFile(Weather w) async {
    String data = json.encode(w.toMap());
    final file = await getFile();
    return file.writeAsString(data);
  }

  Future<String> readFile() async {
    try {
      final file = await getFile();
      return file.readAsString();
    } catch (e) {
      return null;
    }
  }
}

class Weather {

  String city;
  String location;
  String icon;
  String temp;

  Weather();

  Weather.fromMap(Map map) {
    city = map['city'];
    location = map['location'];
    icon = map['icon'];
    temp = map['temp'];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      "city": city,
      "location": location,
      "icon": icon,
      "temp": temp,
    };
    return map;
  }

  @override
  String toString() {
    return "Weather (city: $city, location: $location, icon: $icon, temp: $temp)";
  }


}
