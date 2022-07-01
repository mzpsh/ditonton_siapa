import 'package:bloc/bloc.dart';
import 'package:ditonton_siapa/common/state_enum.dart';
import 'package:ditonton_siapa/domain/usecase/get_watchlist_status.dart';
import 'package:ditonton_siapa/domain/usecase/tv/get_recommendations_tv.dart';
import 'package:ditonton_siapa/domain/usecase/tv/get_tv_detail.dart';
import 'package:ditonton_siapa/domain/usecase/tv/remove_watchlist_tv.dart';
import 'package:ditonton_siapa/domain/usecase/tv/save_watchlist_tv.dart';
import 'package:ditonton_siapa/presentation/bloc/tv/tv_detail/tv_detail_event.dart';
import 'package:ditonton_siapa/presentation/bloc/tv/tv_detail/tv_detail_state.dart';

class DetailBlocTv extends Bloc<DetailEventTv, DetailStateTv> {
  final GetTvDetail getTvDetail;
  final GetRecommendationsTv getTvRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlistTv saveWatchlist;
  final RemoveWatchlistTv removeWatchlist;

  static const watchListAdd = 'Added to Watchlist';
  static const watchListRemove = 'Removed from Watchlist';

  DetailBlocTv(this.getTvDetail, this.getTvRecommendations,
      this.getWatchListStatus, this.saveWatchlist, this.removeWatchlist)
      : super(DetailStateTv.initial()) {
    on<OnDetailList>(
      (event, emit) async {
        emit(state.copyWith(
          tvDetailState: RequestState.loading,
        ));
        final result = await getTvDetail.execute(event.id);
        final recomendation = await getTvRecommendations.execute(event.id);

        result.fold(
          (failure) {
            emit(state.copyWith(
              tvDetailState: RequestState.error,
              message: failure.message,
            ));
          },
          (detail) {
            emit(state.copyWith(
              tvRecommendationState: RequestState.loading,
              message: '',
              tvDetailState: RequestState.loaded,
              tvDetail: detail,
            ));
            recomendation.fold((failure) {
              emit(state.copyWith(
                tvRecommendationState: RequestState.error,
                message: failure.message,
              ));
            }, (recomended) {
              emit(state.copyWith(
                tvRecommendations: recomended,
                tvRecommendationState: RequestState.loaded,
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
