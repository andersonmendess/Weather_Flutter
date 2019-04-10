import 'package:flutter/material.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:weather/screens/home.dart';
import 'package:weather/bloc/home-bloc.dart';
import 'package:weather/bloc/search-bloc.dart';
import 'package:flutter/services.dart';
import 'package:weather/screens/search.dart';

void main() => runApp(App());

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return MaterialApp(
      title: "Weather",
      home: BlocProvider<HomeBloc>(
        child: BlocProvider<SearchBloc>(
          child: Home(),
          bloc: SearchBloc(),
        ),
        bloc: HomeBloc(),
      ),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'GoogleSans',
        primaryColor: Colors.white,
        hintColor: Colors.white,
        accentColor: Colors.white,
        cardColor: Color.fromARGB(235, 245, 245, 245),
          
      textTheme: TextTheme(
        title: TextStyle(fontSize: 25, color: Colors.grey[800]),
      )
          ),
    );
  }
}
