import 'package:ditonton_siapa/presentation/bloc/tv/tv_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/tv/tv_state.dart';
import '../../bloc/tv/tv_top_rate.dart';
import '../../widgets/card_tv_list.dart';

class TvOnTheAirPage extends StatefulWidget {
  static const routeName = '/tv_on_the_air_page';

  const TvOnTheAirPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TvOnTheAirPageState createState() => _TvOnTheAirPageState();
}

class _TvOnTheAirPageState extends State<TvOnTheAirPage> {
  @override
  void initState() {
    super.initState();
    context.read<TopRatedTv>().add(OnListTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTv, StateTv>(
          builder: (context, state) {
            if (state is TvLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvHasData) {
              final movies = state.result;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return CardTvList(movie);
                },
                itemCount: movies.length,
              );
            } else {
              return const Center(
                child: Text('Failed to load Top Rated Tv'),
              );
            }
          },
        ),
      ),
    );
  }
}
