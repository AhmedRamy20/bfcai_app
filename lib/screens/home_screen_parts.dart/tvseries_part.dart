import 'package:bfcai_app/data/api_services/tvseries_movie_api.dart';
import 'package:bfcai_app/widgets/tv_movies_part.dart';
import 'package:flutter/material.dart';

class TvSeries extends StatefulWidget {
  const TvSeries({super.key});

  @override
  State<TvSeries> createState() => _TvSeriesState();
}

class _TvSeriesState extends State<TvSeries> {
  PopularTv popularTv = PopularTv();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: popularTv.gettvseries(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListOftv(
                  popularTv.populartvseries, "Popular tv series", "tv", 20),
              ListOftv(
                  popularTv.topratedtvseries, "Top rated series", "tv", 20),
            ],
          );
        }
      },
    );
  }
}
