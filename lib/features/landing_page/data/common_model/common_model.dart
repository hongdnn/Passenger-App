import 'package:json_annotation/json_annotation.dart';
import 'package:passenger/features/booking_page/data/model/payment_method_model.dart';

part 'common_model.g.dart';

@JsonSerializable()
class BookingData {
  factory BookingData.fromJson(Map<String, dynamic> json) =>
      _$BookingDataFromJson(json);
  BookingData({
    this.id,
    this.carId,
    this.userId,
    this.driverId,
    this.driverAppBookingId,
    this.status,
    this.price,
    this.tipAmount,
    this.promotionAmount,
    this.waitingFreeNote,
    this.waitingFreeAmount,
    this.expressWayFee,
    this.totalAmount,
    this.cancelReason,
    this.cancelTime,
    this.bookingStartTime,
    this.startTime,
    this.arrivedTime,
    this.isLiked,
    this.createdAt,
    this.updatedAt,
    this.driverToPickupDistance,
    this.driverToPickupTakeTime,
    this.cancelBy,
    this.firestoreDriverId,
    this.carInfo,
    this.driverInfo,
    this.paymentMethod,
    this.trip,
    this.ratingDriver,
    this.tipInvoice,
    this.totalAmountIncludeTip,
    this.orderId,
    this.invoice,
    this.tipReason,
    this.distance,
    this.noteForDriver,
    this.promotions,
  });

  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'carId')
  String? carId;

  @JsonKey(name: 'userId')
  String? userId;

  @JsonKey(name: 'driverId')
  String? driverId;

  @JsonKey(name: 'driverAppBookingId')
  String? driverAppBookingId;

  @JsonKey(name: 'status')
  int? status;

  @JsonKey(name: 'price')
  double? price;

  @JsonKey(name: 'tipAmount')
  double? tipAmount;

  @JsonKey(name: 'promotionAmount')
  double? promotionAmount;

  @JsonKey(name: 'totalAmount')
  double? totalAmount;

  @JsonKey(name: 'tipReason')
  String? tipReason;

  @JsonKey(name: 'cancelReason')
  dynamic cancelReason;

  @JsonKey(name: 'cancelTime')
  dynamic cancelTime;

  @JsonKey(name: 'bookingStartTime')
  String? bookingStartTime;

  @JsonKey(name: 'startTime')
  String? startTime;

  @JsonKey(name: 'arrivedTime')
  dynamic arrivedTime;

  @JsonKey(name: 'isLiked')
  bool? isLiked;

  @JsonKey(name: 'createdAt')
  String? createdAt;

  @JsonKey(name: 'updatedAt')
  String? updatedAt;

  @JsonKey(name: 'waitingFreeNote')
  String? waitingFreeNote;

  @JsonKey(name: 'waitingFreeAmount')
  int? waitingFreeAmount;

  @JsonKey(name: 'expressWayFee')
  double? expressWayFee;

  @JsonKey(name: 'carInfo')
  CarInfo? carInfo;

  @JsonKey(name: 'driverInfo')
  DriverInfo? driverInfo;

  @JsonKey(name: 'paymentMethod')
  PaymentMethodData? paymentMethod;

  @JsonKey(name: 'trip')
  Trip? trip;

  @JsonKey(name: 'driverToPickupDistance')
  double? driverToPickupDistance;

  @JsonKey(name: 'driverToPickupTakeTime')
  double? driverToPickupTakeTime;

  @JsonKey(name: 'cancelBy')
  int? cancelBy;

  @JsonKey(name: 'firestoreDriverId')
  String? firestoreDriverId;

  @JsonKey(name: 'ratingDriver')
  RatingDriver? ratingDriver;

  @JsonKey(name: 'tipInvoice')
  TipInvoice? tipInvoice;

  @JsonKey(name: 'totalAmountIncludeTip')
  num? totalAmountIncludeTip;

  @JsonKey(name: 'orderId')
  String? orderId;

  @JsonKey(name: 'invoice')
  InvoiceOfBooking? invoice;

  @JsonKey(name: 'distance')
  int? distance;

  @JsonKey(name: 'noteForDriver')
  String? noteForDriver;

  @JsonKey(name: 'promotions')
  List<dynamic>? promotions;

  Map<String, dynamic> toJson() => _$BookingDataToJson(this);
}

@JsonSerializable()
class TipInvoice {
  factory TipInvoice.fromJson(Map<String, dynamic> json) =>
      _$TipInvoiceFromJson(json);

  TipInvoice({
    this.id,
    this.userId,
    this.tipInvoiceStatus,
    this.paymentDate,
    this.createdAt,
    this.updatedAt,
    this.paymentMethod,
  });

  String? id;
  String? userId;
  int? tipInvoiceStatus;
  String? paymentDate;
  String? createdAt;
  String? updatedAt;
  PaymentMethodData? paymentMethod;

  Map<String, dynamic> toJson() => _$TipInvoiceToJson(this);
}

@JsonSerializable()
class CarInfo {
  factory CarInfo.fromJson(Map<String, dynamic> json) =>
      _$CarInfoFromJson(json);

  CarInfo({
    this.id,
    this.carId,
    this.carTypeId,
    this.icon,
    this.branch,
    this.size,
    this.licensePlateNumber,
    this.color,
    this.region,
    this.carType,
    this.createdAt,
    this.updatedAt,
  });
  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'carId')
  String? carId;

  @JsonKey(name: 'carTypeId')
  String? carTypeId;

  @JsonKey(name: 'icon')
  String? icon;

  @JsonKey(name: 'size')
  String? size;

  @JsonKey(name: 'licensePlateNumber')
  String? licensePlateNumber;

  @JsonKey(name: 'branch')
  String? branch;

  @JsonKey(name: 'color')
  String? color;

  @JsonKey(name: 'region')
  String? region;

  @JsonKey(name: 'createdAt')
  String? createdAt;

  @JsonKey(name: 'updatedAt')
  String? updatedAt;

  @JsonKey(name: 'carType')
  CarType? carType;
}

