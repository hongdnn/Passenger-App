part of 'order_history_bloc.dart';

class OrderHistoryState {
  OrderHistoryState({
    this.historyBookingState,
    this.dataBooking,
    this.isLazyLoading,
    this.isLastPage = false,
    this.currentPage,
  });

  final LoadState? historyBookingState;
  final List<BookingData>? dataBooking;
  final bool? isLazyLoading;
  final bool isLastPage;
  final int? currentPage;

  OrderHistoryState copyWith({
    LoadState? historyBookingState,
    List<BookingData>? dataBooking,
    bool? isLazyLoading,
    bool? isLastPage,
    int? currentPage,
  }) {
    return OrderHistoryState(
      historyBookingState: historyBookingState ?? this.historyBookingState,
      dataBooking: dataBooking ?? this.dataBooking,
      isLazyLoading: isLazyLoading ?? this.isLazyLoading,
      isLastPage: isLastPage ?? this.isLastPage,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}
