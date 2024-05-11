import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ngbuka/src/domain/repository/mechanic_repository.dart';

class BookingState {
  int? pending;
  int? declined;
  int? completed;
  int? accepted;
  int? rejected;
  int? bargaining;
  int? approved;
  int? disapproved;
  int? awaitingPayment;
  int? canceled;
  // Add other fields as needed

  BookingState({
    this.pending,
    this.declined,
    this.completed,
    this.accepted,
    this.rejected,
    this.bargaining,
    this.approved,
    this.disapproved,
    this.awaitingPayment,
    this.canceled,
  });
  // Add other constructors as needed
}

class BookingStateNotifier extends StateNotifier<BookingState> {
  BookingStateNotifier() : super(BookingState());

  static final MechanicRepo _mechanicRepo = MechanicRepo();

  void updateBookingState(BookingState newState) {
    state = newState;
  }

  getBookingStatisticsInfo() async {
    final value = await _mechanicRepo.getBookingStatisticsInfo();
    state = BookingState(
      pending: value.pENDING,
      declined: value.dECLINED,
      completed: value.cOMPLETED,
      accepted: value.aCCEPTED,
      rejected: value.rEJECTED,
      bargaining: value.bARGAINING,
      approved: value.aPPROVED,
      disapproved: value.dISAPPROVED,
      awaitingPayment: value.aWAITINGPAYMENT,
      canceled: value.cANCELED,
    );
  } 
}

final bookingStateProvider =
    StateNotifierProvider<BookingStateNotifier, BookingState>((ref) {
  return BookingStateNotifier();
});


class QuoteState {
  int? pending;
  int? declined;
  int? completed;
  int? accepted;
  int? rejected;
  int? bargaining;
  int? approved;
  int? disapproved;
  int? awaitingPayment;
  int? canceled;
  // Add other fields as needed

  QuoteState({
    this.pending,
    this.declined,
    this.completed,
    this.accepted,
    this.rejected,
    this.bargaining,
    this.approved,
    this.disapproved,
    this.awaitingPayment,
    this.canceled,
  });
  // Add other constructors as needed
}

class QuoteStateNotifier extends StateNotifier<QuoteState> {
  QuoteStateNotifier() : super(QuoteState());

  static final MechanicRepo _mechanicRepo = MechanicRepo();

  void updateQuoteState(QuoteState newState) {
    state = newState;
  }

  getQuoteStatisticsInfo() async {
    final value = await _mechanicRepo.getQuoteStatisticsInfo();
    state = QuoteState(
      pending: value.pENDING,
      declined: value.dECLINED,
      completed: value.cOMPLETED,
      accepted: value.aCCEPTED,
      rejected: value.rEJECTED,
      bargaining: value.bARGAINING,
      approved: value.aPPROVED,
      disapproved: value.dISAPPROVED,
      awaitingPayment: value.aWAITINGPAYMENT,
    );
  }
}

final quoteStateProvider =
    StateNotifierProvider<QuoteStateNotifier, QuoteState>((ref) {
  return QuoteStateNotifier();
});