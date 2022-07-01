import 'package:equatable/equatable.dart';

import '../../../domain/entities/tv/tv.dart';

abstract class StateTv extends Equatable {
  const StateTv();

  @override
  List<Object> get props => [];
}

class TvEmpty extends StateTv {}

class TvLoading extends StateTv {}

class TvError extends StateTv {
  final String message;

  const TvError(this.message);

  @override
  List<Object> get props => [message];
}

class TvHasData extends StateTv {
  final List<Tv> result;

  const TvHasData(this.result);

  @override
  List<Object> get props => [result];
}
