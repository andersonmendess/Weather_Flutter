import 'package:weather/widgets/backgroundContainer.dart';
import 'package:weather/widgets/weatherCard.dart';
import 'package:weather/blocs/weather-bloc.dart';
import 'package:weather/screens/search.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  WeatherBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = WeatherBloc();
    bloc.main();
  }

  @override
  void dispose() {
    bloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      StreamBuilder(
        stream: bloc.getDayOrNight,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return BackgroudContainer(snapshot.data);
          } else {
            return BackgroudContainer("D");
          }
        },
      ),
      CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.transparent,
            brightness: Brightness.dark,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.refresh, color: Theme.of(context).accentColor),
              onPressed: () {
                bloc.main();
              },
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "Weather",
                style: TextStyle(color: Theme.of(context).accentColor),
              ),
              centerTitle: true,
            ),
            actions: <Widget>[
              IconButton(
                  icon:
                      Icon(Icons.search, color: Theme.of(context).accentColor),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Search()));
                  }),
            ],
          ),
          SliverToBoxAdapter(
            child: StreamBuilder(
              stream: bloc.getWeather,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return WeatherCard(snapshot.data);
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      )
    ]);
  }
}
