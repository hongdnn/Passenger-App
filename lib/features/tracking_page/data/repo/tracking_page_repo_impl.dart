import 'package:dio/dio.dart';
import 'package:passenger/core/network/rh_base_api.dart';
import 'package:passenger/features/booking_page/data/model/search_driver_for_booking_model.dart';
import 'package:passenger/features/tracking_page/data/model/accept_booking_driver_app_model.dart';
import 'package:passenger/features/tracking_page/data/model/almost_arrive_driver_app_model.dart';
import 'package:passenger/features/tracking_page/data/model/arrive_to_pick_up_driver_app_model.dart';
import 'package:passenger/features/tracking_page/data/model/cancel_booking_driver_model.dart';
import 'package:passenger/features/tracking_page/data/model/confirm_pick_up_passenger_driver_app_model.dart';
import 'package:passenger/features/tracking_page/data/model/finish_trip_driver_app_model.dart';
import 'package:passenger/features/tracking_page/data/model/finish_trip_model.dart';
import 'package:passenger/features/tracking_page/data/model/confirm_pickup_passenger_model.dart';
import 'package:passenger/core/util/data_state.dart';
import 'package:passenger/features/tracking_page/data/repo/tracking_page_repo.dart';
import 'package:passenger/util/string_constant.dart';

class TrackingPageRepoImpl implements TrackingPageRepo {
  TrackingPageRepoImpl(this._baseApi);

  final RhBaseApi _baseApi;

  // @override
  // Future<DataState<DriverAcceptBookingModel>> acceptBooking({
  //   required String id,
  //   required DriverAcceptBookingRequestBody body,
  // }) async {
  //   try {
  //     final DriverAcceptBookingModel result =
  //         await _baseApi.acceptBooking(id: id, bodyRequest: body);
  //     return DataSuccess<DriverAcceptBookingModel>(result);
  //   } on Exception catch (e) {
  //     return DataFailed<DriverAcceptBookingModel>(e);
  //   }
  // }

  @override
  Future<DataState<ConfirmPickupPassengerModel>> confirmPickup({
    required ConfirmPickupPassengerRequestBody body,
  }) async {
    try {
      final ConfirmPickupPassengerModel result =
          await _baseApi.confirmPickup(bodyRequest: body);
      return DataSuccess<ConfirmPickupPassengerModel>(result);
    } on DioError catch (e) {
      final ConfirmPickupPassengerModel value =
          ConfirmPickupPassengerModel.fromJson(
        e.response?.data as Map<String, dynamic>,
      );

      return DataSuccess<ConfirmPickupPassengerModel>(value);
    } on Exception catch (e) {
      return DataFailed<ConfirmPickupPassengerModel>(e);
    }
  }

  @override
  Future<DataState<FinishTripModel>> finishTrip({
    required FinishTripRequestBody body,
  }) async {
    try {
      final FinishTripModel result =
          await _baseApi.finishTrip(bodyRequest: body);
      return DataSuccess<FinishTripModel>(result);
    } on DioError catch (e) {
      final FinishTripModel value = FinishTripModel.fromJson(
        e.response?.data as Map<String, dynamic>,
      );

      return DataSuccess<FinishTripModel>(value);
    } on Exception catch (e) {
      return DataFailed<FinishTripModel>(e);
    }
  }

  @override
  Future<DataState<AcceptBookingDriverAppModel>> acceptBookingDriverApp({
    required String driverBookingId,
  }) async {
    try {
      final AcceptBookingDriverAppModel result =
          await _baseApi.acceptBookingDriverApp(
        StringConstant.xApiKey,
        bodyRequest: AcceptBookingDriverAppResponse(
          driverBookingId: driverBookingId,
          carInfo: CarInfo(),
          driverInfo: DriverInfo(),
        ),
      );
      return DataSuccess<AcceptBookingDriverAppModel>(result);
    } on DioError catch (e) {
      final AcceptBookingDriverAppModel value =
          AcceptBookingDriverAppModel.fromJson(
        e.response?.data as Map<String, dynamic>,
      );

      return DataFailed<AcceptBookingDriverAppModel>(e, data: value);
    } on Exception catch (e) {
      return DataFailed<AcceptBookingDriverAppModel>(e);
    }
  }