@JsonSerializable()
class CarType {
  factory CarType.fromJson(Map<String, dynamic> json) =>
      _$CarTypeFromJson(json);

  CarType({
    this.id,
    this.typeName,
    this.typeSlogan,
    this.carImage,
    this.carIcon,
    this.longitude,
    this.latitude,
    this.price,
  });

  num? id;
  String? typeName;
  String? typeSlogan;
  String? carImage;
  String? carIcon;
  double? longitude;
  double? latitude;
  double? price;

  Map<String, dynamic> toJson() => _$CarTypeToJson(this);
}

@JsonSerializable()
class Trip {
  factory Trip.fromJson(Map<String, dynamic> json) => _$TripFromJson(json);
  Trip({
    this.id,
    this.deviceId,
    this.carType,
    this.isDrafting,
    this.startTime,
    this.copyTripId,
    this.createdAt,
    this.updatedAt,
    this.isSilent,
    this.noteForDriver,
    this.distance,
    this.totalTime,
    this.locations = const <TripLocation>[],
    this.isTripLater,
    this.copyTripAcceptedId,
    this.price,
  });

  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'deviceId')
  String? deviceId;

  @JsonKey(name: 'carType')
  int? carType;

  @JsonKey(name: 'isDrafting')
  bool? isDrafting;

  @JsonKey(name: 'startTime')
  String? startTime;

  @JsonKey(name: 'copyTripId')
  String? copyTripId;

  @JsonKey(name: 'createdAt')
  String? createdAt;

  @JsonKey(name: 'updatedAt')
  String? updatedAt;

  @JsonKey(name: 'isSilent')
  bool? isSilent;

  @JsonKey(name: 'noteForDriver')
  String? noteForDriver;

  @JsonKey(name: 'totalTime')
  int? totalTime;

  @JsonKey(name: 'distance')
  double? distance;

  @JsonKey(name: 'isTripLater')
  bool? isTripLater;

  @JsonKey(name: 'locations')
  List<TripLocation>? locations;

  @JsonKey(name: 'copyTripAcceptedId')
  String? copyTripAcceptedId;

  num? price;

  Map<String, dynamic> toJson() => _$TripToJson(this);
}

@JsonSerializable()
class TripLocation {
  factory TripLocation.fromJson(Map<String, dynamic> json) =>
      _$TripLocationFromJson(json);
  TripLocation({
    this.id,
    this.longitude,
    this.latitude,
    this.address,
    this.note,
    this.milestone,
    this.googleId,
    this.referenceId,
    this.createdAt,
    this.updatedAt,
    this.addressName,
    this.arrivedTime,
    this.pathToLocation,
  });

  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'longitude')
  double? longitude;

  @JsonKey(name: 'latitude')
  double? latitude;

  @JsonKey(name: 'address')
  String? address;

  @JsonKey(name: 'note')
  dynamic note;

  @JsonKey(name: 'milestone')
  int? milestone;

  @JsonKey(name: 'googleId')
  String? googleId;

  @JsonKey(name: 'referenceId')
  String? referenceId;

  @JsonKey(name: 'createdAt')
  String? createdAt;

  @JsonKey(name: 'updatedAt')
  String? updatedAt;

  @JsonKey(name: 'addressName')
  String? addressName;

  @JsonKey(name: 'arrivedTime')
  String? arrivedTime;

  @JsonKey(name: 'pathToLocation')
  String? pathToLocation;

  Map<String, dynamic> toJson() => _$TripLocationToJson(this);
}

@JsonSerializable()
class DriverInfo {
  factory DriverInfo.fromJson(Map<String, dynamic> json) =>
      _$DriverInfoFromJson(json);

  DriverInfo({
    this.id,
    this.driverId,
    this.avatar,
    this.createdAt,
    this.latitude,
    this.longitude,
    this.name,
    this.phoneNum,
    this.rating,
    this.updatedAt,
  });
  @JsonKey(name: 'id')
  String? id;
  String? driverId;
  String? name;
  String? avatar;
  String? phoneNum;
  double? rating;
  double? latitude;
  double? longitude;
  String? createdAt;
  String? updatedAt;
}

@JsonSerializable()
class RatingDriver {
  factory RatingDriver.fromJson(Map<String, dynamic> json) =>
      _$RatingDriverFromJson(json);

  RatingDriver({
    this.id,
    this.additionalComment,
    this.ratingReasons,
    this.ratingStar,
    this.tipAmount,
  });

  String? id;

  num? ratingStar;

  String? ratingReasons;

  num? tipAmount;

  String? additionalComment;
}

@JsonSerializable()
class InvoiceOfBooking {
  factory InvoiceOfBooking.fromJson(Map<String, dynamic> json) =>
      _$InvoiceOfBookingFromJson(json);

  InvoiceOfBooking({
    this.id,
    this.userId,
    this.amount,
    this.invoiceStatus,
    this.note,
    this.resultId,
    this.resultContent,
    this.paymentDate,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? userId;
  double? amount;
  int? invoiceStatus;
  String? note;
  String? resultId;
  String? resultContent;
  String? paymentDate;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() => _$InvoiceOfBookingToJson(this);
}
