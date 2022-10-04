import 'package:dio/dio.dart';
import 'package:passenger/features/booking_page/data/model/booking_order_model.dart';
import 'package:passenger/features/booking_page/data/model/cancel_booking_model.dart';
import 'package:passenger/features/booking_page/data/model/drafting_trip_response.dart';
import 'package:passenger/features/booking_page/data/model/price_by_cartype_model.dart';
import 'package:passenger/features/booking_page/data/model/invoice_model.dart';
import 'package:passenger/features/booking_page/data/model/payment_method_model.dart';
import 'package:passenger/features/booking_page/data/model/search_driver_for_booking_model.dart';
import 'package:passenger/features/booking_page/data/model/upsert_draft_booking_model.dart';
import 'package:passenger/features/driver_rating/data/model/request/rate_driver_request.dart';
import 'package:passenger/features/driver_rating/data/model/response/rating_reason.dart';
import 'package:passenger/features/driver_rating/data/model/response/rating_result.dart';
import 'package:passenger/features/landing_page/data/model/banner_model.dart';
import 'package:passenger/features/landing_page/data/model/booking_detail_model.dart';
import 'package:passenger/features/landing_page/data/model/booking_history_model.dart';
import 'package:passenger/features/landing_page/data/model/booking_history_sort_by_time_model.dart';
import 'package:passenger/features/favorite_location/data/model/favorite_location.dart';
import 'package:passenger/features/landing_page/data/model/check_booking_availability_model.dart';
import 'package:passenger/features/landing_page/data/model/like_request_model.dart';
import 'package:passenger/features/map_page/data/model/list_car_by_location_model.dart';
import 'package:passenger/features/booking_page/data/model/car_detail.dart';
import 'package:passenger/features/map_page/data/model/list_car_location_request.dart';
import 'package:passenger/features/order_history/data/model/booking_history_trip_model.dart';
import 'package:passenger/features/payment/data/model/payment_items_model.dart';
import 'package:passenger/features/payment/data/model/payment_method_default_request_model.dart';
import 'package:passenger/features/payment/data/model/payment_type_model.dart';
import 'package:passenger/features/promotion/data/model/promotion_model.dart';
import 'package:passenger/features/promotion/data/model/promotion_search.dart';
import 'package:passenger/features/promotion/data/model/promotion_validate.dart';
import 'package:passenger/features/payment/data/model/update_booking_model.dart';
import 'package:passenger/features/tip_payment/data/model/request/tip_payment_invoice_req.dart';
import 'package:passenger/features/tip_payment/data/model/response/tip_payment_invoice.dart';
import 'package:passenger/features/tracking_page/data/model/accept_booking_driver_app_model.dart';
import 'package:passenger/features/tracking_page/data/model/almost_arrive_driver_app_model.dart';
import 'package:passenger/features/tracking_page/data/model/arrive_to_pick_up_driver_app_model.dart';
import 'package:passenger/features/tracking_page/data/model/cancel_booking_driver_model.dart';
import 'package:passenger/features/tracking_page/data/model/confirm_pick_up_passenger_driver_app_model.dart';
import 'package:passenger/features/tracking_page/data/model/confirm_pickup_passenger_model.dart';
import 'package:passenger/features/tracking_page/data/model/driver_accept_booking_model.dart';
import 'package:passenger/features/tracking_page/data/model/finish_trip_driver_app_model.dart';
import 'package:passenger/features/tracking_page/data/model/finish_trip_model.dart';
import 'package:passenger/features/user/data/model/upsert_fcm_token_model.dart';
import 'package:retrofit/retrofit.dart';

part 'rh_base_api.g.dart';

@RestApi()
abstract class RhBaseApi {
  factory RhBaseApi(Dio dio, {String baseUrl}) = _RhBaseApi;

  @POST('/favourite-locations')
  Future<FavoriteLocationResponse> addFavoriteLocation(
    @Body() FavoriteLocation favoriteLocation,
  );

  @POST('/favourite-locations/update')
  Future<FavoriteLocationResponse> updateFavoriteLocation(
    @Body() FavoriteLocation favoriteLocation,
  );

  @GET('/favourite-locations/getbyuserid/{userId}')
  Future<FavoriteLocationListReponse> getFavoriteLocationsByUserId(
    @Path() String userId,
  );

