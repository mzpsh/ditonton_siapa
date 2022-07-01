import 'package:ditonton_siapa/domain/entities/genre.dart';
import 'package:ditonton_siapa/domain/entities/tv/tv.dart';
import 'package:ditonton_siapa/domain/entities/tv/tv_detail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../../common/constants.dart';
import '../../../common/state_enum.dart';
import '../../bloc/tv/tv_detail/tv_detail_bloc.dart';
import '../../bloc/tv/tv_detail/tv_detail_event.dart';
import '../../bloc/tv/tv_detail/tv_detail_state.dart';

class TvDetailPage extends StatefulWidget {
  static const routeName = '/page_detail_tv';
  final int id;
  const TvDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TvDetailPageState createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<DetailBlocTv>(context, listen: false)
          .add(OnDetailList(widget.id));
      Provider.of<DetailBlocTv>(context, listen: false)
          .add(WatchlistStatus(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<DetailBlocTv, DetailStateTv>(
      listener: (context, state) async {
        if (state.watchlistMessage == DetailBlocTv.watchListAdd ||
            state.watchlistMessage == DetailBlocTv.watchListRemove) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.watchlistMessage),
          ));
        } else {
          await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(state.watchlistMessage),
                );
              });
        }
      },
      listenWhen: (previousState, currentState) =>
          previousState.watchlistMessage != currentState.watchlistMessage &&
          currentState.watchlistMessage != '',
      builder: (context, state) {
        if (state.tvDetailState == RequestState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.tvDetailState == RequestState.loaded &&
            state.tvRecommendations != []) {
          final tv = state.tvDetail!;
          return SafeArea(
            child: DetailContent(
              tv,
              state.tvRecommendations,
              state.isAddedToWatchlist,
            ),
          );
        } else if (state.tvDetailState == RequestState.error) {
          final result = state.message;
          return Text(result);
        } else {
          return const Text('Failed');
        }
      },
    ));
  }
}

class DetailContent extends StatelessWidget {
  final TvDetail movie;
  final List<Tv> recommendations;
  final bool isAddedWatchlist;

  const DetailContent(this.movie, this.recommendations, this.isAddedWatchlist);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.name,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!isAddedWatchlist) {
                                  context
                                      .read<DetailBlocTv>()
                                      .add(AddWatchlist(movie));
                                } else {
                                  context
                                      .read<DetailBlocTv>()
                                      .add(EraseWatchlist(movie));
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlist
                                      ? const Icon(Icons.check)
                                      : const Icon(Icons.add),
                                  const Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(movie.genres),
                            ),
                            // Text(
                            //   _formattedDuration(movie.episodeRunTime),
                            // ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: movie.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${movie.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              movie.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            SizedBox(
                              height: 150,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final movie = recommendations[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushReplacementNamed(
                                          context,
                                          TvDetailPage.routeName,
                                          arguments: movie.id,
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                          placeholder: (context, url) =>
                                              const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: recommendations.length,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}
