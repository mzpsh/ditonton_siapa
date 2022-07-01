import 'package:ditonton_siapa/common/failure.dart';
import 'package:ditonton_siapa/domain/entities/movie.dart';
import 'package:ditonton_siapa/domain/repositories/movie_respository.dart';
import 'package:dartz/dartz.dart';

class SearchMovies {
  final MovieRepository repository;
  SearchMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute(String query) {
    return repository.searchMovies(query);
  }
}
