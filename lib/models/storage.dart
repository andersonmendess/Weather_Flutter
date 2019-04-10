import 'package:path_provider/path_provider.dart';
import 'package:weather/models/weather.dart';
import 'dart:io';
import 'dart:convert';

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

    Future<void> saveData(Weather w) async {
    String data = json.encode(w.toMap());
    final file = await getDataFile();
    file.writeAsString(data);
  }

}
