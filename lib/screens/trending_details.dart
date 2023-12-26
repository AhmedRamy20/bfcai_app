import 'package:bfcai_app/data/model/Movie_model.dart';
import 'package:bfcai_app/widgets/back_button.dart';
import 'package:flutter/material.dart';

class TrendingDetails extends StatelessWidget {
  const TrendingDetails({super.key, required this.movie});

  final TrendingMov movie;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            leading: const Backbtn(),
            backgroundColor: Colors.black,
            expandedHeight: 400,
            pinned: false,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                movie.name ?? 'Not avail',
              ),
              background: ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24)),
                child: Image.network(
                  'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Overview",
                  ),
                  const SizedBox(height: 16),
                  Text(
                    movie.overview ?? 'Unknown',

                    // textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              const Text(
                                "Release Date: ",
                              ),
                              Text(
                                movie.release_date.toString(),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              const Text(
                                "Rating: ",
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              Text(
                                "${movie.voteAverage?.toStringAsFixed(1)}/10",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
