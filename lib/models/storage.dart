import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';
import 'package:weather/models/weather.dart';

class Storage {
  static final Storage _instance = Storage.internal();

  factory Storage() => _instance;

  Storage.internal();


  Future<Directory> _getDirectory() async {
    return await getApplicationDocumentsDirectory();
  }

  Future<File> getDataFile() async {
    final file = await _getDirectory();
    return File("${file.path}/data.json");
  }

  Future<String> getData() async {
    try {
    final file = await getDataFile();
    return file.readAsString();
    } catch (e) {
      return null;
    }
  }

  Future<void> saveData(data) async {
    final file = await getDataFile();
    file.writeAsStringSync(data);
  }

  Future<File> getDataFileW() async {
    final file = await _getDirectory();
    return File("${file.path}/weather.json");
  }

  Future<String> getDataW() async {
    try {
    final file = await getDataFileW();
    return file.readAsString();
    } catch (e) {
      return null;
    }
  }

  Future<void> saveDataW(Weather weather) async {
    String data = json.encode(weather.toMap());
    final file = await getDataFileW();
    file.writeAsString(data);
  }

}
