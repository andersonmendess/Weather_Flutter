import 'package:http/http.dart' as http;
import 'dart:convert';

class Search {
  
  Future<String> searchLocation(keywords) async {
    
    if (keywords == null) return null;
    if(keywords.length < 3) return null;

    String req ="https://dsx.weather.com/x/v2/web/loc/pt_BR/1/4/5/9/11/13/19/21/1000/1001/1003/us%5E/$keywords?api=7bb1c920-7027-4289-9c96-ae5e263980bc&pg=0%2C10";
    http.Response res = await http.get(req);

    if (res.statusCode == 200) {
      return utf8.decode(res.bodyBytes);
    }
    return null;

  }

}