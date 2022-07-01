import 'package:ditonton_siapa/presentation/bloc/tv/tv_event.dart';
import 'package:ditonton_siapa/presentation/bloc/tv/tv_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecase/tv/get_tv_popular.dart';

class PopularTv extends Bloc<EventTv, StateTv> {
  final GetTvPopular _getPopularTv;

  PopularTv(this._getPopularTv) : super(TvEmpty()) {
    on<OnListTv>(
      (event, emit) async {
        emit(TvLoading());
        final result = await _getPopularTv.execute();

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
