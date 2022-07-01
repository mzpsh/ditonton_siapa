import 'package:ditonton_siapa/common/failure.dart';
import 'package:ditonton_siapa/domain/entities/tv/tv_detail.dart';
import 'package:ditonton_siapa/domain/repositories/tv_repository.dart';
import 'package:dartz/dartz.dart';

class GetTvDetail {
  final TvRepository repository;

  GetTvDetail(this.repository);

  Future<Either<Failure, TvDetail>> execute(int id) {
    return repository.getDetailTv(id);
  }
}
