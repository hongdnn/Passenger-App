import 'package:passenger/features/promotion/data/model/promotion_model.dart';

abstract class PromotionPageEvent {}

class PromotionPageSearchEvent extends PromotionPageEvent {
  PromotionPageSearchEvent({required this.keyword});

  final String keyword;
}

class PromotionPageApplyPromoEvent extends PromotionPageEvent {
  PromotionPageApplyPromoEvent({this.tripPrice, required this.promotion});

  final PromotionData promotion;
  final double? tripPrice;
}

class PromotionListInitEvent extends PromotionPageEvent {
  PromotionListInitEvent();
}

class PromotionListUpdateOnLoadingEvent extends PromotionPageEvent {
  PromotionListUpdateOnLoadingEvent({
    this.isLazyLoading,
  });
  final bool? isLazyLoading;
}

class GetNextPagePromotionEvent extends PromotionPageEvent {}
