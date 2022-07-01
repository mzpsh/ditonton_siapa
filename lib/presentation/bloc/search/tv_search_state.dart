import 'package:ditonton_siapa/domain/entities/tv/tv.dart';
import 'package:equatable/equatable.dart';

abstract class SearchStateTv extends Equatable {
  const SearchStateTv();

  @override
  List<Object> get props => [];
}

class SearchTvEmpty extends SearchStateTv {}

class SearchTvLoading extends SearchStateTv {}

class SearchTvError extends SearchStateTv {
  final String data;

  const SearchTvError(this.data);

  @override
  List<Object> get props => [data];
}

class SearchTvHasData extends SearchStateTv {
  final List<Tv> result;

  const SearchTvHasData(this.result);

  @override
  List<Object> get props => [result];
}
