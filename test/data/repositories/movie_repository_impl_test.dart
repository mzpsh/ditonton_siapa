import 'dart:io';

import 'package:ditonton_siapa/common/exception.dart';
import 'package:ditonton_siapa/common/failure.dart';
import 'package:ditonton_siapa/data/model/movie_model.dart';
import 'package:ditonton_siapa/data/model/movie_table.dart';
import 'package:ditonton_siapa/data/repositories/movie_repository_impl.dart';
import 'package:ditonton_siapa/domain/entities/movie.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MovieRepositoryImpl repository;
  late MockMovieRemoteDataSource mockRemoteDataSource;
  late MockMovieLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockMovieRemoteDataSource();
    mockLocalDataSource = MockMovieLocalDataSource();
    repository = MovieRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  const tMovieModel = MovieModel(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final tMovie = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: const [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

  const testMovieCache = MovieTable(
    id: 557,
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    title: 'Spider-Man',
  );

  final tMovieModelList = <MovieModel>[tMovieModel];
  final tMovieList = <Movie>[tMovie];

  group('Now Playing Movies', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlaying())
          .thenAnswer((_) async => tMovieModelList);
      // act
      final result = await repository.getNowPlaying();
      // assert
      verify(mockRemoteDataSource.getNowPlaying());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tMovieList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlaying()).thenThrow(ServerException());
      // act
      final result = await repository.getNowPlaying();
      // assert
      verify(mockRemoteDataSource.getNowPlaying());
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlaying())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getNowPlaying();
      // assert
      verify(mockRemoteDataSource.getNowPlaying());
      expect(result,
          equals(const Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Popular Movies', () {
    test('should return movie list when call to data source is success',
        () async {
      ///arrange
      when(mockRemoteDataSource.getPopularMovies())
          .thenAnswer((_) async => tMovieModelList);

      ///act
      final result = await repository.getPopularMovies();

      ///assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tMovieList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      ///arrange
      when(mockRemoteDataSource.getPopularMovies())
          .thenThrow(ServerException());

      ///act
      final result = await repository.getPopularMovies();

      ///assert
      expect(result, const Left(ServerFailure('')));
    });
  });

  group('Top Rated Movies', () {
    test('should return movie list when call to data source is successful',
        () async {
      /// arrange
      when(mockRemoteDataSource.getTopRatedMovies())
          .thenAnswer((_) async => tMovieModelList);

      ///act
      final result = await repository.getTopRatedMovies();

      ///assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tMovieList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      /// arrange
      when(mockRemoteDataSource.getTopRatedMovies())
          .thenThrow(ServerException());

      /// act
      final result = await repository.getTopRatedMovies();

      /// assert
      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      /// arrange
      when(mockRemoteDataSource.getTopRatedMovies())
          .thenThrow(const SocketException('Failed to connect to the network'));

      /// act
      final result = await repository.getTopRatedMovies();

      /// assert
      expect(
          result, const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Search Movies', () {
    const tQuery = 'spiderman';

    test('should return movie list when call to data source is successful',
        () async {
      ///arrange
      when(mockRemoteDataSource.searchMovies(tQuery))
          .thenAnswer((_) async => tMovieModelList);

      ///act
      final result = await repository.searchMovies(tQuery);

      ///assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tMovieList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      ///arrange
      when(mockRemoteDataSource.searchMovies(tQuery))
          .thenThrow(ServerException());

      ///act
      final result = await repository.searchMovies(tQuery);

      ///assert
      expect(result, const Left(ServerFailure('')));
    });
  });

  group('Get Movie Recommendations', () {
    final tMovieList = <MovieModel>[];
    const tId = 1;

    test('should return data (movie list) when the call is successful',
        () async {
      /// arrange
      when(mockRemoteDataSource.getMovieRecommendations(tId))
          .thenAnswer((_) async => tMovieList);

      /// act
      final result = await repository.getMovieRecommendations(tId);

      /// assert
      verify(mockRemoteDataSource.getMovieRecommendations(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tMovieList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      /// arrange
      when(mockRemoteDataSource.getMovieRecommendations(tId))
          .thenThrow(ServerException());

      /// act
      final result = await repository.getMovieRecommendations(tId);

      /// assertbuild runner
      verify(mockRemoteDataSource.getMovieRecommendations(tId));
      expect(result, equals(const Left(ServerFailure(''))));
    });
  });

  group('Save watchlist', () {
    test('should return success message when saving successful', () async {
      /// arrange
      when(mockLocalDataSource.insertWatchlist(testMovieTable))
          .thenAnswer((_) async => 'Added to Watchlist');

      ///act
      final result = await repository.saveWatchlist(testMovieDetail);

      ///assert
      expect(result, const Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      ///arrange
      when(mockLocalDataSource.insertWatchlist(testMovieTable))
          .thenThrow(DataBaseException('Failed to add watchlist'));

      ///act
      final result = await repository.saveWatchlist(testMovieDetail);

      ///assert
      expect(result, const Left(DataBaseFailure('Failed to add watchlist')));
    });
  });

  group('Remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testMovieTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlist(testMovieDetail);
      // assert
      expect(result, const Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      ///arrange
      when(mockLocalDataSource.removeWatchlist(testMovieTable))
          .thenThrow(DataBaseException('Failed to remove watchlist'));

      ///act
      final result = await repository.removeWatchlist(testMovieDetail);

      ///assert
      expect(result, const Left(DataBaseFailure('Failed to remove watchlist')));
    });
  });

  group('Get watchlist status', () {
    test('should return watch status whether data is found', () async {
      /// arrange
      const tId = 1;
      when(mockLocalDataSource.getMovieById(tId)).thenAnswer((_) async => null);

      /// act
      final result = await repository.isAddedToWatchlist(tId);

      /// assert
      expect(result, false);
    });
  });

  group('Get watchlist movies', () {
    test('should return list of Movies', () async {
      ///arrange
      when(mockLocalDataSource.getWatchlistMovies())
          .thenAnswer((_) async => [testMovieTable]);

      ///act
      final result = await repository.getWatchlistMovies();

      ///assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistMovie]);
    });
  });
}
