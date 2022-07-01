// import 'package:ditonton_siapa/common/state_enum.dart';
// import 'package:ditonton_siapa/common/utils.dart';
// import 'package:ditonton_siapa/presentation/provider/watchlist_movie_notifier.dart';
// import 'package:ditonton_siapa/presentation/widgets/card_list.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class WatchlistPage extends StatefulWidget {
//   static const routeName = '/watchlist';
//   const WatchlistPage({Key? key}) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _WatchlistPageState createState() => _WatchlistPageState();
// }

// class _WatchlistPageState extends State<WatchlistPage> with RouteAware {
//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(() =>
//         Provider.of<WatchlistMovieNotifier>(context, listen: false)
//             .fetchWatchlistMovies());
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     routeObserver.subscribe(this, ModalRoute.of(context)!);
//   }

//   @override
//   void didPopNext() {
//     Provider.of<WatchlistMovieNotifier>(context, listen: false)
//         .fetchWatchlistMovies();
//   }

//   @override
//   void dispose() {
//     routeObserver.unsubscribe(this);
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8),
//       child: Consumer<WatchlistMovieNotifier>(
//         builder: (context, data, child) {
//           if (data.watchlistState == RequestState.loading) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (data.watchlistState == RequestState.loaded) {
//             return ListView.builder(
//               itemCount: data.watchlistMovie.length,
//               itemBuilder: (context, index) {
//                 final movie = data.watchlistMovie[index];
//                 return CardList(movie);
//               },
//             );
//           } else {
//             return Center(
//               key: const Key('error_message'),
//               child: Text(data.message),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