  @GET('/favourite-locations/{id}')
  Future<FavoriteLocationResponse> getFavoriteLocationById(
    @Path() String id,
  );

  @DELETE('/favourite-locations/{id}')
  Future<FavoriteDeleteResponse> deleteFavoriteLocationById(
    @Path() String id,
  );

  @POST('/car-type/getcartypedetail')
  Future<CarDescription> getCarDetail(
    @Body() CarBodyRequest carBodyRequest,
  );

  @POST('/car-type/searchcarbylocation')
  Future<ListCarByLocationModel> getListCarLocation({
    @Body() required ListCarLocationRequest listCarLocationRequest,
  });

  @POST('/car-type/getpricebycartype')
  Future<PriceByCarTypeModel> getPriceByCarType(
    @Body() GetPriceRequestBody distance,
  );

  @GET('/bookings/getrecentfavoritebookings')
  Future<BookingHistoryModel> getListBookingHistory({
    @Query('userId') required String userId,
    @Query('limit') required int limit,
  });

  @GET('/locations/getfrequentlocations')
  Future<BookingHistorySortByTimeModel> getBookingHistorySortByTime({
    @Query('userId') required String userId,
    @Query('limit') required int limit,
  });

  @PATCH('/bookings/setlike/{id}')
  Future<void> setLikeForBookingHistory({
    @Body() required LikeRequestModel bodyRequest,
    @Path() required String id,
  });

  @POST('/trips/upsertdraftingtrip')
  Future<UpsertDraftBookingModel> upsertDraftBooking({
    @Body() required UpsertRequestBody bodyRequest,
  });

  @POST('/paymentmethod')
  Future<PaymentMethodModel> createPaymentMethod({
    @Body() required PaymentRequestBody bodyRequest,
  });

  @POST('/bookings')
  Future<BookingOrderModel> createBooking({
    @Body() required ConfirmBookingRequestModel bodyRequest,
  });

  @POST('/invoice')
  Future<InvoiceModel> createInvoice({
    @Body() required InvoiceRequestBody bodyRequest,
  });

  @GET('/invoice/processinvoice/{id}')
  Future<void> processInvoice({
    @Path() required String id,
  });

  @PATCH('/bookings/acceptbooking/{id}')
  Future<DriverAcceptBookingModel> acceptBooking({
    @Path() required String id,
    @Body() required DriverAcceptBookingRequestBody bodyRequest,
  });

  @POST('/driverapp/acceptbooking')
  Future<AcceptBookingDriverAppModel> acceptBookingDriverApp(
    @Header('X-API-KEY') String contentType, {
    @Body() required AcceptBookingDriverAppResponse bodyRequest,
  });

  @POST('/bookings/driverapp/confirmpickuppassenger')
  Future<ConfirmPickupPassengerModel> confirmPickup({
    @Body() required ConfirmPickupPassengerRequestBody bodyRequest,
  });

  @POST('/bookings/driverapp/finishtrip')
  Future<FinishTripModel> finishTrip({
    @Body() required FinishTripRequestBody bodyRequest,
  });

  @GET('/banners')
  Future<BannerResponse> getBanners();

  @POST('/bookings/cancelbooking')
  Future<CancelBookingModel> cancelBooking({
    @Body() required CancelBookingBody bodyRequest,
  });

  @GET('/bookings/checkbookingavailability')
  Future<CheckBookingAvailabilityModel> checkBookingAvailability({
    @Query('userId') required String userId,
  });

  @GET('/bookings/{id}')
  Future<DriverAcceptBookingModel> getBookingById({
    @Path() required String id,
  });

  @GET('/bookings/getbookinghistory')
  Future<BookingHistoryTripModel> getBookingHistory({
    @Query('userId') required String userId,
    @Query('status') required int status,
    @Query('page') required int page,
    @Query('pageSize') required int pageSize,
  });

  @GET('/invoice/{invoiceId}')
  Future<InvoiceModel> getInvoiceDetail({
    @Path() required String invoiceId,
  });

  @GET('/bookings/getratingreasons')
  Future<RatingOptionsResponse> getRatingOptions({
    @Query('bookingId') required String bookingId,
  });

