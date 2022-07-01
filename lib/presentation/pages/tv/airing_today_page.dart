import 'package:ditonton_siapa/presentation/widgets/card_tv_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/tv/tv_event.dart';
import '../../bloc/tv/tv_state.dart';
import '../../bloc/tv/tv_top_rate.dart';

class AiringTodayPage extends StatefulWidget {
  static const routeName = '/airing_today_page';
  const AiringTodayPage({Key? key}) : super(key: key);

  @override
  State<AiringTodayPage> createState() => _AiringTodayPageState();
}

class _AiringTodayPageState extends State<AiringTodayPage> {
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
