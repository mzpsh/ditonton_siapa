import 'package:ditonton_siapa/presentation/bloc/tv/tv_event.dart';
import 'package:ditonton_siapa/presentation/bloc/tv/tv_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecase/tv/get_tv_on_the_air.dart';

class ListTv extends Bloc<EventTv, StateTv> {
  final GetTvOnTheAir _getNowPlayingTv;

  ListTv(this._getNowPlayingTv) : super(TvEmpty()) {
    on<OnListTv>(
      (event, emit) async {
        emit(TvLoading());
        final result = await _getNowPlayingTv.execute();

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
