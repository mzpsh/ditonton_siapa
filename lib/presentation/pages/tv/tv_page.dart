import 'package:ditonton_siapa/presentation/pages/movies/home_movie_page.dart';
import 'package:ditonton_siapa/presentation/pages/movies/watchlist_movies_page.dart';
import 'package:ditonton_siapa/presentation/pages/tv/popular_tv_page.dart';
import 'package:ditonton_siapa/presentation/pages/tv/search_tv_page.dart';
import 'package:ditonton_siapa/presentation/pages/tv/tv_detail_page.dart';
import 'package:ditonton_siapa/presentation/pages/tv/tv_on_the_air_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton_siapa/presentation/pages/tv/watchlist_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/constants.dart';
import '../../../domain/entities/tv/tv.dart';
import '../../bloc/tv/tv_event.dart';
import '../../bloc/tv/tv_list.dart';
import '../../bloc/tv/tv_popular.dart';
import '../../bloc/tv/tv_state.dart';
import '../../bloc/tv/tv_top_rate.dart';
import '../about_page.dart';

class TvPage extends StatefulWidget {
  static const routeName = '/tv_home';

  const TvPage({Key? key}) : super(key: key);

  @override
  _TvPageState createState() => _TvPageState();
}

class _TvPageState extends State<TvPage> {
  @override
  void initState() {
    super.initState();
    context.read<ListTv>().add(OnListTv());
    context.read<PopularTv>().add(OnListTv());
    context.read<TopRatedTv>().add(OnListTv());
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
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: const Icon(Icons.movie),
              title: const Text('Movies'),
              onTap: () {
                Navigator.pushNamed(context, HomePage.routeName);
              },
            ),
            ListTile(
              leading: const Icon(Icons.tv_sharp),
              title: const Text('TV Series'),
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
              onTap: () {
                Navigator.pushNamed(context, AboutPage.routeName);
              },
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchTvPage.ROUTE_NAME);
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
              BlocBuilder<ListTv, StateTv>(
                builder: (context, state) {
                  if (state is TvLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TvHasData) {
                    final tv = state.result;
                    return TvList(tv);
                  } else if (state is TvError) {
                    final tv = state.message;
                    return (Center(
                      child: Text(tv),
                    ));
                  } else {
                    return (const Center(
                      child: Text("Failed to load tv series"),
                    ));
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularTvPage.routeName),
              ),
              BlocBuilder<PopularTv, StateTv>(
                builder: (context, state) {
                  if (state is TvLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TvHasData) {
                    final tv = state.result;
                    return TvList(tv);
                  } else if (state is TvError) {
                    final tv = state.message;
                    return (Center(
                      child: Text(tv),
                    ));
                  } else {
                    return (const Center(
                      child: Text("Failed to load tv series"),
                    ));
                  }
                },
              ),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TvOnTheAirPage.routeName),
              ),
              BlocBuilder<TopRatedTv, StateTv>(
                builder: (context, state) {
                  if (state is TvLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TvHasData) {
                    final movie = state.result;
                    return TvList(movie);
                  } else if (state is TvError) {
                    final movie = state.message;
                    return (Center(
                      child: Text(movie),
                    ));
                  } else {
                    return (const Center(
                      child: Text("Failed to load top rated tv"),
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

class TvList extends StatelessWidget {
  final List<Tv> movies;

  const TvList(this.movies);

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
                  TvDetailPage.routeName,
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
