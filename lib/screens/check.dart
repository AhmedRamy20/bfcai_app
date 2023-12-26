import 'package:bfcai_app/screens/movie_details.dart';
import 'package:bfcai_app/screens/tv_series_details.dart';
import 'package:flutter/material.dart';

class descriptioncheckui extends StatefulWidget {
  var newid;
  var newtype;

  descriptioncheckui(this.newid, this.newtype);

  @override
  State<descriptioncheckui> createState() => _descriptioncheckuiState();
}

class _descriptioncheckuiState extends State<descriptioncheckui> {
  checktype() {
    if (widget.newtype == 'movie') {
      return MoviesDetails(widget.newid);
    } else if (widget.newtype == 'tv') {
      return TvSeriesDetails(widget.newid);
    } else {
      return errorui();
    }
  }

  @override
  Widget build(BuildContext context) {
    return checktype();
  }
}

Widget errorui() {
  return const Scaffold(
    body: Center(
      child: Text("Error"),
    ),
  );
}
