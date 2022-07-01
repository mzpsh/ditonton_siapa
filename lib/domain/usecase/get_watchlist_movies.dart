import 'package:ditonton_siapa/common/failure.dart';
import 'package:ditonton_siapa/domain/entities/movie.dart';
import 'package:ditonton_siapa/domain/repositories/movie_respository.dart';
import 'package:dartz/dartz.dart';

class GetWatchlistMovies {
  final MovieRepository _repository;
  GetWatchlistMovies(this._repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return _repository.getWatchlistMovies();
  }
}
