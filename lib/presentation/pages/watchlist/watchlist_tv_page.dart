// import 'package:ditonton_siapa/common/utils.dart';
// import 'package:ditonton_siapa/presentation/widgets/card_tv_list.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../../common/state_enum.dart';
// import '../../provider/tv/watchlist_tv_notifier.dart';

// class WatchlistTvPage extends StatefulWidget {
//   static const routeName = '/watchlist_tv_page';
//   const WatchlistTvPage({Key? key}) : super(key: key);

//   @override
//   State<WatchlistTvPage> createState() => _WatchlistTvPageState();
// }

// class _WatchlistTvPageState extends State<WatchlistTvPage> with RouteAware {
//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(() =>
//         Provider.of<WatchlistTvNotifier>(context, listen: false)
//             .fetchWatchlistTv());
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     routeObserver.subscribe(this, ModalRoute.of(context)!);
//   }

//   @override
//   void didPopNext() {
//     super.didPopNext();
//     Provider.of<WatchlistTvNotifier>(context, listen: false).fetchWatchlistTv();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     routeObserver.unsubscribe(this);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8),
//       child: Consumer<WatchlistTvNotifier>(
//         builder: (context, data, child) {
//           if (data.watchlistStateTv == RequestState.loading) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (data.watchlistStateTv == RequestState.loaded) {
//             return ListView.builder(
//               itemCount: data.watchlistTv.length,
//               itemBuilder: (context, index) {
//                 final movie = data.watchlistTv[index];
//                 return CardTvList(movie);
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
