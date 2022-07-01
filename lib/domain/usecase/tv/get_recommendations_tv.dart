import 'package:ditonton_siapa/common/failure.dart';
import 'package:ditonton_siapa/domain/entities/tv/tv.dart';
import 'package:ditonton_siapa/domain/repositories/tv_repository.dart';
import 'package:dartz/dartz.dart';

class GetRecommendationsTv {
  final TvRepository repository;

  GetRecommendationsTv(this.repository);
  Future<Either<Failure, List<Tv>>> execute(id) {
    return repository.getRecommendationsTv(id);
  }
}
