import 'package:flutter/material.dart';
import 'package:weather/widgets/weatherCard.dart';
import 'package:weather/Utils/customSearchDelegate.dart';
import 'package:weather/Utils/storage.dart';
import 'package:weather/api/weather.dart';
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String city;
  String country;
  String icon;
  String temp;


  @override
  void initState() {
    super.initState();
    updateState();
  }

  void updateState() {
    Storage().readFile().then( (data){
      Map<String, dynamic> dados = json.decode(data);

      setState(() {
        city = dados['city'];
        country = dados['country'];
        icon = dados['icon'];
        temp = dados['temp'];
      });

    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Weather"),
        elevation: 0.3,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
              ).then( (res) async {
                if(res != null){

                  Weather().geo = res[0];
                  Weather().city = res[1];
                  Weather().country = res[2];
                  await Weather().fetchForecast();

                  updateState();
                }
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            WeatherCard(city, country, icon, temp),
          ]),
    ),
    );
  }
}
