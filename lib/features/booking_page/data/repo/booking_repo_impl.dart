import 'package:dio/dio.dart';
import 'package:passenger/core/network/rh_base_api.dart';
import 'package:passenger/features/booking_page/data/model/booking_order_model.dart';
import 'package:passenger/features/booking_page/data/model/cancel_booking_model.dart';
import 'package:passenger/features/booking_page/data/model/price_by_cartype_model.dart';
import 'package:passenger/features/booking_page/data/model/search_driver_for_booking_model.dart';
import 'package:passenger/features/booking_page/data/model/upsert_draft_booking_model.dart';
import 'package:passenger/features/booking_page/data/repo/booking_repo.dart';
import '../../../../core/util/data_state.dart';

class BookingRepositoryImpl extends BookingRepository {
  BookingRepositoryImpl(this._baseApi);

  final RhBaseApi _baseApi;

  @override
  Future<DataState<PriceByCarTypeModel>> getDriverList({
    required GetPriceRequestBody getPriceRequestBody,
  }) async {
    try {
      final PriceByCarTypeModel result =
          await _baseApi.getPriceByCarType(getPriceRequestBody);
      return DataSuccess<PriceByCarTypeModel>(result);
    } on DioError catch (e) {
      final PriceByCarTypeModel value = PriceByCarTypeModel.fromJson(
        e.response?.data as Map<String, dynamic>,
      );
      return DataSuccess<PriceByCarTypeModel>(value);
    } on Exception catch (e) {
      return DataFailed<PriceByCarTypeModel>(e);
    }
  }

  @override
  Future<DataState<UpsertDraftBookingModel>> upsertDraftBooking({
    required UpsertRequestBody body,
  }) async {
    try {
      final UpsertDraftBookingModel result =
          await _baseApi.upsertDraftBooking(bodyRequest: body);
      return DataSuccess<UpsertDraftBookingModel>(result);
    } on DioError catch (e) {
      final UpsertDraftBookingModel value = UpsertDraftBookingModel.fromJson(
        e.response?.data as Map<String, dynamic>,
      );
      return DataSuccess<UpsertDraftBookingModel>(value);
    } on Exception catch (e) {
      return DataFailed<UpsertDraftBookingModel>(e);
    }
  }

  @override
  Future<DataState<BookingOrderModel>> createBookingOrder({
    required ConfirmBookingRequestModel body,
  }) async {
    try {
      final BookingOrderModel result =
          await _baseApi.createBooking(bodyRequest: body);
      return DataSuccess<BookingOrderModel>(result);
    } on DioError catch (e) {
      final BookingOrderModel value = BookingOrderModel.fromJson(
        e.response?.data as Map<String, dynamic>,
      );
      return DataSuccess<BookingOrderModel>(value);
    } on Exception catch (e) {
      return DataFailed<BookingOrderModel>(e);
    }
  }

  @override
  Future<DataState<CancelBookingModel>> cancelBookingOrder({
    required CancelBookingBody body,
  }) async {
    try {
      final CancelBookingModel result =
          await _baseApi.cancelBooking(bodyRequest: body);
      return DataSuccess<CancelBookingModel>(result);
    } on DioError catch (e) {
      final CancelBookingModel value = CancelBookingModel.fromJson(
        e.response?.data as Map<String, dynamic>,
      );
      return DataSuccess<CancelBookingModel>(value);
    } on Exception catch (e) {
      return DataFailed<CancelBookingModel>(e);
    }
  }

  @override
  Future<DataState<SearchDriverForBookingModel>> searchDriverForBooking({
    required SearchDriverForBookingResponse body,
  }) async {
    try {
      final SearchDriverForBookingModel result = await _baseApi
          .searchDriverForBooking(searchDriverForBookingResponse: body);
      return DataSuccess<SearchDriverForBookingModel>(result);
    } on DioError catch (e) {
      final SearchDriverForBookingModel value =
          SearchDriverForBookingModel.fromJson(
        e.response?.data as Map<String, dynamic>,
      );
      return DataSuccess<SearchDriverForBookingModel>(value);
    } on Exception catch (e) {
      return DataFailed<SearchDriverForBookingModel>(e);
    }
  }
}
