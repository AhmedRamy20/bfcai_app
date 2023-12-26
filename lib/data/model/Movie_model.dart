class TrendingMov {
  int? id;
  String? posterPath;
  String? mediaType;
  double? voteAverage;
  String? name;
  String? overview;
  String? release_date;

  TrendingMov({
    this.id,
    this.posterPath,
    this.mediaType,
    this.voteAverage,
    this.name,
    this.overview,
    this.release_date,
  });
  factory TrendingMov.fromJson(Map<String, dynamic> json) {
    return TrendingMov(
      id: json['id'],
      posterPath: json['poster_path'],
      voteAverage: json['vote_average'],
      mediaType: json['media_type'],
      name: json['name'],
      overview: json['overview'],
      release_date: json['release_date'],
    );
  }
}

class TvSeriesMov {
  int? id;
  String? posterPath;
  String? mediaType;
  double? voteAverage;
  String? name;

  TvSeriesMov({
    this.id,
    this.posterPath,
    this.mediaType,
    this.voteAverage,
    this.name,
  });
  factory TvSeriesMov.fromJson(Map<String, dynamic> json) {
    return TvSeriesMov(
      id: json['id'],
      posterPath: json['poster_path'],
      voteAverage: json['vote_average'],
      mediaType: json['media_type'],
      name: json['name'],
    );
  }
}

//!
class Moviespart {
  int? id;
  String? posterPath;
  String? date;
  double? voteAverage;
  String? name;

  Moviespart({
    this.id,
    this.posterPath,
    this.date,
    this.voteAverage,
    this.name,
  });
  factory Moviespart.fromJson(Map<String, dynamic> json) {
    return Moviespart(
      id: json['id'],
      posterPath: json['poster_path'],
      voteAverage: json['vote_average'],
      date: json['release_date'],
      name: json['name'],
    );
  }
}



//!!!!!!!!!!!!!!!!!!



// popularmovies.add({
//           "name": popularmoviesjson[i]["title"],
//           "posterpath": popularmoviesjson[i]["poster_path"],
//           "vote_average": popularmoviesjson[i]["vote_average"],
//           "Date": popularmoviesjson[i]["release_date"],
//           "id": popularmoviesjson[i]["id"],
//         });
