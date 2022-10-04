part of 'checkout_page_bloc.dart';

abstract class CheckoutPageEvent {}

class AddNoteToDriverEvent extends CheckoutPageEvent {
  AddNoteToDriverEvent({required this.note});

  final String? note;
}

class GetStaticImageEvent extends CheckoutPageEvent {
  GetStaticImageEvent();
}

class ClearDataCheckoutEvent extends CheckoutPageEvent {}

class GetPromotionEvent extends CheckoutPageEvent {
  GetPromotionEvent({this.promotionListItem, this.selectedPromotionItem});
  final PromotionData? promotionListItem;
  final bool? selectedPromotionItem;
}

class GetRbhCoinDiscountEvent extends CheckoutPageEvent {
  GetRbhCoinDiscountEvent({this.rbhCoinDiscount});
  final double? rbhCoinDiscount;
}

class GetTotalPriceEvent extends CheckoutPageEvent {
  GetTotalPriceEvent({this.totalPrice});
  final double? totalPrice;
}

class GetDraftingTripByDeviceIdEvent extends CheckoutPageEvent {
  GetDraftingTripByDeviceIdEvent({required this.deviceId});
  final String deviceId;
}