part of 'checkout_page_bloc.dart';

enum CheckoutPageStatus { addNoteToDriver }

class CheckoutPageState {
  CheckoutPageState({
    this.note,
    this.status,
    this.checkBookingAvailabilityModel,
    this.promotionListItem,
    this.getPromotionStatus,
    this.rbhCoinDiscount,
    this.totalPrice,
    this.loadDraftTripDataStatus = LoadState.none,
    this.draftTripData,
  });

  final CheckoutPageStatus? status;
  final String? note;
  final CheckBookingAvailabilityModel? checkBookingAvailabilityModel;
  final PromotionData? promotionListItem;
  final LoadState? getPromotionStatus;
  final double? rbhCoinDiscount;
  final double? totalPrice;
  final LoadState? loadDraftTripDataStatus;
  final Trip? draftTripData;

  CheckoutPageState copyWith({
    CheckoutPageStatus? status,
    String? note,
    CheckBookingAvailabilityModel? checkBookingAvailabilityModel,
    PromotionData? promotionListItem,
    LoadState? getPromotionStatus,
    double? rbhCoinDiscount,
    double? totalPrice,
    LoadState? loadDraftTripDataStatus,
    Trip? draftTripData,
  }) {
    return CheckoutPageState(
      status: status ?? this.status,
      note: note ?? this.note,
      checkBookingAvailabilityModel:
          checkBookingAvailabilityModel ?? this.checkBookingAvailabilityModel,
      promotionListItem: promotionListItem ?? this.promotionListItem,
      getPromotionStatus: getPromotionStatus ?? this.getPromotionStatus,
      rbhCoinDiscount: rbhCoinDiscount ?? this.rbhCoinDiscount,
      totalPrice: totalPrice ?? this.totalPrice,
      loadDraftTripDataStatus:
          loadDraftTripDataStatus ?? this.loadDraftTripDataStatus,
      draftTripData: draftTripData ?? this.draftTripData,
    );
  }

  CheckoutPageState clear() {
    return CheckoutPageState();
  }
}
