import 'package:flutter/material.dart';
import 'package:weather/widgets/weatherCard.dart';
import 'package:weather/utils/customSearchDelegate.dart';
import 'package:weather/api/weather.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:weather/bloc/weatherController.dart';
import 'package:toast/toast.dart';
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    final WeatherController weatherBloc =
        BlocProvider.of<WeatherController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Weather"),
        elevation: 0.4,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.refresh, color: Colors.grey[700]),
          onPressed: () async {
            await Weather().fetchForecast();
            weatherBloc.update();
            Toast.show("Updated", context);

          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search, color: Colors.grey[700]),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
              ).then((res) async {
                if (res != null) {
                  Weather().geo = res[0];
                  Weather().city = res[1];
                  Weather().country = res[2];
                  await Weather().fetchForecast();

                  weatherBloc.update();
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
              StreamBuilder(
                stream: weatherBloc.getWeather,
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    return WeatherCard(json.decode(snapshot.data));
                  } else {
                    return Container();
                  }
                }),
              ),
            ]),
      ),
    );
  }
}
