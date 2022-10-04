part of 'order_history_bloc.dart';

abstract class OrderHistoryEvent {}

class GetBookingHistoryEvent extends OrderHistoryEvent {
  GetBookingHistoryEvent({
    required this.status,
    this.isLazyLoading,
  });

  final int status;
  final bool? isLazyLoading;
}

class GetBookingHistoryInitEvent extends OrderHistoryEvent {
  GetBookingHistoryInitEvent({
    required this.status,
  });

  final int status;
}

class GetNextPageListBookingEvent extends OrderHistoryEvent {}
