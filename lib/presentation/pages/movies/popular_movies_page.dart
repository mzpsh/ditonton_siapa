import 'package:ditonton_siapa/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/movie/movie_event.dart';
import '../../bloc/movie/movie_popular.dart';
import '../../bloc/movie/movie_state.dart';

class PopularPage extends StatefulWidget {
  static const routeName = '/popular-movie';

  const PopularPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PopularPageState createState() => _PopularPageState();
}

class _PopularPageState extends State<PopularPage> {
  @override
  void initState() {
    super.initState();
    context.read<PopularMovie>().add(OnListMovie());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularMovie, StateMovie>(
          builder: (context, state) {
            if (state is MovieLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MovieHasData) {
              final data = state.result;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = data[index];
                  return MovieCard(movie);
                },
                itemCount: data.length,
              );
            } else {
              return const Center(
                child: Text('Failed to load popular movies'),
              );
            }
          },
        ),
      ),
    );
  }
}
