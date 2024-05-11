
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ngbuka/src/domain/data/statistics_for_quote.dart';
import 'package:ngbuka/src/domain/data/statistics_model.dart';
import 'package:ngbuka/src/domain/repository/mechanic_repository.dart';

final bookingDataProvider= FutureProvider<StatisticsModel>((ref) async{
  return ref.watch(allProvider).getBookingStatisticsInfo();
});

final quoteDataProvider= FutureProvider<StatisticsModelForQuote>((ref) async{
  return ref.watch(allProvider).getQuoteStatisticsInfo();
});

// class BookingStatisticsNotifier extends StateNotifier<StatisticsModel> {
//   final MechanicRepo _mechanicRepo;

//   BookingStatisticsNotifier(this._mechanicRepo) : super();

//   Future<void> updateBookingStatistics() async {
//     final statistics = await _mechanicRepo.getBookingStatisticsInfo();
//     state = statistics;
//   }
// }

// final bookingStatisticsProvider = StateNotifierProvider<BookingStatisticsNotifier, StatisticsModel>((ref) {
//   final mechanicRepo = ref.watch(allProvider);
//   return BookingStatisticsNotifier(mechanicRepo);
// });