  @POST('/bookings/submitratingreasons')
  Future<RatingResultResponse> rateDriver({
    @Body() required RateDriverRequest request,
  });

  @GET('/paymentmethod/getdefaultpayment/{userId}')
  Future<PaymentMethodModel> getDefaultPaymentMethod({
    @Path('userId') required String userId,
  });

  @GET('/payment-type')
  Future<PaymentTypeModel> getAllPaymentType();

  @GET('/paymentmethod/getallbyuser/{userId}')
  Future<PaymentItemsModel> getAllPaymentMethod({
    @Path('userId') required String userId,
  });

  @POST('/paymentmethod/setdefaultpayment')
  Future<PaymentMethodModel> setDefaultPayment({
    @Body() required PaymentMethodDefaultRequest request,
  });

  @PUT('/paymentmethod/{id}')
  Future<PaymentMethodModel> editPaymentMethod({
    @Path('id') required String id,
    @Body() required PaymentMethodUpdateRequestBody request,
  });

  @DELETE('/paymentmethod/{id}')
  Future<PaymentMethodModel> deletePaymentMethod({
    @Path('id') required String id,
  });

  @GET('/promotion')
  Future<PromotionResponseModel> getPromotionList({
    @Query('userId') required String userId,
    @Query('pagingOffset') required int pagingOffset,
  });

  @POST('/promotion/validate')
  Future<PromotionValidateResponseModel> promotionValidate({
    @Body() required PromotionValidateRequest request,
  });

  @POST('/promotion/search')
  Future<PromotionSearchResponse> promotionSearch({
    @Body() required PromotionSearchRequestBody request,
  });

  @POST('/test-fe/upsertfcmtoken')
  Future<FcmTokenModel> upsertFCMToken({
    @Body() required FcmTokenResponse fcmTokenResponse,
  });

  @PATCH('/bookings/{id}')
  Future<BookingDetailModel> updateBooking({
    @Path('id') required String id,
    @Body() required UpdateBookingPayloadModel request,
  });

  @GET('/invoice/getbybookingid/{id}')
  Future<InvoiceModel> getInvoiceByBookingId({
    @Path('id') required String id,
  });

  @PATCH('/tip-invoice/upsert')
  Future<TipPaymentInvoiceResponse> upsertTipPaymentInvoice({
    @Body() required TipPaymentInvoiceRequest reqBody,
  });

  @PATCH('/tip-invoice/process')
  Future<TipPaymentInvoiceResponse> processTipPaymentInvoice({
    @Body() required TipPaymentInvoiceProcessRequest processRequest,
  });
  @POST('/bookings/searchdriverforbooking')
  Future<SearchDriverForBookingModel> searchDriverForBooking({
    @Body()
        required SearchDriverForBookingResponse searchDriverForBookingResponse,
  });

  @POST('/driverapp/canceltrip')
  Future<CanceBookingDriverModel> cancelBookingDriverApp(
    @Header('X-API-KEY') String contentType, {
    @Body() required CanceBookingDriverResponse bodyRequest,
  });

  @POST('/driverapp/confirmpickuppassenger')
  Future<ConfirmPickUpPassengerModel> confirmPickUpPassengerDriverApp(
    @Header('X-API-KEY') String contentType, {
    @Body() required ConfirmPickUpPassengerResponse bodyRequest,
  });

  @POST('/driverapp/finishtrip')
  Future<FinishTripDriverAppModel> finishTripDriverApp(
    @Header('X-API-KEY') String contentType, {
    @Body() required FinishTripDriverAppResponse bodyRequest,
  });

  @GET('/driverapp/almostarrive')
  Future<AlmostArriveDriverAppModel> almostArriveDriverApp(
    @Header('X-API-KEY') String contentType, {
    @Query('driverAppBookingId') required String driverAppBookingId,
  });

  @GET('/driverapp/arrivetopickup')
  Future<ArrivePickUpToDriverAppModel> arriveToPickUpDriverApp(
    @Header('X-API-KEY') String contentType, {
    @Query('driverAppBookingId') required String driverAppBookingId,
  });

  @GET('/trips/getdraftingtripbydeviceid')
  Future<DraftingTripResponse> getDraftingTripByDeviceId({
    @Query('deviceId') required String deviceId,
  });
}
