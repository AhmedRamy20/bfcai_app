import 'dart:convert';

import 'package:bfcai_app/data/api_services/apis.dart';
import 'package:bfcai_app/data/model/Movie_model.dart';
import 'package:http/http.dart' as http;

class PopularTv {
  List<TvSeriesMov> populartvseries = [];
  List<TvSeriesMov> topratedtvseries = [];

  //! This for the Popular Tv Series
  Future<void> gettvseries() async {
    var populartvresponse = await http.get(Uri.parse(populartvseriesurl));
    if (populartvresponse.statusCode == 200) {
      var tempdata1 = jsonDecode(populartvresponse.body);
      var populartvjson = tempdata1['results'];
      for (var i = 0; i < populartvjson.length; i++) {
        populartvseries.add(TvSeriesMov.fromJson(populartvjson[i]));
      }
    } else {
      print(populartvresponse.statusCode);
    }

    //! This for the Top Rated Tv Series

    var toptvresponse = await http.get(Uri.parse(topratedtvseriesurl));
    if (toptvresponse.statusCode == 200) {
      var tempdata2 = jsonDecode(toptvresponse.body);
      var toptvjson = tempdata2['results'];
      for (var i = 0; i < toptvjson.length; i++) {
        topratedtvseries.add(TvSeriesMov.fromJson(toptvjson[i]));
      }
    } else {
      print(toptvresponse.statusCode);
    }
  }
}
