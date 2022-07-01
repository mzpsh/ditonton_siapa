import 'package:ditonton_siapa/common/failure.dart';
import 'package:ditonton_siapa/domain/entities/movie.dart';
import 'package:ditonton_siapa/domain/repositories/movie_respository.dart';
import 'package:dartz/dartz.dart';

class GetMovieRecommendations {
  final MovieRepository repository;
  GetMovieRecommendations(this.repository);

  Future<Either<Failure, List<Movie>>> execute(id) {
    return repository.getMovieRecommendations(id);
  }
}
