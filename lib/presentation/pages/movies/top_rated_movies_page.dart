import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/movie/movie_event.dart';
import '../../bloc/movie/movie_state.dart';
import '../../bloc/movie/movie_top_rate.dart';
import '../../widgets/movie_card_list.dart';

class TopRatedMoviesPage extends StatefulWidget {
  static const routeName = '/top_rated_movies_page';

  const TopRatedMoviesPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();
    context.read<TopRatedMovie>().add(OnListMovie());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedMovie, StateMovie>(
          builder: (context, state) {
            if (state is MovieLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MovieHasData) {
              final movies = state.result;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return MovieCard(movie);
                },
                itemCount: movies.length,
              );
            } else {
              return const Center(
                child: Text('Failed to load Top Rated Movies'),
              );
            }
          },
        ),
      ),
    );
  }
}
