import 'package:bfcai_app/data/api_services/api_key.dart';
import 'package:bfcai_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TvSeriesDetails extends StatefulWidget {
  final int id;
  TvSeriesDetails(this.id);

  @override
  State<TvSeriesDetails> createState() => _TvSeriesDetailsState();
}

class _TvSeriesDetailsState extends State<TvSeriesDetails> {
  List<Map<String, dynamic>> tvSeriesDetails = [];
  List<String> tvGenres = [];
  bool isDataLoaded = false;

  @override
  void initState() {
    super.initState();
    loadTvSeriesDetails();
  }

  Future<void> loadTvSeriesDetails() async {
    var tvSeriesDetailUrl =
        'https://api.themoviedb.org/3/tv/${widget.id}?api_key=$apikey';

    var tvSeriesDetailResponse = await http.get(Uri.parse(tvSeriesDetailUrl));
    if (tvSeriesDetailResponse.statusCode == 200) {
      var tvSeriesDetailJson = jsonDecode(tvSeriesDetailResponse.body);
      for (var i = 0; i < 1; i++) {
        tvSeriesDetails.add({
          "backdrop_path": tvSeriesDetailJson['backdrop_path'],
          "name": tvSeriesDetailJson['name'],
          "vote_average": tvSeriesDetailJson['vote_average'],
          "overview": tvSeriesDetailJson['overview'],
          "first_air_date": tvSeriesDetailJson['first_air_date'],
          "episode_runtime": tvSeriesDetailJson['episode_runtime'],
        });
      }
      for (var i = 0; i < tvSeriesDetailJson['genres'].length; i++) {
        tvGenres.add(tvSeriesDetailJson['genres'][i]['name']);
      }
    } else {
      print('Failed to load TV series details');
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
                      builder: (context) => HomePage(),
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
                  'https://image.tmdb.org/t/p/w500${tvSeriesDetails[0]['backdrop_path']}',
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
                          itemCount: tvGenres.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(25, 25, 25, 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(tvGenres[index]),
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
                          tvSeriesDetails[0]['name'],
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20, top: 10),
                child: Text('TV Series Overview :'),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Text(tvSeriesDetails[0]['overview'].toString()),
              ),
              // ... (you can add more details as needed)
            ]),
          ),
        ],
      ),
    );
  }
}
