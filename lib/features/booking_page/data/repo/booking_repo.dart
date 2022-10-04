import 'package:passenger/core/util/data_state.dart';
import 'package:passenger/features/booking_page/data/model/booking_order_model.dart';
import 'package:passenger/features/booking_page/data/model/cancel_booking_model.dart';
import 'package:passenger/features/booking_page/data/model/price_by_cartype_model.dart';
import 'package:passenger/features/booking_page/data/model/search_driver_for_booking_model.dart';
import 'package:passenger/features/booking_page/data/model/upsert_draft_booking_model.dart';

abstract class BookingRepository {
  Future<DataState<PriceByCarTypeModel>> getDriverList({
    required GetPriceRequestBody getPriceRequestBody,
  });

  Future<DataState<UpsertDraftBookingModel>> upsertDraftBooking({
    required UpsertRequestBody body,
  });

  Future<DataState<BookingOrderModel>> createBookingOrder({
    required ConfirmBookingRequestModel body,
  });
  Future<DataState<SearchDriverForBookingModel>> searchDriverForBooking({
    required SearchDriverForBookingResponse body,
  });

  Future<DataState<CancelBookingModel>> cancelBookingOrder({
    required CancelBookingBody body,
  });

}
