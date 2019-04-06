import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CustomSearchDelegate extends SearchDelegate {

  Future<List> searchLocale(keywords) async {
    if (keywords == null) return null;

    String req =
        "https://dsx.weather.com/x/v2/web/loc/pt_BR/1/4/5/9/11/13/19/21/1000/1001/1003/us%5E/$keywords?api=7bb1c920-7027-4289-9c96-ae5e263980bc&pg=0%2C10";
    http.Response res = await http.get(req);

    return json.decode(utf8.decode(res.bodyBytes));
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
      future: searchLocale(query),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          default:
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Error...",
                  style: TextStyle(color: Colors.red, fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              if (snapshot.data == null || snapshot.data.length == 0)
                return Container();
              else
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    print(snapshot.data[index]);

                    return InkWell(
                      child: ListTile(
                        title: Text(snapshot.data[index]['name']),
                      ),
                      onTap: () {

                      },
                    );
                  },
                );
            }
        }
      },
    );

    /**/
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
