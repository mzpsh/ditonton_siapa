import 'package:ditonton_siapa/common/failure.dart';
import 'package:ditonton_siapa/domain/entities/tv/tv_detail.dart';
import 'package:ditonton_siapa/domain/repositories/tv_repository.dart';
import 'package:dartz/dartz.dart';

class SaveWatchlistTv {
  final TvRepository repository;
  SaveWatchlistTv(this.repository);

  Future<Either<Failure, String>> execute(TvDetail tvDetail) {
    return repository.saveWatchlistTv(tvDetail);
  }
}
