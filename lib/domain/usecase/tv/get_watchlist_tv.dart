import 'package:ditonton_siapa/domain/entities/tv/tv.dart';
import 'package:ditonton_siapa/domain/repositories/tv_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../common/failure.dart';

class GetWatchlistTv {
  final TvRepository _repository;
  GetWatchlistTv(this._repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return _repository.getWatchlistTv();
  }
}
