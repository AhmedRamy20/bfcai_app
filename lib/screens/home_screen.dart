//! try to modify the Trending text and weekly dropDownMenue
//* to be in more suitable place

import 'package:bfcai_app/data/api_services/trending_movie_api.dart';
import 'package:bfcai_app/screens/home_screen_parts.dart/movies_part.dart';
import 'package:bfcai_app/screens/home_screen_parts.dart/tvseries_part.dart';
import 'package:bfcai_app/screens/home_screen_parts.dart/popularpeople_part.dart';
import 'package:bfcai_app/screens/trending_details.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TrendingModel trendingModel = TrendingModel();
  int choiceurl = 1;

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 3, vsync: this);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  choiceurl == 1 ? 'Weekly' : 'Daily',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    // fontFamily: 'Caveat',
                  ),
                ),
                DropdownButton(
                  onChanged: (value) {
                    setState(() {
                      trendingModel.trendinglist.clear();
                      choiceurl = int.parse(value.toString());
                    });
                  },
                  autofocus: true,
                  underline: Container(
                    height: 0,
                    color: Colors.transparent,
                  ),
                  dropdownColor: Colors.black.withOpacity(0.2),
                  icon: Icon(
                    Icons.arrow_drop_down_sharp,
                    color: Colors.blue[800],
                    size: 35,
                  ),
                  value: choiceurl,
                  items: const [
                    DropdownMenuItem(
                      value: 1,
                      child: Text(
                        'Weekly',
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.white,
                          fontSize: 25,
                          // fontFamily: 'Caveat',
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      value: 2,
                      child: Text(
                        'Daily',
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.white,
                          fontSize: 25,
                          // fontFamily: 'Caveat',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              FutureBuilder(
                future: trendingModel.getTrendingData(choiceurl),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue[800],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    return CarouselSlider(
                      options: CarouselOptions(
                        height: 300,
                        autoPlay: true,
                        viewportFraction: 0.55,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        autoPlayAnimationDuration: const Duration(seconds: 1),
                        enlargeCenterPage: true,
                        pageSnapping: true,
                      ),
                      items: trendingModel.trendinglist.map((e) {
                        return Builder(builder: (BuildContext context) {
                          return GestureDetector(
                            onTap: () {
                              //! Here the Nevigator test
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => TrendingDetails(
                                        movie: e,
                                      )));
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: SizedBox(
                                height: 300,
                                width: 200,
                                child: Image.network(
                                  'https://image.tmdb.org/t/p/w500${e.posterPath}',
                                  filterQuality: FilterQuality.high,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        });
                      }).toList(),
                    );
                  }
                },
              ),

              //*! Curse begin :)
              SizedBox(
                height: 45,
                width: MediaQuery.of(context).size.width,
                child: TabBar(
                  physics: const BouncingScrollPhysics(),
                  labelPadding: const EdgeInsets.symmetric(horizontal: 25),
                  isScrollable: true,
                  controller: _tabController,
                  indicator: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    // color: const Color.fromARGB(255, 32, 199, 211),
                    color: const Color(0xff808080),
                  ),
                  tabs: const [
                    Tab(
                      child: Text(
                        'Tv Series',
                        style: TextStyle(color: Color(0xffC0C0C0)),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Movies    ',
                        style: TextStyle(color: Color(0xffC0C0C0)),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Popular-ppl',
                        style: TextStyle(color: Color(0xffC0C0C0)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 1050,
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    TvSeries(),
                    Movies(),
                    // Upcomming(),
                    PopularPeoplePage(),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
