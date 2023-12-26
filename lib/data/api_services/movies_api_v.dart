import 'dart:convert';

import 'package:bfcai_app/data/api_services/apis.dart';
import 'package:bfcai_app/data/model/Movie_model.dart';
import 'package:http/http.dart' as http;

class MoviesP {
  List<Moviespart> popularmovies = [];
  List<Moviespart> topratedmovies = [];

  //! This for the Popular Tv Series
  Future<void> movieslist() async {
    var popularmoviesresponse = await http.get(Uri.parse(popularmoviesurl));
    if (popularmoviesresponse.statusCode == 200) {
      var tempdata = jsonDecode(popularmoviesresponse.body);
      var popularmoviesjson = tempdata['results'];
      for (var i = 0; i < popularmoviesjson.length; i++) {
        popularmovies.add(Moviespart.fromJson(popularmoviesjson[i]));
      }
    } else {
      print(popularmoviesresponse.statusCode);
    }
    var topratedmoviesresponse = await http.get(Uri.parse(topratedmoviesurl));
    if (topratedmoviesresponse.statusCode == 200) {
      var tempdata = jsonDecode(topratedmoviesresponse.body);
      var topratedmoviesjson = tempdata['results'];
      for (var i = 0; i < topratedmoviesjson.length; i++) {
        topratedmovies.add(Moviespart.fromJson(topratedmoviesjson[i]));
      }
    } else {
      print(topratedmoviesresponse.statusCode);
    }
  }
}
