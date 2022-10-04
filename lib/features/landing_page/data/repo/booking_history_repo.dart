import 'package:passenger/core/util/data_state.dart';
import 'package:passenger/features/landing_page/data/model/booking_history_model.dart';
import 'package:passenger/features/landing_page/data/model/booking_history_sort_by_time_model.dart';
import 'package:passenger/features/landing_page/data/model/like_request_model.dart';

abstract class BookingHistoryRepo {
  Future<DataState<BookingHistoryModel>> getListBookingHistory(
    String userId,
    int limit,
  );
  Future<DataState<BookingHistorySortByTimeModel>>
      getListBookingHistorySortByTime(String userId, int limit);
  Future<void> setLikeForBookingHistory({
    required LikeRequestModel body,
    required String id,
  });
}
