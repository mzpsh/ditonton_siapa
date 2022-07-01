import 'package:ditonton_siapa/domain/usecase/get_now_playing_movies.dart';
import 'package:ditonton_siapa/presentation/bloc/movie/movie_event.dart';
import 'package:ditonton_siapa/presentation/bloc/movie/movie_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListMovie extends Bloc<EventMovie, StateMovie> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  ListMovie(this._getNowPlayingMovies) : super(MovieEmpty()) {
    on<OnListMovie>(
      (event, emit) async {
        emit(MovieLoading());
        final result = await _getNowPlayingMovies.execute();

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
