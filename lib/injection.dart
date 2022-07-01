import 'package:ditonton_siapa/data/datasources/db/database_helper.dart';
import 'package:ditonton_siapa/data/datasources/db/database_helper_tv.dart';
import 'package:ditonton_siapa/data/datasources/local/local_data_source.dart';
import 'package:ditonton_siapa/data/datasources/local/tv/local_data_source_tv.dart';
import 'package:ditonton_siapa/data/datasources/remote/remote_data_source.dart';
import 'package:ditonton_siapa/data/repositories/movie_repository_impl.dart';
import 'package:ditonton_siapa/data/repositories/tv_repository_impl.dart';
import 'package:ditonton_siapa/domain/repositories/movie_respository.dart';
import 'package:ditonton_siapa/domain/usecase/get_detail_movie.dart';
import 'package:ditonton_siapa/domain/usecase/get_now_playing_movies.dart';
import 'package:ditonton_siapa/domain/usecase/get_popular_movies.dart';
import 'package:ditonton_siapa/domain/usecase/get_recommended_movie.dart';
import 'package:ditonton_siapa/domain/usecase/get_top_rated_movies.dart';
import 'package:ditonton_siapa/domain/usecase/get_watchlist_movies.dart';
import 'package:ditonton_siapa/domain/usecase/get_watchlist_status.dart';
import 'package:ditonton_siapa/domain/usecase/remove_watchlist.dart';
import 'package:ditonton_siapa/domain/usecase/save_watchlist.dart';
import 'package:ditonton_siapa/domain/usecase/search_movies.dart';
import 'package:ditonton_siapa/domain/usecase/tv/get_tv_airing_today.dart';
import 'package:ditonton_siapa/domain/usecase/tv/get_tv_detail.dart';
import 'package:ditonton_siapa/domain/usecase/tv/get_tv_on_the_air.dart';
import 'package:ditonton_siapa/domain/usecase/tv/get_tv_popular.dart';
import 'package:ditonton_siapa/domain/usecase/tv/get_tv_top_rated.dart';
import 'package:ditonton_siapa/domain/usecase/tv/get_watchlist_status_tv.dart';
import 'package:ditonton_siapa/domain/usecase/tv/get_watchlist_tv.dart';
import 'package:ditonton_siapa/domain/usecase/tv/remove_watchlist_tv.dart';
import 'package:ditonton_siapa/domain/usecase/tv/save_watchlist_tv.dart';
import 'package:ditonton_siapa/domain/usecase/tv/search_tv.dart';
import 'package:ditonton_siapa/presentation/bloc/movie/detail/movie_detail_bloc.dart';
import 'package:ditonton_siapa/presentation/bloc/movie/movie_list.dart';
import 'package:ditonton_siapa/presentation/bloc/movie/movie_popular.dart';
import 'package:ditonton_siapa/presentation/bloc/movie/movie_top_rate.dart';
import 'package:ditonton_siapa/presentation/bloc/movie/watchlist/movie_watchlist_bloc.dart';
import 'package:ditonton_siapa/presentation/bloc/search/movie_search_bloc.dart';
import 'package:ditonton_siapa/presentation/bloc/search/tv_search_bloc.dart';
import 'package:ditonton_siapa/presentation/bloc/tv/tv_detail/tv_detail_bloc.dart';
import 'package:ditonton_siapa/presentation/bloc/tv/tv_list.dart';
import 'package:ditonton_siapa/presentation/bloc/tv/tv_popular.dart';
import 'package:ditonton_siapa/presentation/bloc/tv/tv_top_rate.dart';
import 'package:ditonton_siapa/presentation/bloc/tv/tv_watchlist/tv_watchlist_bloc.dart';
//import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'domain/repositories/tv_repository.dart';
import 'domain/usecase/tv/get_recommendations_tv.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => ListMovie(
      locator(),
    ),
  );
  locator.registerFactory(
    () => ListTv(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMovie(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTv(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMovie(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTv(
      locator(),
    ),
  );
  locator.registerFactory(
    () => DetailBlocMovie(
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerFactory(
    () => DetailBlocTv(
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );

  locator.registerFactory(
    () => WatchlistBlocMovie(
      locator(),
    ),
  );

  locator.registerFactory(
    () => WatchlistBlocTv(
      locator(),
    ),
  );
  locator.registerFactory(
    () => SearchBlocMovie(
      locator(),
    ),
  );
  locator.registerFactory(
    () => SearchBlocTv(
      locator(),
    ),
  );

  ///use case movie
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));

  ///
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => SearchTv(locator()));

  ///use case tv
  locator.registerLazySingleton(() => GetTvAiringToday(locator()));
  locator.registerLazySingleton(() => GetTvOnTheAir(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvPopular(locator()));
  locator.registerLazySingleton(() => GetTvTopRated(locator()));
  locator.registerLazySingleton(() => GetRecommendationsTv(locator()));

  ///watchlist movie
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  ///watchlist tv
  locator.registerLazySingleton(() => GetWatchlistStatusTv(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTv(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTv(locator()));
  locator.registerLazySingleton(() => GetWatchlistTv(locator()));

  ///repository movie
  locator.registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(
        remoteDataSource: locator(),
        localDataSource: locator(),
      ));

  ///repository tv
  locator.registerLazySingleton<TvRepository>(() => TvRepositoryImpl(
        remoteDataSource: locator(),
        tvLocalDataSource: locator(),
        //networkInfo: locator(),
      ));

  ///data source
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
      () => TvLocalDataSourceImpl(databaseHelperTv: locator()));

  ///helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
  locator.registerLazySingleton<DatabaseHelperTv>(() => DatabaseHelperTv());

  ///external
  locator.registerLazySingleton(() => http.Client());
}
