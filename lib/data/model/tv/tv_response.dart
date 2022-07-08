import 'package:ditonton_siapa/data/model/tv/tv_model.dart';
import 'package:equatable/equatable.dart';

class TvResponse extends Equatable {
  final List<TvSeriesModel> TvList;

  const TvResponse({required this.TvList});

  factory TvResponse.fromJson(Map<String, dynamic> json) => TvResponse(
        TvList: List<TvSeriesModel>.from((json['results'] as List)
            .map((e) => TvSeriesModel.fromJson(e))
            .where((element) => element.backdropPath != null)),
      );

  Map<String, dynamic> toJson() => {
        'results': List<dynamic>.from(TvList.map((e) => e.toJson())),
      };

  @override
  List<Object?> get props => [
        TvList,
      ];
}
