import 'package:ditonton_siapa/domain/usecase/get_top_rated_movies.dart';
import 'package:ditonton_siapa/presentation/bloc/movie/movie_event.dart';
import 'package:ditonton_siapa/presentation/bloc/movie/movie_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedMovie extends Bloc<EventMovie, StateMovie> {
  final GetTopRatedMovies _getTopRatedMovies;

  TopRatedMovie(this._getTopRatedMovies) : super(MovieEmpty()) {
    on<OnListMovie>(
      (event, emit) async {
        emit(MovieLoading());
        final result = await _getTopRatedMovies.execute();

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
