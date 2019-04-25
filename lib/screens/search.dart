import 'package:weather/widgets/backgroundContainer.dart';
import 'package:weather/blocs/weather-bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List locations = [];
  TimeOfDay now = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    final WeatherBloc weatherBloc = BlocProvider.of<WeatherBloc>(context);

    return Stack(children: <Widget>[
      StreamBuilder(
        stream: weatherBloc.getDayOrNight,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return BackgroudContainer(snapshot.data);
          } else {
            return BackgroudContainer(now.period.index == 0 ? 'D' : "N");
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
              icon: Icon(Icons.arrow_back, color: Theme.of(context).accentColor),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "Search",
                style: TextStyle(color: Theme.of(context).accentColor),
              ),
              centerTitle: true,
            ),
          ),
          SliverToBoxAdapter(
              child: Container(
            padding: EdgeInsets.only(left: 4, right: 4, top: 10),
            child: Column(
              children: <Widget>[
                Card(
                  elevation: 0,
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Type Here...',
                        hintStyle: TextStyle(color: Colors.grey[800])),
                    style: TextStyle(color: Colors.black, fontSize: 19),
                    textAlign: TextAlign.center,
                    onSubmitted: (e) {
                      weatherBloc.input(e);
                    },
                  ),
                ),
                StreamBuilder(
                  stream: weatherBloc.getLocations,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<dynamic> locations = json.decode(snapshot.data);
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: locations.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 0,
                            margin: EdgeInsets.all(2),
                            child: Container(
                              height: 65,
                              child: InkWell(
                                onTap: () {
                                  weatherBloc.setLocation(locations[index]);
                                  Navigator.pop(context);
                                },
                                child: ListTile(
                                  title: Text(
                                      '${locations[index]['cityNm']}, ${locations[index]['stCd']}'),
                                  subtitle: Text(locations[index]['_country']),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          )),
        ],
      )
    ]);
  }
}
