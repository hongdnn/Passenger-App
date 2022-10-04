import 'package:passenger/core/util/data_state.dart';
import 'package:passenger/features/promotion/data/model/promotion_model.dart';
import 'package:passenger/features/promotion/data/model/promotion_search.dart';
import 'package:passenger/features/promotion/data/model/promotion_validate.dart';

abstract class PromotionRepo {
  Future<DataState<PromotionValidateResponseModel>> applyPromotion({
    required PromotionValidateRequest promotionValidateRequest,
  });

  Future<DataState<PromotionSearchResponse>> searchPromotion({
    required PromotionSearchRequestBody promotionSearchRequestBody,
  });
  Future<DataState<PromotionResponseModel>> getPromotionList({
    required String userId,
    required int pagingOffset,
  });
}
