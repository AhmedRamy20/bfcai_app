import 'dart:convert';

import 'package:bfcai_app/data/api_services/apis.dart';
import 'package:bfcai_app/data/model/Movie_model.dart';
import 'package:http/http.dart' as http;

class TrendingModel {
  List<TrendingMov> trendinglist = [];

  Future<void> getTrendingData(int choiceurl) async {
    try {
      String url = choiceurl == 1 ? trendingweekurl : trendingdayurl;
      final trendingresponse = await http.get(Uri.parse(url));
      if (trendingresponse.statusCode == 200) {
        var trenddecode = jsonDecode(trendingresponse.body);
        var trendingwjson = trenddecode['results'];
        for (var i = 0; i < trendingwjson.length; i++) {
          trendinglist.add(TrendingMov.fromJson(trendingwjson[i]));
        }
      }
    } catch (e) {
      print("Error : $e".toString());
    }
  }
}
