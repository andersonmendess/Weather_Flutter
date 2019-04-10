import 'package:flutter/material.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:weather/bloc/search-bloc.dart';

import 'package:weather/widgets/backgroundContainer.dart';
import 'dart:convert';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List locations = [];

  @override
  Widget build(BuildContext context) {
    final SearchBloc searchBloc = BlocProvider.of<SearchBloc>(context);

    return Stack(children: <Widget>[
      BackgroudContainer('day'),
      CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.transparent,
            brightness: Brightness.dark,
            elevation: 0,
            leading: IconButton(
              icon:
                  Icon(Icons.arrow_back, color: Theme.of(context).accentColor),
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
                      searchBloc.input(e);
                    },
                  ),
                ),
                StreamBuilder(
                  stream: searchBloc.getLocations,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<dynamic> locations = json.decode(snapshot.data);
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: locations.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 0,
                            margin: EdgeInsets.all(2),
                            child: Container(
                              height: 65,
                              child: InkWell(
                                onTap: (){
                                  SearchBloc()
                                    .setLocation(json.encode(locations[index]));
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
                )
              ],
            ),
          )),
        ],
      )
    ]);
  }
}
