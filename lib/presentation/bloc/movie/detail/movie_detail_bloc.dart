import 'package:ditonton_siapa/common/state_enum.dart';
import 'package:bloc/bloc.dart';
import 'package:ditonton_siapa/domain/usecase/get_detail_movie.dart';
import 'package:ditonton_siapa/domain/usecase/get_recommended_movie.dart';
import 'package:ditonton_siapa/domain/usecase/get_watchlist_status.dart';
import 'package:ditonton_siapa/domain/usecase/remove_watchlist.dart';
import 'package:ditonton_siapa/domain/usecase/save_watchlist.dart';
import 'package:ditonton_siapa/presentation/bloc/movie/detail/movie_detail_event.dart';
import 'package:ditonton_siapa/presentation/bloc/movie/detail/movie_detail_state.dart';

class DetailBlocMovie extends Bloc<DetailEventMovie, DetailStateMovie> {
  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  static const watchListAdd = 'Added to Watchlist';
  static const watchListRemove = 'Removed from Watchlist';

  DetailBlocMovie(this.getMovieDetail, this.getMovieRecommendations,
      this.getWatchListStatus, this.saveWatchlist, this.removeWatchlist)
      : super(DetailStateMovie.initial()) {
    on<OnDetailList>(
      (event, emit) async {
        emit(state.copyWith(
          movieDetailState: RequestState.loading,
        ));
        final result = await getMovieDetail.execute(event.id);
        final recomendation = await getMovieRecommendations.execute(event.id);

        result.fold(
          (failure) {
            emit(state.copyWith(
              movieDetailState: RequestState.error,
              message: failure.message,
            ));
          },
          (detail) {
            emit(state.copyWith(
              movieRecommendationState: RequestState.loading,
              message: '',
              movieDetailState: RequestState.loaded,
              movieDetail: detail,
            ));
            recomendation.fold((failure) {
              emit(state.copyWith(
                movieRecommendationState: RequestState.error,
                message: failure.message,
              ));
            }, (recomended) {
              emit(state.copyWith(
                movieRecommendations: recomended,
                movieRecommendationState: RequestState.loaded,
                message: '',
              ));
            });
          },
        );
      },
    );
    on<AddWatchlist>(
      (event, emit) async {
        final result = await saveWatchlist.execute(event.movieDetail);

        result.fold(
          (failure) {
            emit(state.copyWith(watchlistMessage: failure.message));
          },
          (added) {
            emit(state.copyWith(
              watchlistMessage: watchListAdd,
            ));
          },
        );

        add(WatchlistStatus(event.movieDetail.id));
      },
    );
    on<EraseWatchlist>(
      (event, emit) async {
        final result = await removeWatchlist.execute(event.movieDetail);
        result.fold(
          (failure) {
            emit(state.copyWith(watchlistMessage: failure.message));
          },
          (added) {
            emit(state.copyWith(
              watchlistMessage: watchListRemove,
            ));
          },
        );
        add(WatchlistStatus(event.movieDetail.id));
      },
    );
    on<WatchlistStatus>(
      (event, emit) async {
        final result = await getWatchListStatus.execute(event.id);
        emit(state.copyWith(isAddedToWatchlist: result));
      },
    );
  }
}
