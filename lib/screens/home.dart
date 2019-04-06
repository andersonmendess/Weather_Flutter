import 'package:flutter/material.dart';
import 'package:weather/widgets/weatherCard.dart';
import 'package:weather/Utils/customSearchDelegate.dart';
import 'package:weather/Utils/wstorage.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  @override
  void initState() {
    super.initState();

    Weather w = Weather();

    WStorage ws = WStorage();

    w.location = "Brasil";
    w.city = "São Paulo";
    w.temp = "33c";
    w.icon = "rain";

    //ws.saveFile(w);
    ws.getData();
    //print(w);

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
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            WeatherCard("São Paulo", "Brasil", "partly_cloudy", "33"),
            Padding(
              padding: EdgeInsets.only(left: 5.0, right: 5.0),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius:BorderRadius.circular(12.0),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Please enter your location',
                    hintStyle: TextStyle(color: Colors.grey[600])
                ),
              ),
            ),
          ]),
    ),
    );
  }
}
