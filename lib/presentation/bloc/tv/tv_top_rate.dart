import 'package:ditonton_siapa/presentation/bloc/tv/tv_event.dart';
import 'package:ditonton_siapa/presentation/bloc/tv/tv_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecase/tv/get_tv_top_rated.dart';

class TopRatedTv extends Bloc<EventTv, StateTv> {
  final GetTvTopRated _getTopRatedTv;

  TopRatedTv(this._getTopRatedTv) : super(TvEmpty()) {
    on<OnListTv>(
      (event, emit) async {
        emit(TvLoading());
        final result = await _getTopRatedTv.execute();

        result.fold(
          (failure) {
            emit(TvError(failure.message));
          },
          (data) {
            emit(TvHasData(data));
          },
        );
      },
    );
  }
}
