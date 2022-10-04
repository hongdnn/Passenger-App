import 'package:passenger/features/promotion/data/model/promotion_model.dart';
import 'package:passenger/util/enum.dart';

class PromotionPageState {
  PromotionPageState({
    this.promotions,
    this.getPromotionsLoadState = LoadState.none,
    this.applyPromoLoadState = LoadState.none,
    this.searchPromoLoadState = LoadState.none,
    this.dataStateError,
    this.isLazyLoading,
    this.isLastPage = false,
    this.currentPage,
    this.promotionsApply,
    this.discountAmount,
  });

  final List<PromotionData>? promotions;
  final PromotionData? promotionsApply;
  final LoadState getPromotionsLoadState;
  final LoadState applyPromoLoadState;
  final LoadState searchPromoLoadState;
  final Exception? dataStateError;
  final bool? isLazyLoading;
  final bool isLastPage;
  final int? currentPage;
  final double? discountAmount;

  PromotionPageState copyWith({
    List<PromotionData>? promotions,
    LoadState getPromotionsLoadState = LoadState.none,
    LoadState applyPromoLoadState = LoadState.none,
    LoadState searchPromoLoadState = LoadState.none,
    Exception? dataStateError,
    bool? isLazyLoading,
    bool? isLastPage,
    int? currentPage,
    PromotionData? promotionsApply,
    double? discountAmount,
  }) {
    return PromotionPageState(
      promotions: promotions ?? this.promotions,
      getPromotionsLoadState: getPromotionsLoadState,
      applyPromoLoadState: applyPromoLoadState,
      searchPromoLoadState: searchPromoLoadState,
      dataStateError: dataStateError ?? this.dataStateError,
      isLazyLoading: isLazyLoading ?? this.isLazyLoading,
      isLastPage: isLastPage ?? this.isLastPage,
      currentPage: currentPage ?? this.currentPage,
      promotionsApply: promotionsApply ?? this.promotionsApply,
      discountAmount: discountAmount ?? this.discountAmount,
    );
  }
}
