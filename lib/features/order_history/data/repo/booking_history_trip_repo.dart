import 'package:passenger/core/util/data_state.dart';
import 'package:passenger/features/order_history/data/model/booking_history_trip_model.dart';

abstract class BookingHistoryTripRepo {
  Future<DataState<BookingHistoryTripModel>> getBookingHistory(
    String userId,
    int status,
    int page,
    int pageSize,
  );
}
