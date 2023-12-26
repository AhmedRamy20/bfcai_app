import 'package:bfcai_app/data/api_services/apis.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PopularPeoplePage extends StatefulWidget {
  const PopularPeoplePage({super.key});

  @override
  _PopularPeoplePageState createState() => _PopularPeoplePageState();
}

class _PopularPeoplePageState extends State<PopularPeoplePage> {
  List<Map<String, dynamic>> popularPeopleList = [];

  Future<void> fetchPopularPeople() async {
    try {
      final response = await http.get(
        Uri.parse(popularpeapleurl),
      );
      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);
        var popularPeopleJson = decode['results'];
        for (var i = 0; i < popularPeopleJson.length; i++) {
          popularPeopleList.add({
            'id': popularPeopleJson[i]['id'],
            'name': popularPeopleJson[i]['name'],
            'profile_path': popularPeopleJson[i]['profile_path'],
            // Add more properties as needed
          });
        }
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular People'),
      ),
      body: FutureBuilder(
        future: fetchPopularPeople(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return ListView.builder(
              scrollDirection: Axis.horizontal, // Horizontal scroll
              itemCount: popularPeopleList.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(8),
                  width: 200, // Set your desired width
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            height: 150, // Set your desired height
                            width: 200, // Set your desired width
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: NetworkImage(
                                  'https://image.tmdb.org/t/p/w500${popularPeopleList[index]['profile_path']}',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              popularPeopleList[index]['name'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
