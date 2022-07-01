import 'package:ditonton_siapa/presentation/widgets/card_tv_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/tv/tv_event.dart';
import '../../bloc/tv/tv_popular.dart';
import '../../bloc/tv/tv_state.dart';

class PopularTvPage extends StatefulWidget {
  static const routeName = '/popular_tv_page';
  const PopularTvPage({Key? key}) : super(key: key);

  @override
  State<PopularTvPage> createState() => _PopularTvPageState();
}

class _PopularTvPageState extends State<PopularTvPage> {
  @override
  void initState() {
    super.initState();
    context.read<PopularTv>().add(OnListTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTv, StateTv>(
          builder: (context, state) {
            if (state is TvLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvHasData) {
              final data = state.result;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = data[index];
                  return CardTvList(tv);
                },
                itemCount: data.length,
              );
            } else {
              return const Center(
                child: Text('Failed to load popular Tv'),
              );
            }
          },
        ),
      ),
    );
  }
}
