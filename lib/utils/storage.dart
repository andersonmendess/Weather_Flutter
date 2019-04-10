import 'package:path_provider/path_provider.dart';
import 'package:weather/api/weather.dart';
import 'dart:io';
import 'dart:convert';

class Storage {

  static final Storage _instance = Storage.internal();

  factory Storage() => _instance;

  Storage.internal();

  Future<File> getPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

  Future<void> saveData(Weather w) async {
    String data = json.encode(w.toMap());
    final file = await getPath();
    file.writeAsString(data);
  }

  Future<String> readFile() async {
    try {
      final file = await getPath();
      return file.readAsString();
    } catch (e) {
      return null;
    }
  }
}
