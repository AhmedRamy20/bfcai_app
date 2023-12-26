//!!!!!!!!!!!!!!!!!!!!!!!!

import 'package:bfcai_app/data/api_services/api_key.dart';
import 'package:bfcai_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MoviesDetails extends StatefulWidget {
  final int id;
  MoviesDetails(this.id);

  @override
  State<MoviesDetails> createState() => _MoviesDetailsState();
}

class _MoviesDetailsState extends State<MoviesDetails> {
  List<Map<String, dynamic>> moviesDetails = [];
  List<String> moviesGenres = [];
  bool isDataLoaded = false;

  @override
  void initState() {
    super.initState();
    loadMovieDetails();
  }

  Future<void> loadMovieDetails() async {
    var moviedetailurl =
        'https://api.themoviedb.org/3/movie/${widget.id}?api_key=$apikey';

    var moviedetailresponse = await http.get(Uri.parse(moviedetailurl));
    if (moviedetailresponse.statusCode == 200) {
      var moviedetailjson = jsonDecode(moviedetailresponse.body);
      for (var i = 0; i < 1; i++) {
        moviesDetails.add({
          "backdrop_path": moviedetailjson['backdrop_path'],
          "title": moviedetailjson['title'],
          "vote_average": moviedetailjson['vote_average'],
          "overview": moviedetailjson['overview'],
          "release_date": moviedetailjson['release_date'],
          "runtime": moviedetailjson['runtime'],
          "budget": moviedetailjson['budget'],
          "revenue": moviedetailjson['revenue'],
        });
      }
      for (var i = 0; i < moviedetailjson['genres'].length; i++) {
        moviesGenres.add(moviedetailjson['genres'][i]['name']);
      }
    } else {
      print('Failed to load movie details');
    }

    setState(() {
      isDataLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(14, 14, 14, 1),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
              iconSize: 28,
              color: Colors.white,
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.house),
                iconSize: 25,
                color: Colors.white,
              )
            ],
            backgroundColor: const Color.fromRGBO(18, 18, 18, 0.5),
            centerTitle: false,
            pinned: true,
            expandedHeight: MediaQuery.of(context).size.height * 0.4,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: FittedBox(
                fit: BoxFit.fill,
                child: Image.network(
                  'https://image.tmdb.org/t/p/w500${moviesDetails[0]['backdrop_path']}',
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 10, top: 10),
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: moviesGenres.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(25, 25, 25, 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(moviesGenres[index]),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(left: 10, top: 10),
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(25, 25, 25, 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          moviesDetails[0]['title'],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(left: 10, top: 10),
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(25, 25, 25, 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          moviesDetails[0]['runtime'].toString() + ' min',
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20, top: 10),
                child: Text('Movie Story :'),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Text(moviesDetails[0]['overview'].toString()),
              ),
              // ... (you can add more details as needed)
            ]),
          ),
        ],
      ),
    );
  }
}
