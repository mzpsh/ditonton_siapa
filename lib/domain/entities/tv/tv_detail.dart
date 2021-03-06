import 'package:equatable/equatable.dart';

import '../genre.dart';

class TvDetail extends Equatable {
  TvDetail({
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    // required this.firstAirDate,
    required this.episodeRunTime,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
  });

  final String? backdropPath;
  final List<Genre> genres;
  final int id;
  final String originalName;
  final String overview;
  final String posterPath;
  // final String firstAirDate;
  final List<int> episodeRunTime;
  final String name;
  final double voteAverage;
  final int voteCount;

  @override
  List<Object?> get props => [
        backdropPath,
        genres,
        id,
        originalName,
        overview,
        posterPath,
        // firstAirDate,
        episodeRunTime,
        name,
        voteAverage,
        voteCount,
      ];
}
