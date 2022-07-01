import 'package:ditonton_siapa/common/failure.dart';
import 'package:ditonton_siapa/domain/entities/movie_detail.dart';
import 'package:ditonton_siapa/domain/repositories/movie_respository.dart';
import 'package:dartz/dartz.dart';

class SaveWatchlist {
  final MovieRepository repository;
  SaveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.saveWatchlist(movie);
  }
}
