// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingData _$BookingDataFromJson(Map<String, dynamic> json) => BookingData(
      id: json['id'] as String?,
      carId: json['carId'] as String?,
      userId: json['userId'] as String?,
      driverId: json['driverId'] as String?,
      driverAppBookingId: json['driverAppBookingId'] as String?,
      status: json['status'] as int?,
      price: (json['price'] as num?)?.toDouble(),
      tipAmount: (json['tipAmount'] as num?)?.toDouble(),
      promotionAmount: (json['promotionAmount'] as num?)?.toDouble(),
      waitingFreeNote: json['waitingFreeNote'] as String?,
      waitingFreeAmount: json['waitingFreeAmount'] as int?,
      expressWayFee: (json['expressWayFee'] as num?)?.toDouble(),
      totalAmount: (json['totalAmount'] as num?)?.toDouble(),
      cancelReason: json['cancelReason'],
      cancelTime: json['cancelTime'],
      bookingStartTime: json['bookingStartTime'] as String?,
      startTime: json['startTime'] as String?,
      arrivedTime: json['arrivedTime'],
      isLiked: json['isLiked'] as bool?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      driverToPickupDistance:
          (json['driverToPickupDistance'] as num?)?.toDouble(),
      driverToPickupTakeTime:
          (json['driverToPickupTakeTime'] as num?)?.toDouble(),
      cancelBy: json['cancelBy'] as int?,
      firestoreDriverId: json['firestoreDriverId'] as String?,
      carInfo: json['carInfo'] == null
          ? null
          : CarInfo.fromJson(json['carInfo'] as Map<String, dynamic>),
      driverInfo: json['driverInfo'] == null
          ? null
          : DriverInfo.fromJson(json['driverInfo'] as Map<String, dynamic>),
      paymentMethod: json['paymentMethod'] == null
          ? null
          : PaymentMethodData.fromJson(
              json['paymentMethod'] as Map<String, dynamic>),
      trip: json['trip'] == null
          ? null
          : Trip.fromJson(json['trip'] as Map<String, dynamic>),
      ratingDriver: json['ratingDriver'] == null
          ? null
          : RatingDriver.fromJson(json['ratingDriver'] as Map<String, dynamic>),
      tipInvoice: json['tipInvoice'] == null
          ? null
          : TipInvoice.fromJson(json['tipInvoice'] as Map<String, dynamic>),
      totalAmountIncludeTip: json['totalAmountIncludeTip'] as num?,
      orderId: json['orderId'] as String?,
      invoice: json['invoice'] == null
          ? null
          : InvoiceOfBooking.fromJson(json['invoice'] as Map<String, dynamic>),
      tipReason: json['tipReason'] as String?,
      distance: json['distance'] as int?,
      noteForDriver: json['noteForDriver'] as String?,
      promotions: json['promotions'] as List<dynamic>?,
    );

Map<String, dynamic> _$BookingDataToJson(BookingData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'carId': instance.carId,
      'userId': instance.userId,
      'driverId': instance.driverId,
      'driverAppBookingId': instance.driverAppBookingId,
      'status': instance.status,
      'price': instance.price,
      'tipAmount': instance.tipAmount,
      'promotionAmount': instance.promotionAmount,
      'totalAmount': instance.totalAmount,
      'tipReason': instance.tipReason,
      'cancelReason': instance.cancelReason,
      'cancelTime': instance.cancelTime,
      'bookingStartTime': instance.bookingStartTime,
      'startTime': instance.startTime,
      'arrivedTime': instance.arrivedTime,
      'isLiked': instance.isLiked,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'waitingFreeNote': instance.waitingFreeNote,
      'waitingFreeAmount': instance.waitingFreeAmount,
      'expressWayFee': instance.expressWayFee,
      'carInfo': instance.carInfo,
      'driverInfo': instance.driverInfo,
      'paymentMethod': instance.paymentMethod,
      'trip': instance.trip,
      'driverToPickupDistance': instance.driverToPickupDistance,
      'driverToPickupTakeTime': instance.driverToPickupTakeTime,
      'cancelBy': instance.cancelBy,
      'firestoreDriverId': instance.firestoreDriverId,
      'ratingDriver': instance.ratingDriver,
      'tipInvoice': instance.tipInvoice,
      'totalAmountIncludeTip': instance.totalAmountIncludeTip,
      'orderId': instance.orderId,
      'invoice': instance.invoice,
      'distance': instance.distance,
      'noteForDriver': instance.noteForDriver,
      'promotions': instance.promotions,
    };

