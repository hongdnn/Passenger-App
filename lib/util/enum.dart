enum NavigateType { patternListPage, detailPage }

enum TravelTransportation { driving, bicycle, bus, walk }

enum MapStatus {
  initState,
  validPhoneNumber,
  editingPhoneNumber,
  invalidPhoneNumber,
  loginInProgress,
  loginSuccess,
  accountNotCreate,
  unknownError
}

enum Environment { staging, production }

enum BookingPageStatus {
  init,
  loading,
  fetchingDriverListSuccess,
  fetchingDriverListFail,
  requestCaptureRoute
}

enum LoadState {
  none,
  loading,
  success,
  failure,
}

enum LocationPickParent { landing, booking }

enum UpdateDestinationStatus { add, remove, swap, reorder, updateItem }

enum InvoiceStatus {
  processing(0),
  completed(1),
  failed(-1);

  const InvoiceStatus(this.value);

  final int value;
}

//Options when search locatin
enum OptionSearchResult { favorite, booking }

enum TripStatus {
  ongoing(0),
  completed(1),
  canceled(-1);

  const TripStatus(this.value);

  final int value;
}

enum BookingStatus {
  canceled(-1),
  confirmed(0),
  searching(1),
  driverFound(2),
  waiting(3),
  driverWillArriveIn1Hour(4),
  driverAlmostArrive(5),
  driverArrive(6),
  driverPickUp(7),
  processing(8),
  dropOffMidDestination(9),
  completed(10);

  const BookingStatus(this.value);

  final int value;
}

enum UrlSchemaType {
  phone,
  sms,
  link,
}

enum DestinationMileStone {
  one(1),
  two(2),
  three(3);

  const DestinationMileStone(this.value);

  final int value;
}

enum CarCategory {
  emptyCategory(-1);
  const CarCategory(this.value);

  final int value;
}

enum DiscountType {
  percent('PERCENT'),
  flat('FLAT');

  const DiscountType(this.value);

  final String value;
}

enum TipInvoiceStatus {
  processing(0),
  completed(1),
  failed(-1);

  const TipInvoiceStatus(this.value);

  final int value;
}

enum OrderHistoryTabIndex {
  
  ongoing(0), completed(1), canceled(2);
  const OrderHistoryTabIndex(this.value);

  final int value;
}
enum BookingDriverStatus {
  driverCanceledTrip(1),
  driverAcceptTrip(2),
  driverWillArriveIn1Hour(3),
  driverAlmostArrive(4),
  driverArrrive(5),
  driverConfirmPickupPassenger(6),
  driverFinishOneDestionation(7),
  driverFinishTrip(8),
  driverUpdatePrice(9),
  driverTrackingLocation(10),
  paymentVerificationInProgress(11),
  paymentFail(12);

  const BookingDriverStatus(this.value);

  final int value;
}
