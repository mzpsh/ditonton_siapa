import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton_siapa/common/constants.dart';
import 'package:ditonton_siapa/domain/entities/movie.dart';
import 'package:ditonton_siapa/presentation/bloc/movie/movie_event.dart';
import 'package:ditonton_siapa/presentation/bloc/movie/movie_list.dart';
import 'package:ditonton_siapa/presentation/bloc/movie/movie_popular.dart';
import 'package:ditonton_siapa/presentation/bloc/movie/movie_state.dart';
import 'package:ditonton_siapa/presentation/bloc/movie/movie_top_rate.dart';
import 'package:ditonton_siapa/presentation/pages/about_page.dart';
import 'package:ditonton_siapa/presentation/pages/movies/movie_detail_page.dart';
import 'package:ditonton_siapa/presentation/pages/movies/popular_movies_page.dart';
import 'package:ditonton_siapa/presentation/pages/movies/search_movie_page.dart';
import 'package:ditonton_siapa/presentation/pages/movies/top_rated_movies_page.dart';
import 'package:ditonton_siapa/presentation/pages/movies/watchlist_movies_page.dart';
import 'package:ditonton_siapa/presentation/pages/tv/tv_page.dart';
import 'package:ditonton_siapa/presentation/pages/tv/watchlist_tv_page.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/movie_home';
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<ListMovie>().add(OnListMovie());
    context.read<PopularMovie>().add(OnListMovie());
    context.read<TopRatedMovie>().add(OnListMovie());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/images/circle-g.png'),
              ),
              accountName: Text('Galih Sansabila'),
              accountEmail: Text('galih@dicoding.com'),
            ),
            ListTile(
              leading: const Icon(Icons.movie_outlined),
              title: const Text('Movies'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.tv_outlined),
              title: const Text('TV'),
              onTap: () {
                Navigator.pushNamed(context, TvPage.routeName);
              },
            ),
            ListTile(
              leading: const Icon(Icons.save_alt),
              title: const Text('Watchlist Movies'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
              },
            ),
            ListTile(
              leading: const Icon(Icons.save_alt),
              title: const Text('Watchlist TV Series'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistTvPage.ROUTE_NAME);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outlined),
              title: const Text('About'),
              onTap: () {
                Navigator.pushNamed(context, AboutPage.routeName);
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Ditonton Siapa?'),
        actions: [
          IconButton(
            onPressed: () {
              //FirebaseCrashlytics.instance.crash();
              Navigator.pushNamed(context, SearchMoviesPage.ROUTE_NAME);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              BlocBuilder<ListMovie, StateMovie>(
                builder: (context, state) {
                  if (state is MovieLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is MovieHasData) {
                    final movie = state.result;
                    return MovieList(movie);
                  } else if (state is MovieError) {
                    final movie = state.message;
                    return (Center(
                      child: Text(movie),
                    ));
                  } else {
                    return (const Center(
                      child: Text("Failed to load movies"),
                    ));
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularPage.routeName),
              ),
              BlocBuilder<PopularMovie, StateMovie>(
                builder: (context, state) {
                  if (state is MovieLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is MovieHasData) {
                    final movie = state.result;
                    return MovieList(movie);
                  } else if (state is MovieError) {
                    final movie = state.message;
                    return (Center(
                      child: Text(movie),
                    ));
                  } else {
                    return (const Center(
                      child: Text("Failed to load movies"),
                    ));
                  }
                },
              ),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedMoviesPage.routeName),
              ),
              BlocBuilder<TopRatedMovie, StateMovie>(
                builder: (context, state) {
                  if (state is MovieLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is MovieHasData) {
                    final movie = state.result;
                    return MovieList(movie);
                  } else if (state is MovieError) {
                    final movie = state.message;
                    return (Center(
                      child: Text(movie),
                    ));
                  } else {
                    return (const Center(
                      child: Text("Failed to load movies"),
                    ));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  // ignore: use_key_in_widget_constructors
  const MovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.routeName,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