TipInvoice _$TipInvoiceFromJson(Map<String, dynamic> json) => TipInvoice(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      tipInvoiceStatus: json['tipInvoiceStatus'] as int?,
      paymentDate: json['paymentDate'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      paymentMethod: json['paymentMethod'] == null
          ? null
          : PaymentMethodData.fromJson(
              json['paymentMethod'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TipInvoiceToJson(TipInvoice instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'tipInvoiceStatus': instance.tipInvoiceStatus,
      'paymentDate': instance.paymentDate,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'paymentMethod': instance.paymentMethod,
    };

CarInfo _$CarInfoFromJson(Map<String, dynamic> json) => CarInfo(
      id: json['id'] as String?,
      carId: json['carId'] as String?,
      carTypeId: json['carTypeId'] as String?,
      icon: json['icon'] as String?,
      branch: json['branch'] as String?,
      size: json['size'] as String?,
      licensePlateNumber: json['licensePlateNumber'] as String?,
      color: json['color'] as String?,
      region: json['region'] as String?,
      carType: json['carType'] == null
          ? null
          : CarType.fromJson(json['carType'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$CarInfoToJson(CarInfo instance) => <String, dynamic>{
      'id': instance.id,
      'carId': instance.carId,
      'carTypeId': instance.carTypeId,
      'icon': instance.icon,
      'size': instance.size,
      'licensePlateNumber': instance.licensePlateNumber,
      'branch': instance.branch,
      'color': instance.color,
      'region': instance.region,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'carType': instance.carType,
    };

CarType _$CarTypeFromJson(Map<String, dynamic> json) => CarType(
      id: json['id'] as num?,
      typeName: json['typeName'] as String?,
      typeSlogan: json['typeSlogan'] as String?,
      carImage: json['carImage'] as String?,
      carIcon: json['carIcon'] as String?,
      longitude: (json['longitude'] as num?)?.toDouble(),
      latitude: (json['latitude'] as num?)?.toDouble(),
      price: (json['price'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CarTypeToJson(CarType instance) => <String, dynamic>{
      'id': instance.id,
      'typeName': instance.typeName,
      'typeSlogan': instance.typeSlogan,
      'carImage': instance.carImage,
      'carIcon': instance.carIcon,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'price': instance.price,
    };

Trip _$TripFromJson(Map<String, dynamic> json) => Trip(
      id: json['id'] as String?,
      deviceId: json['deviceId'] as String?,
      carType: json['carType'] as int?,
      isDrafting: json['isDrafting'] as bool?,
      startTime: json['startTime'] as String?,
      copyTripId: json['copyTripId'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      isSilent: json['isSilent'] as bool?,
      noteForDriver: json['noteForDriver'] as String?,
      distance: (json['distance'] as num?)?.toDouble(),
      totalTime: json['totalTime'] as int?,
      locations: (json['locations'] as List<dynamic>?)
              ?.map((e) => TripLocation.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <TripLocation>[],
      isTripLater: json['isTripLater'] as bool?,
      copyTripAcceptedId: json['copyTripAcceptedId'] as String?,
      price: json['price'] as num?,
    );

Map<String, dynamic> _$TripToJson(Trip instance) => <String, dynamic>{
      'id': instance.id,
      'deviceId': instance.deviceId,
      'carType': instance.carType,
      'isDrafting': instance.isDrafting,
      'startTime': instance.startTime,
      'copyTripId': instance.copyTripId,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'isSilent': instance.isSilent,
      'noteForDriver': instance.noteForDriver,
      'totalTime': instance.totalTime,
      'distance': instance.distance,
      'isTripLater': instance.isTripLater,
      'locations': instance.locations,
      'copyTripAcceptedId': instance.copyTripAcceptedId,
      'price': instance.price,
    };

TripLocation _$TripLocationFromJson(Map<String, dynamic> json) => TripLocation(
      id: json['id'] as String?,
      longitude: (json['longitude'] as num?)?.toDouble(),
      latitude: (json['latitude'] as num?)?.toDouble(),
      address: json['address'] as String?,
      note: json['note'],
      milestone: json['milestone'] as int?,
      googleId: json['googleId'] as String?,
      referenceId: json['referenceId'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      addressName: json['addressName'] as String?,
      arrivedTime: json['arrivedTime'] as String?,
      pathToLocation: json['pathToLocation'] as String?,
    );

Map<String, dynamic> _$TripLocationToJson(TripLocation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'address': instance.address,
      'note': instance.note,
      'milestone': instance.milestone,
      'googleId': instance.googleId,
      'referenceId': instance.referenceId,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'addressName': instance.addressName,
      'arrivedTime': instance.arrivedTime,
      'pathToLocation': instance.pathToLocation,
    };

DriverInfo _$DriverInfoFromJson(Map<String, dynamic> json) => DriverInfo(
      id: json['id'] as String?,
      driverId: json['driverId'] as String?,
      avatar: json['avatar'] as String?,
      createdAt: json['createdAt'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      name: json['name'] as String?,
      phoneNum: json['phoneNum'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$DriverInfoToJson(DriverInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'driverId': instance.driverId,
      'name': instance.name,
      'avatar': instance.avatar,
      'phoneNum': instance.phoneNum,
      'rating': instance.rating,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

RatingDriver _$RatingDriverFromJson(Map<String, dynamic> json) => RatingDriver(
      id: json['id'] as String?,
      additionalComment: json['additionalComment'] as String?,
      ratingReasons: json['ratingReasons'] as String?,
      ratingStar: json['ratingStar'] as num?,
      tipAmount: json['tipAmount'] as num?,
    );

Map<String, dynamic> _$RatingDriverToJson(RatingDriver instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ratingStar': instance.ratingStar,
      'ratingReasons': instance.ratingReasons,
      'tipAmount': instance.tipAmount,
      'additionalComment': instance.additionalComment,
    };

InvoiceOfBooking _$InvoiceOfBookingFromJson(Map<String, dynamic> json) =>
    InvoiceOfBooking(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      invoiceStatus: json['invoiceStatus'] as int?,
      note: json['note'] as String?,
      resultId: json['resultId'] as String?,
      resultContent: json['resultContent'] as String?,
      paymentDate: json['paymentDate'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$InvoiceOfBookingToJson(InvoiceOfBooking instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'amount': instance.amount,
      'invoiceStatus': instance.invoiceStatus,
      'note': instance.note,
      'resultId': instance.resultId,
      'resultContent': instance.resultContent,
      'paymentDate': instance.paymentDate,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
