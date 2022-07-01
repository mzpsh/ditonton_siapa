import 'package:ditonton_siapa/domain/entities/movie.dart';
import 'package:ditonton_siapa/domain/usecase/search_movies.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchMovies searchMovies;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    searchMovies = SearchMovies(mockMovieRepository);
  });

  final tMovies = <Movie>[];
  const tQuery = "Spiderman";
  test('should get list of movies from the repository', () async {
    ///arrange
    when(mockMovieRepository.searchMovies(tQuery))
        .thenAnswer((_) async => Right(tMovies));

    ///act
    final result = await searchMovies.execute(tQuery);

    ///assert
    expect(result, Right(tMovies));
  });
}
