import 'package:ditonton_siapa/common/failure.dart';
import 'package:ditonton_siapa/domain/repositories/tv_repository.dart';
import 'package:dartz/dartz.dart';

import '../../entities/tv/tv.dart';

class GetTvTopRated {
  final TvRepository repository;

  GetTvTopRated(this.repository);
  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getTvTopRated();
  }
}
