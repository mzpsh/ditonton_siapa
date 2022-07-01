import 'package:ditonton_siapa/domain/usecase/get_popular_movies.dart';
import 'package:ditonton_siapa/presentation/bloc/movie/movie_event.dart';
import 'package:ditonton_siapa/presentation/bloc/movie/movie_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularMovie extends Bloc<EventMovie, StateMovie> {
  final GetPopularMovies _getPopularMovies;

  PopularMovie(this._getPopularMovies) : super(MovieEmpty()) {
    on<OnListMovie>(
      (event, emit) async {
        emit(MovieLoading());
        final result = await _getPopularMovies.execute();

        result.fold(
          (failure) {
            emit(MovieError(failure.message));
          },
          (data) {
            emit(MovieHasData(data));
          },
        );
      },
    );
  }
}
