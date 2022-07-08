import 'dart:async';
import 'dart:io';

import 'package:ditonton_siapa/common/exception.dart';
import 'package:ditonton_siapa/common/failure.dart';
import 'package:ditonton_siapa/data/datasources/remote/remote_data_source.dart';
import 'package:ditonton_siapa/data/model/tv/tv_table.dart';
import 'package:ditonton_siapa/domain/entities/tv/tv.dart';
import 'package:ditonton_siapa/domain/entities/tv/tv_detail.dart';
import 'package:ditonton_siapa/domain/repositories/tv_repository.dart';
import 'package:dartz/dartz.dart';

import '../datasources/local/tv/local_data_source_tv.dart';

class TvRepositoryImpl implements TvRepository {
  final MovieRemoteDataSource remoteDataSource;
  //final NetworkInfo networkInfo;

  final TvLocalDataSource tvLocalDataSource;
  TvRepositoryImpl({
    required this.remoteDataSource,
    required this.tvLocalDataSource,
    // required Object localDataSource,
    //required this.networkInfo
  });

  @override
  Future<Either<Failure, TvDetail>> getDetailTv(int id) async {
    try {
      final result = await remoteDataSource.getDetailTv(id);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed connect to network'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getTvAiringToday() async {
    try {
      final result = await remoteDataSource.getTvAiringToday();
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect the network'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getTvOnTheAir() async {
    try {
      final result = await remoteDataSource.getTvOnTheAir();
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect the network'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getTvPopular() async {
    try {
      final result = await remoteDataSource.getTvPopular();
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect the network'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getTvTopRated() async {
    try {
      final result = await remoteDataSource.getTvTopRated();
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect the network'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getWatchlistTv() async {
    final result = await tvLocalDataSource.getWatchlistTv();
    return Right(result.map((e) => e.toEntity()).toList());
  }

  @override
  Future<bool> isAddedToWatchlistTv(int id) async {
    final result = await tvLocalDataSource.getTvById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, String>> removeWatchlistTv(TvDetail tvDetail) async {
    try {
      final result =
          await tvLocalDataSource.removeWatchlist(TvTable.fromEntity(tvDetail));
      return Right(result);
    } on DataBaseException catch (e) {
      return Left(DataBaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlistTv(TvDetail tvDetail) async {
    try {
      final result =
          await tvLocalDataSource.insertWatchlist(TvTable.fromEntity(tvDetail));
      return Right(result);
    } on DataBaseException catch (e) {
      return Left(DataBaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> searchTv(String query) async {
    try {
      final result = await remoteDataSource.searchTv(query);
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect the network'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getRecommendationsTv(int id) async {
    try {
      final result = await remoteDataSource.getTvRecommendations(id);
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerFailure {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed connect to network'));
    }
  }
}
