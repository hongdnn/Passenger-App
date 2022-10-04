import 'package:google_maps_flutter/google_maps_flutter.dart';

const int defaultDebounceTime = 300;
const int maxDestinationLength = 4;
const int minDestinationLength = 2;
const int listCarLength = 8;
const int maxLineAddNoteToDriver = 2;
const int maxCharacterInput = 255;
const double initialZoomLevelBooking = 10;
const double recenterSouthSideMapBooking = -0.01;
const double recenterNorthSideMapBooking = 0.02;
const double zoomMap = 14;
const double radiusDriverMeter = 5000;

const LatLng defaultLocationConsumeApp = LatLng(13.7245599, 100.4926834);

const String keyGGApi = 'AIzaSyCi8bC5OHtvA57WuSihJSOpXuzfiv20sW0';
const String ggStorageToken =
    '''Bearer ya29.c.b0AXv0zTOw7tqCGL1HK6FC9cAOSAJZkD7GEU8qna9uCBiNCq3N0_r5_LA9krkLarWKg0dQr93gTeerF9IW6Pp_jPpRnoVgb0gmwtDKlXfOx01LyToCPv2RrXDGP_b6NXf2vrQoiQ4E_bwFOkV1HNQjDT8mjohZ41rXeKV3GXEXCUVOKmKNlw38kxW9r8tm7-oCoKoU7TqOV7TWB6dDvLFoeA6h5BIFPtE...............................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................''';

const int historyTripPageLimit = 12;
const int historyTripFirstPage = 1;
const int historyTripLastPage = -1;

RegExp regexForDoubleNumberWithDot = RegExp(r'^[0-9]+\.[1-9]+$');
RegExp regexForDoubleNumberWithoutDot = RegExp(r'([.]*0)(?!.*\d)');

const int noChosenCarsInDriverList = -1;
const int numberOfDaysAfter543Years = 198327;
const int tabCount = 3;
const int defaultSelectedRoute = 0;
const int doublePrecision = 2;
const double listExtentAfter = -0.8;
const int maxRatingStar = 5;
const int emptySearch = 1;

const Map<String, String> notificationStatus = <String, String>{
  'DRIVER_CANCEL_TRIP': '1',
  'DRIVER_ACCEPT_TRIP': '2',
  'DRIVER_WILL_ARRIVE_IN_1_HOUR': '3',
  'DRIVER_ALMOST_ARRIVE': '4',
  'DRIVER_ARRIVE': '5',
  'DRIVER_CONFIRM_PICKUP_PASSENGER': '6',
  'DRIVER_FINISH_ONE_DESTINATION': '7',
  'DRIVER_FINISH_TRIP': '8',
  'DRIVER_UPDATE_PRICE': '9',
  'DRIVER_TRACKING_LOCATION': '10',
  'PAYMENT_VERIFICATION_IN_PROGRESS': '11',
  'PAYMENT_FAIL': '12'
};
const int errorCodeIsExisted = 406;
const int defaultSelectedTip = -1;

const String demoDriverId = 'demoDriverId';

const int limitBookingHistoryCount = 10;
const int limitBookingHistorySortByTimeCount = 3;

const double defaultDemandRate = 1;

RegExp regexCarPrice = RegExp(r'([.]*0)(?!.*\d)');
