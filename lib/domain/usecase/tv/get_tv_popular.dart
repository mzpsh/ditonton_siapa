import 'package:ditonton_siapa/common/failure.dart';
import 'package:ditonton_siapa/domain/entities/tv/tv.dart';
import 'package:ditonton_siapa/domain/repositories/tv_repository.dart';
import 'package:dartz/dartz.dart';

class GetTvPopular {
  final TvRepository repository;

  GetTvPopular(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getTvPopular();
  }
}
