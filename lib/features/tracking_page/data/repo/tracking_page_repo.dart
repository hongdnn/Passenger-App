import 'package:passenger/core/util/data_state.dart';
import 'package:passenger/features/booking_page/data/model/search_driver_for_booking_model.dart';
import 'package:passenger/features/tracking_page/data/model/accept_booking_driver_app_model.dart';
import 'package:passenger/features/tracking_page/data/model/almost_arrive_driver_app_model.dart';
import 'package:passenger/features/tracking_page/data/model/arrive_to_pick_up_driver_app_model.dart';
import 'package:passenger/features/tracking_page/data/model/cancel_booking_driver_model.dart';
import 'package:passenger/features/tracking_page/data/model/confirm_pick_up_passenger_driver_app_model.dart';
import 'package:passenger/features/tracking_page/data/model/confirm_pickup_passenger_model.dart';
import 'package:passenger/features/tracking_page/data/model/finish_trip_driver_app_model.dart';
import 'package:passenger/features/tracking_page/data/model/finish_trip_model.dart';

abstract class TrackingPageRepo {
  // Future<DataState<DriverAcceptBookingModel>> acceptBooking({
  //   required String id,
  //   required DriverAcceptBookingRequestBody body,
  // });
  Future<DataState<AcceptBookingDriverAppModel>> acceptBookingDriverApp({
    required String driverBookingId,
  });

  Future<DataState<ConfirmPickupPassengerModel>> confirmPickup({
    required ConfirmPickupPassengerRequestBody body,
  });

  Future<DataState<FinishTripModel>> finishTrip({
    required FinishTripRequestBody body,
  });

  Future<DataState<CanceBookingDriverModel>> cancelBookingDriverApp({
    required String driverBookingId,
  });

  Future<DataState<ConfirmPickUpPassengerModel>>
      confirmPickUpPassengerDriverApp({
    required String driverBookingId,
  });

  Future<DataState<FinishTripDriverAppModel>> finishTripDriverApp({
    required String driverBookingId,
  });

  Future<DataState<AlmostArriveDriverAppModel>> almostArriveDriverApp({
    required String driverBookingId,
  });

  Future<DataState<ArrivePickUpToDriverAppModel>> arrivePickUpToDriverApp({
    required String driverBookingId,
  });

  Future<DataState<SearchDriverForBookingModel>> searchDriverForBooking({
    required SearchDriverForBookingResponse body,
  });
}
