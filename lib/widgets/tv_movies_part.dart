import 'package:bfcai_app/screens/movie_details.dart';
import 'package:bfcai_app/screens/tv_series_details.dart';
import 'package:flutter/material.dart';

Widget ListOftv(
    List choosenlist, String choosenname, String type, int itemcount) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 15, bottom: 40),
        child: Text(choosenname),
      ),
      SizedBox(
        height: 250,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: itemcount,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                //* The Details screen Decide if it is a movie or a series
                if (type == 'movie') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MoviesDetails(choosenlist[index].id),
                      ));
                } else if (type == 'tv') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            TvSeriesDetails(choosenlist[index].id),
                      ));
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.3), BlendMode.darken),
                        image: NetworkImage(
                            'https://image.tmdb.org/t/p/w500${choosenlist[index].posterPath}'),
                        fit: BoxFit.cover)),
                margin: const EdgeInsets.only(left: 13),
                width: 170,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 2, left: 6),
                    //   child: Text(
                    //     choosenlist[index].id.toString(),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 2,
                        right: 6,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 2, bottom: 2, left: 5, right: 5),
                          child: Row(
                            //row for the rating icon and
                            children: [
                              const Icon(Icons.star,
                                  color: Colors.yellow, size: 15),
                              const SizedBox(width: 2),
                              Text(
                                choosenlist[index]
                                    .voteAverage
                                    .toInt()
                                    .toString(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
      const SizedBox(height: 20),
    ],
  );
}
