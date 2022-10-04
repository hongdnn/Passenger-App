import 'package:dio/dio.dart';
import 'package:passenger/core/network/rh_base_api.dart';
import 'package:passenger/core/util/data_state.dart';
import 'package:passenger/features/promotion/data/model/promotion_model.dart';
import 'package:passenger/features/promotion/data/model/promotion_search.dart';
import 'package:passenger/features/promotion/data/model/promotion_validate.dart';
import 'package:passenger/features/promotion/data/repo/promotion_repo.dart';

class PromotionRepoImpl extends PromotionRepo {
  // Remove async if not needed
  PromotionRepoImpl(this.rhBaseApi);

  final RhBaseApi rhBaseApi;

  // Remove async if not needed
  @override
  Future<DataState<PromotionValidateResponseModel>> applyPromotion({
    required PromotionValidateRequest promotionValidateRequest,
  }) async {
    try {
      final PromotionValidateResponseModel result =
          await rhBaseApi.promotionValidate(request: promotionValidateRequest);
      return DataSuccess<PromotionValidateResponseModel>(result);
    } on DioError catch (e) {
      final PromotionValidateResponseModel value =
          PromotionValidateResponseModel.fromJson(
        e.response?.data as Map<String, dynamic>,
      );

      return DataSuccess<PromotionValidateResponseModel>(value);
    } on Exception catch (e) {
      return DataFailed<PromotionValidateResponseModel>(e);
    }
  }

  @override
  Future<DataState<PromotionResponseModel>> getPromotionList({
    required String userId,
    required int pagingOffset,
  }) async {
    try {
      final PromotionResponseModel result = await rhBaseApi.getPromotionList(
        userId: userId,
        pagingOffset: pagingOffset,
      );
      return DataSuccess<PromotionResponseModel>(result);
    } on DioError catch (e) {
      final PromotionResponseModel value = PromotionResponseModel.fromJson(
        e.response?.data as Map<String, dynamic>,
      );

      return DataSuccess<PromotionResponseModel>(value);
    } on Exception catch (e) {
      return DataFailed<PromotionResponseModel>(e);
    }
  }

  @override
  Future<DataState<PromotionSearchResponse>> searchPromotion({
    required PromotionSearchRequestBody promotionSearchRequestBody,
  }) async {
    try {
      final PromotionSearchResponse result =
          await rhBaseApi.promotionSearch(request: promotionSearchRequestBody);
      return DataSuccess<PromotionSearchResponse>(result);
    } on DioError catch (e) {
      final PromotionSearchResponse value = PromotionSearchResponse.fromJson(
        e.response?.data as Map<String, dynamic>,
      );

      return DataSuccess<PromotionSearchResponse>(value);
    } on Exception catch (e) {
      return DataFailed<PromotionSearchResponse>(e);
    }
  }
}