  @override
  Future<DataState<CanceBookingDriverModel>> cancelBookingDriverApp({
    required String driverBookingId,
  }) async {
    try {
      final CanceBookingDriverModel result =
          await _baseApi.cancelBookingDriverApp(
        StringConstant.xApiKey,
        bodyRequest:
            CanceBookingDriverResponse(driverBookingId: driverBookingId),
      );
      return DataSuccess<CanceBookingDriverModel>(result);
    } on DioError catch (e) {
      final CanceBookingDriverModel value = CanceBookingDriverModel.fromJson(
        e.response?.data as Map<String, dynamic>,
      );

      return DataFailed<CanceBookingDriverModel>(e, data: value);
    } on Exception catch (e) {
      return DataFailed<CanceBookingDriverModel>(e);
    }
  }

  @override
  Future<DataState<ConfirmPickUpPassengerModel>>
      confirmPickUpPassengerDriverApp({required String driverBookingId}) async {
    try {
      final ConfirmPickUpPassengerModel result =
          await _baseApi.confirmPickUpPassengerDriverApp(
        StringConstant.xApiKey,
        bodyRequest: ConfirmPickUpPassengerResponse(
          driverBookingId: driverBookingId,
          arrivedTime: DateTime.parse('2022-08-16T08:48:19.073Z'),
        ),
      );
      return DataSuccess<ConfirmPickUpPassengerModel>(result);
    } on DioError catch (e) {
      final ConfirmPickUpPassengerModel value =
          ConfirmPickUpPassengerModel.fromJson(
        e.response?.data as Map<String, dynamic>,
      );

      return DataFailed<ConfirmPickUpPassengerModel>(e, data: value);
    } on Exception catch (e) {
      return DataFailed<ConfirmPickUpPassengerModel>(e);
    }
  }

  @override
  Future<DataState<FinishTripDriverAppModel>> finishTripDriverApp({
    required String driverBookingId,
  }) async {
    try {
      final FinishTripDriverAppModel result =
          await _baseApi.finishTripDriverApp(
        StringConstant.xApiKey,
        bodyRequest: FinishTripDriverAppResponse(
          driverBookingId: driverBookingId,
        ),
      );
      return DataSuccess<FinishTripDriverAppModel>(result);
    } on DioError catch (e) {
      final FinishTripDriverAppModel value = FinishTripDriverAppModel.fromJson(
        e.response?.data as Map<String, dynamic>,
      );

      return DataFailed<FinishTripDriverAppModel>(e, data: value);
    } on Exception catch (e) {
      return DataFailed<FinishTripDriverAppModel>(e);
    }
  }

  @override
  Future<DataState<AlmostArriveDriverAppModel>> almostArriveDriverApp({
    required String driverBookingId,
  }) async {
    try {
      final AlmostArriveDriverAppModel result =
          await _baseApi.almostArriveDriverApp(
        StringConstant.xApiKey,
        driverAppBookingId: driverBookingId,
      );
      return DataSuccess<AlmostArriveDriverAppModel>(result);
    } on DioError catch (e) {
      final AlmostArriveDriverAppModel value =
          AlmostArriveDriverAppModel.fromJson(
        e.response?.data as Map<String, dynamic>,
      );

      return DataFailed<AlmostArriveDriverAppModel>(e, data: value);
    } on Exception catch (e) {
      return DataFailed<AlmostArriveDriverAppModel>(e);
    }
  }

  @override
  Future<DataState<ArrivePickUpToDriverAppModel>> arrivePickUpToDriverApp({
    required String driverBookingId,
  }) async {
    try {
      final ArrivePickUpToDriverAppModel result =
          await _baseApi.arriveToPickUpDriverApp(
        StringConstant.xApiKey,
        driverAppBookingId: driverBookingId,
      );
      return DataSuccess<ArrivePickUpToDriverAppModel>(result);
    } on DioError catch (e) {
      final ArrivePickUpToDriverAppModel value =
          ArrivePickUpToDriverAppModel.fromJson(
        e.response?.data as Map<String, dynamic>,
      );

      return DataFailed<ArrivePickUpToDriverAppModel>(e, data: value);
    } on Exception catch (e) {
      return DataFailed<ArrivePickUpToDriverAppModel>(e);
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

      return DataFailed<SearchDriverForBookingModel>(e, data: value);
    } on Exception catch (e) {
      return DataFailed<SearchDriverForBookingModel>(e);
    }
  }
}
