import 'package:weather/blocs/weather-bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:weather/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return BlocProvider<WeatherBloc>(
      child: MaterialApp(
          title: "Weather",
          home: Home(),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              fontFamily: 'GoogleSans',
              primaryColor: Colors.white,
              hintColor: Colors.white,
              accentColor: Colors.white,
              cardColor: Color.fromARGB(230, 245, 245, 245),
              textTheme: TextTheme(
                title: TextStyle(fontSize: 25, color: Colors.grey[800]),
              )),
        ),
      bloc: WeatherBloc(),
    );
  }
}
