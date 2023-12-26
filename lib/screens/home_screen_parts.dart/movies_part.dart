import 'package:bfcai_app/data/api_services/movies_api_v.dart';
import 'package:bfcai_app/widgets/tv_movies_part.dart';
import 'package:flutter/material.dart';

class Movies extends StatefulWidget {
  const Movies({super.key});

  @override
  State<Movies> createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  MoviesP moviesP = MoviesP();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: moviesP.movieslist(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.amber,
            ),
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListOftv(moviesP.popularmovies, "popular movies", "movie", 20),
              ListOftv(moviesP.topratedmovies, "top rated movies", "movie", 20),
            ],
          );
        }
      },
    );
  }
}
