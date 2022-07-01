import 'package:ditonton_siapa/common/constants.dart';
import 'package:ditonton_siapa/common/utils.dart';
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
import 'package:ditonton_siapa/presentation/pages/about_page.dart';
import 'package:ditonton_siapa/presentation/pages/movies/search_movie_page.dart';
import 'package:ditonton_siapa/presentation/pages/movies/watchlist_movies_page.dart';
import 'package:ditonton_siapa/presentation/pages/splashscreen.dart';
import 'package:ditonton_siapa/presentation/pages/movies/top_rated_movies_page.dart';
import 'package:ditonton_siapa/presentation/pages/tv/airing_today_page.dart';
import 'package:ditonton_siapa/presentation/pages/tv/popular_tv_page.dart';
import 'package:ditonton_siapa/presentation/pages/tv/search_tv_page.dart';
import 'package:ditonton_siapa/presentation/pages/tv/tv_detail_page.dart';
import 'package:ditonton_siapa/presentation/pages/tv/tv_on_the_air_page.dart';
import 'package:ditonton_siapa/presentation/pages/tv/tv_page.dart';
import 'package:ditonton_siapa/presentation/pages/tv/watchlist_tv_page.dart';
import 'package:ditonton_siapa/presentation/pages/movies/movie_detail_page.dart';
import 'package:ditonton_siapa/presentation/pages/movies/home_movie_page.dart';
import 'package:ditonton_siapa/presentation/pages/movies/popular_movies_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton_siapa/injection.dart' as di;
import 'package:provider/provider.dart';

import 'common/ssl_pinning/http_ssl_pinning.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HttpSSLPinning.init();
  await Firebase.initializeApp();

  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(create: (_) => di.locator<ListMovie>()),
        BlocProvider(create: (_) => di.locator<PopularMovie>()),
        BlocProvider(create: (_) => di.locator<TopRatedMovie>()),
        BlocProvider(create: (_) => di.locator<DetailBlocMovie>()),
        BlocProvider(create: (_) => di.locator<WatchlistBlocMovie>()),
        BlocProvider(create: (_) => di.locator<SearchBlocMovie>()),
        BlocProvider(create: (_) => di.locator<ListTv>()),
        BlocProvider(create: (_) => di.locator<DetailBlocTv>()),
        BlocProvider(create: (_) => di.locator<PopularTv>()),
        BlocProvider(create: (_) => di.locator<TopRatedTv>()),
        BlocProvider(create: (_) => di.locator<SearchBlocTv>()),
        BlocProvider(create: (_) => di.locator<WatchlistBlocTv>()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
          colorScheme: kColorScheme.copyWith(secondary: kMikadoYellow),
        ),
        home: const SplashScreen(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case HomePage.routeName:
              return MaterialPageRoute(builder: (_) => const HomePage());
            case MovieDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                  builder: (_) => MovieDetailPage(id: id), settings: settings);
            case TvDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                  builder: (_) => TvDetailPage(id: id), settings: settings);
            case PopularPage.routeName:
              return MaterialPageRoute(builder: (_) => const PopularPage());
            case TopRatedMoviesPage.routeName:
              return MaterialPageRoute(
                  builder: (_) => const TopRatedMoviesPage());
            case TvOnTheAirPage.routeName:
              return MaterialPageRoute(builder: (_) => const TvOnTheAirPage());
            case AiringTodayPage.routeName:
              return MaterialPageRoute(builder: (_) => const AiringTodayPage());
            case PopularTvPage.routeName:
              return MaterialPageRoute(builder: (_) => const PopularTvPage());
            case AboutPage.routeName:
              return MaterialPageRoute(builder: (_) => const AboutPage());
            case SearchMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => SearchMoviesPage());
            case SearchTvPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => SearchTvPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case WatchlistTvPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistTvPage());
            case TvPage.routeName:
              return MaterialPageRoute(builder: (_) => const TvPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return const Scaffold(
                  body: Center(
                    child: Text('Page not found!'),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
