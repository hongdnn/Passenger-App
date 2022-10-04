// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rh_base_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _RhBaseApi implements RhBaseApi {
  _RhBaseApi(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<FavoriteLocationResponse> addFavoriteLocation(favoriteLocation) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(favoriteLocation.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FavoriteLocationResponse>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/favourite-locations',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FavoriteLocationResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FavoriteLocationResponse> updateFavoriteLocation(
      favoriteLocation) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(favoriteLocation.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FavoriteLocationResponse>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/favourite-locations/update',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FavoriteLocationResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FavoriteLocationListReponse> getFavoriteLocationsByUserId(
      userId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FavoriteLocationListReponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(
                    _dio.options, '/favourite-locations/getbyuserid/${userId}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FavoriteLocationListReponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FavoriteLocationResponse> getFavoriteLocationById(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FavoriteLocationResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/favourite-locations/${id}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FavoriteLocationResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FavoriteDeleteResponse> deleteFavoriteLocationById(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FavoriteDeleteResponse>(
            Options(method: 'DELETE', headers: _headers, extra: _extra)
                .compose(_dio.options, '/favourite-locations/${id}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FavoriteDeleteResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CarDescription> getCarDetail(carBodyRequest) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(carBodyRequest.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CarDescription>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/car-type/getcartypedetail',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CarDescription.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ListCarByLocationModel> getListCarLocation(
      {required listCarLocationRequest}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(listCarLocationRequest.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ListCarByLocationModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/car-type/searchcarbylocation',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ListCarByLocationModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PriceByCarTypeModel> getPriceByCarType(distance) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(distance.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PriceByCarTypeModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/car-type/getpricebycartype',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PriceByCarTypeModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BookingHistoryModel> getListBookingHistory(
      {required userId, required limit}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'userId': userId,
      r'limit': limit
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BookingHistoryModel>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/bookings/getrecentfavoritebookings',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BookingHistoryModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BookingHistorySortByTimeModel> getBookingHistorySortByTime(
      {required userId, required limit}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'userId': userId,
      r'limit': limit
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BookingHistorySortByTimeModel>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/locations/getfrequentlocations',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BookingHistorySortByTimeModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<void> setLikeForBookingHistory(
      {required bodyRequest, required id}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(bodyRequest.toJson());
    await _dio.fetch<void>(_setStreamType<void>(
        Options(method: 'PATCH', headers: _headers, extra: _extra)
            .compose(_dio.options, '/bookings/setlike/${id}',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    return null;
  }

  @override
  Future<UpsertDraftBookingModel> upsertDraftBooking(
      {required bodyRequest}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(bodyRequest.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UpsertDraftBookingModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/trips/upsertdraftingtrip',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UpsertDraftBookingModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PaymentMethodModel> createPaymentMethod({required bodyRequest}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(bodyRequest.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PaymentMethodModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/paymentmethod',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PaymentMethodModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BookingOrderModel> createBooking({required bodyRequest}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(bodyRequest.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BookingOrderModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/bookings',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BookingOrderModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<InvoiceModel> createInvoice({required bodyRequest}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(bodyRequest.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<InvoiceModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/invoice',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = InvoiceModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<void> processInvoice({required id}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    await _dio.fetch<void>(_setStreamType<void>(
        Options(method: 'GET', headers: _headers, extra: _extra)
            .compose(_dio.options, '/invoice/processinvoice/${id}',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    return null;
  }

  @override
  Future<DriverAcceptBookingModel> acceptBooking(
      {required id, required bodyRequest}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(bodyRequest.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DriverAcceptBookingModel>(
            Options(method: 'PATCH', headers: _headers, extra: _extra)
                .compose(_dio.options, '/bookings/acceptbooking/${id}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DriverAcceptBookingModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AcceptBookingDriverAppModel> acceptBookingDriverApp(contentType,
      {required bodyRequest}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'X-API-KEY': contentType};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(bodyRequest.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AcceptBookingDriverAppModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/driverapp/acceptbooking',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AcceptBookingDriverAppModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ConfirmPickupPassengerModel> confirmPickup(
      {required bodyRequest}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(bodyRequest.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ConfirmPickupPassengerModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(
                    _dio.options, '/bookings/driverapp/confirmpickuppassenger',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ConfirmPickupPassengerModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FinishTripModel> finishTrip({required bodyRequest}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(bodyRequest.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FinishTripModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/bookings/driverapp/finishtrip',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FinishTripModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BannerResponse> getBanners() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BannerResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/banners',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BannerResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CancelBookingModel> cancelBooking({required bodyRequest}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(bodyRequest.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CancelBookingModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/bookings/cancelbooking',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CancelBookingModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CheckBookingAvailabilityModel> checkBookingAvailability(
      {required userId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'userId': userId};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CheckBookingAvailabilityModel>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/bookings/checkbookingavailability',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CheckBookingAvailabilityModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<DriverAcceptBookingModel> getBookingById({required id}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DriverAcceptBookingModel>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/bookings/${id}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DriverAcceptBookingModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BookingHistoryTripModel> getBookingHistory(
      {required userId,
      required status,
      required page,
      required pageSize}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'userId': userId,
      r'status': status,
      r'page': page,
      r'pageSize': pageSize
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BookingHistoryTripModel>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/bookings/getbookinghistory',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BookingHistoryTripModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<InvoiceModel> getInvoiceDetail({required invoiceId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<InvoiceModel>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/invoice/${invoiceId}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = InvoiceModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<RatingOptionsResponse> getRatingOptions({required bookingId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'bookingId': bookingId};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<RatingOptionsResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/bookings/getratingreasons',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RatingOptionsResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<RatingResultResponse> rateDriver({required request}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<RatingResultResponse>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/bookings/submitratingreasons',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RatingResultResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PaymentMethodModel> getDefaultPaymentMethod({required userId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PaymentMethodModel>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(
                    _dio.options, '/paymentmethod/getdefaultpayment/${userId}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PaymentMethodModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PaymentTypeModel> getAllPaymentType() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PaymentTypeModel>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/payment-type',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PaymentTypeModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PaymentItemsModel> getAllPaymentMethod({required userId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PaymentItemsModel>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/paymentmethod/getallbyuser/${userId}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PaymentItemsModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PaymentMethodModel> setDefaultPayment({required request}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PaymentMethodModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/paymentmethod/setdefaultpayment',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PaymentMethodModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PaymentMethodModel> editPaymentMethod(
      {required id, required request}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PaymentMethodModel>(
            Options(method: 'PUT', headers: _headers, extra: _extra)
                .compose(_dio.options, '/paymentmethod/${id}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PaymentMethodModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PaymentMethodModel> deletePaymentMethod({required id}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PaymentMethodModel>(
            Options(method: 'DELETE', headers: _headers, extra: _extra)
                .compose(_dio.options, '/paymentmethod/${id}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PaymentMethodModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PromotionResponseModel> getPromotionList(
      {required userId, required pagingOffset}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'userId': userId,
      r'pagingOffset': pagingOffset
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PromotionResponseModel>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/promotion',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PromotionResponseModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PromotionValidateResponseModel> promotionValidate(
      {required request}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PromotionValidateResponseModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/promotion/validate',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PromotionValidateResponseModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PromotionSearchResponse> promotionSearch({required request}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PromotionSearchResponse>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/promotion/search',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PromotionSearchResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FcmTokenModel> upsertFCMToken({required fcmTokenResponse}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(fcmTokenResponse.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FcmTokenModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/test-fe/upsertfcmtoken',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FcmTokenModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BookingDetailModel> updateBooking(
      {required id, required request}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BookingDetailModel>(
            Options(method: 'PATCH', headers: _headers, extra: _extra)
                .compose(_dio.options, '/bookings/${id}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BookingDetailModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<InvoiceModel> getInvoiceByBookingId({required id}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<InvoiceModel>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/invoice/getbybookingid/${id}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = InvoiceModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<TipPaymentInvoiceResponse> upsertTipPaymentInvoice(
      {required reqBody}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(reqBody.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<TipPaymentInvoiceResponse>(
            Options(method: 'PATCH', headers: _headers, extra: _extra)
                .compose(_dio.options, '/tip-invoice/upsert',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = TipPaymentInvoiceResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<TipPaymentInvoiceResponse> processTipPaymentInvoice(
      {required processRequest}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(processRequest.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<TipPaymentInvoiceResponse>(
            Options(method: 'PATCH', headers: _headers, extra: _extra)
                .compose(_dio.options, '/tip-invoice/process',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = TipPaymentInvoiceResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SearchDriverForBookingModel> searchDriverForBooking(
      {required searchDriverForBookingResponse}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(searchDriverForBookingResponse.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SearchDriverForBookingModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/bookings/searchdriverforbooking',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SearchDriverForBookingModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CanceBookingDriverModel> cancelBookingDriverApp(contentType,
      {required bodyRequest}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'X-API-KEY': contentType};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(bodyRequest.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CanceBookingDriverModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/driverapp/canceltrip',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CanceBookingDriverModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ConfirmPickUpPassengerModel> confirmPickUpPassengerDriverApp(
      contentType,
      {required bodyRequest}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'X-API-KEY': contentType};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(bodyRequest.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ConfirmPickUpPassengerModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/driverapp/confirmpickuppassenger',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ConfirmPickUpPassengerModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FinishTripDriverAppModel> finishTripDriverApp(contentType,
      {required bodyRequest}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'X-API-KEY': contentType};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(bodyRequest.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FinishTripDriverAppModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/driverapp/finishtrip',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FinishTripDriverAppModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AlmostArriveDriverAppModel> almostArriveDriverApp(contentType,
      {required driverAppBookingId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'driverAppBookingId': driverAppBookingId
    };
    final _headers = <String, dynamic>{r'X-API-KEY': contentType};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AlmostArriveDriverAppModel>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/driverapp/almostarrive',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AlmostArriveDriverAppModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ArrivePickUpToDriverAppModel> arriveToPickUpDriverApp(contentType,
      {required driverAppBookingId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'driverAppBookingId': driverAppBookingId
    };
    final _headers = <String, dynamic>{r'X-API-KEY': contentType};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ArrivePickUpToDriverAppModel>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/driverapp/arrivetopickup',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ArrivePickUpToDriverAppModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<DraftingTripResponse> getDraftingTripByDeviceId(
      {required deviceId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'deviceId': deviceId};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DraftingTripResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/trips/getdraftingtripbydeviceid',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DraftingTripResponse.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
