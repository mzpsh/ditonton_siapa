import 'package:equatable/equatable.dart';

import '../../../../common/state_enum.dart';
import '../../../../domain/entities/tv/tv.dart';
import '../../../../domain/entities/tv/tv_detail.dart';

class DetailStateTv extends Equatable {
  final TvDetail? tvDetail;
  final List<Tv> tvRecommendations;
  final RequestState tvDetailState;
  final RequestState tvRecommendationState;
  final String message;
  final String watchlistMessage;
  final bool isAddedToWatchlist;

  const DetailStateTv({
    required this.tvDetail,
    required this.tvRecommendations,
    required this.tvDetailState,
    required this.tvRecommendationState,
    required this.message,
    required this.watchlistMessage,
    required this.isAddedToWatchlist,
  });

  DetailStateTv copyWith({
    TvDetail? tvDetail,
    List<Tv>? tvRecommendations,
    RequestState? tvDetailState,
    RequestState? tvRecommendationState,
    String? message,
    String? watchlistMessage,
    bool? isAddedToWatchlist,
  }) {
    return DetailStateTv(
      tvDetail: tvDetail ?? this.tvDetail,
      tvRecommendations: tvRecommendations ?? this.tvRecommendations,
      tvDetailState: tvDetailState ?? this.tvDetailState,
      tvRecommendationState:
          tvRecommendationState ?? this.tvRecommendationState,
      message: message ?? this.message,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
    );
  }

  factory DetailStateTv.initial() {
    return const DetailStateTv(
      tvDetail: null,
      tvRecommendations: [],
      tvDetailState: RequestState.empty,
      tvRecommendationState: RequestState.empty,
      message: '',
      watchlistMessage: '',
      isAddedToWatchlist: false,
    );
  }

  @override
  List<Object?> get props => [
        tvDetail,
        tvRecommendations,
        tvDetailState,
        tvRecommendationState,
        message,
        watchlistMessage,
        isAddedToWatchlist,
      ];
}
