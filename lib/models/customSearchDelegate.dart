import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CustomSearchDelegate extends SearchDelegate {
  Future<List> searchLocation(keywords) async {
    if (keywords == null || keywords.length < 3) return null;

    String req =
        "https://dsx.weather.com/x/v2/web/loc/pt_BR/1/4/5/9/11/13/19/21/1000/1001/1003/us%5E/$keywords?api=7bb1c920-7027-4289-9c96-ae5e263980bc&pg=0%2C10";
    http.Response res = await http.get(req);

    if (res.statusCode == 200) {
      return json.decode(utf8.decode(res.bodyBytes));
    }
    return null;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: searchLocation(query),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
          case ConnectionState.none:
            return Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                strokeWidth: 4.0,
              ),
            );
          default:
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Fail...",
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              if (snapshot.data == null || snapshot.data?.length == 0)
                return Container();
              else
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> locData = snapshot.data[index];
                    return InkWell(
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Icon(
                            Icons.location_on,
                            color: Colors.black,
                            size: 29,
                          ),
                          backgroundColor: Colors.transparent,
                        ),
                        title: Text(locData['cityNm']),
                        subtitle: Text(locData['stNm']),
                      ),
                      onTap: () {
                        close(context, locData);
                      },
                    );
                  },
                );
            }
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.search, size: 160, color: Colors.grey[400]),
        Text(
          "Search",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey[400], fontSize: 30),
        )
      ],
    ));
  }
}
