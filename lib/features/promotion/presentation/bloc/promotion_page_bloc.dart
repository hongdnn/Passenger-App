import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passenger/core/app_config/constant.dart';
import 'package:passenger/core/util/data_state.dart';
import 'package:passenger/features/promotion/data/model/promotion_model.dart';
import 'package:passenger/features/promotion/data/model/promotion_search.dart';
import 'package:passenger/features/promotion/data/model/promotion_validate.dart';
import 'package:passenger/features/promotion/data/repo/promotion_repo.dart';
import 'package:passenger/features/promotion/presentation/bloc/promotion_page_event.dart';
import 'package:passenger/features/promotion/presentation/bloc/promotion_page_state.dart';
import 'package:passenger/features/user/data/model/user.dart';
import 'package:passenger/features/user/data/repo/user_repo.dart';
import 'package:passenger/util/enum.dart';
import 'package:passenger/util/util.dart';

class PromotionPageBloc extends Bloc<PromotionPageEvent, PromotionPageState> {
  PromotionPageBloc(this._promotionRepo, this.userRepo)
      : super(PromotionPageState()) {
    on<PromotionPageSearchEvent>(
      _searchPromotion,
      transformer: debounce(const Duration(milliseconds: defaultDebounceTime)),
    );
    on<PromotionPageApplyPromoEvent>(_applyPromotion);
    on<PromotionListUpdateOnLoadingEvent>(
      _getListPromotion,
      transformer: debounce(const Duration(milliseconds: defaultDebounceTime)),
    );
    on<PromotionListInitEvent>(
      _getOnInitPromotionList,
      transformer: debounce(const Duration(milliseconds: defaultDebounceTime)),
    );
    on<GetNextPagePromotionEvent>(
      _getNextPageOnLoading,
      transformer: debounce(const Duration(milliseconds: defaultDebounceTime)),
    );
  }

  final PromotionRepo _promotionRepo;
  final UserRepo userRepo;

  int _currentPage = 0;

  User getCurrentUser() {
    return userRepo.getCurrentUser();
  }

  FutureOr<void> _searchPromotion(
    PromotionPageSearchEvent event,
    Emitter<PromotionPageState> emit,
  ) async {
    final PromotionData? promotionsDataState;
    late List<PromotionData>? promotion = state.promotions;
    if (event.keyword.isEmpty && promotion?.length == emptySearch) {
      emit(
        state.copyWith(
          getPromotionsLoadState: LoadState.loading,
        ),
      );
      final DataState<PromotionResponseModel> promotionModel =
          await _getListPromotionOnInit();
      emit(
        state.copyWith(
          searchPromoLoadState: LoadState.success,
          getPromotionsLoadState: promotionModel.isSuccess()
              ? LoadState.success
              : LoadState.failure,
          promotions: promotionModel.isSuccess()
              ? promotionModel.data?.data?.promotionList
              : <PromotionData>[],
        ),
      );
      return;
    } else if (event.keyword.isEmpty) {
      emit(
        state.copyWith(
          searchPromoLoadState: LoadState.success,
        ),
      );
      return;
    } else {
      emit(
        state.copyWith(
          searchPromoLoadState: LoadState.failure,
        ),
      );
    }

    final DataState<PromotionSearchResponse> dataState =
        await _promotionRepo.searchPromotion(
      promotionSearchRequestBody: PromotionSearchRequestBody(
        userId: userRepo.getCurrentUser().id,
        voucherCode: event.keyword,
      ),
    );
    promotionsDataState = dataState.data?.data;
    if (promotionsDataState != null) {
      promotion?.clear();
      promotion?.add(promotionsDataState);
    }

    emit(
      state.copyWith(
        searchPromoLoadState:
            promotionsDataState != null ? LoadState.success : LoadState.failure,
        promotions: promotion,
      ),
    );
  }

  FutureOr<void> _applyPromotion(
    PromotionPageApplyPromoEvent event,
    Emitter<PromotionPageState> emit,
  ) async {
    final DataState<PromotionValidateResponseModel> dataState =
        await _promotionRepo.applyPromotion(
      promotionValidateRequest: PromotionValidateRequest(
        userId: userRepo.getCurrentUser().id,
        promotionId: event.promotion.promotionId,
        promotionCode: event.promotion.promotionCode,
        voucherCode: event.promotion.voucherCode,
        orderAmount: event.tripPrice,
      ),
    );
    emit(
      state.copyWith(
        promotionsApply: event.promotion,
        applyPromoLoadState: dataState.data?.data?.isValid == true
            ? LoadState.success
            : LoadState.failure,
        dataStateError: dataState.error,
        discountAmount: dataState.data?.data?.discountAmount,
      ),
    );
  }

  FutureOr<void> _getOnInitPromotionList(
    PromotionListInitEvent event,
    Emitter<PromotionPageState> emit,
  ) async {
    emit(
      state.copyWith(
        getPromotionsLoadState: state.promotions?.isNotEmpty == true
            ? LoadState.success
            : LoadState.loading,
        applyPromoLoadState: LoadState.loading,
      ),
    );
    final DataState<PromotionResponseModel> promotionModel =
        await _getListPromotionOnInit();
    emit(
      state.copyWith(
        getPromotionsLoadState:
            promotionModel.isSuccess() ? LoadState.success : LoadState.failure,
        promotions: promotionModel.isSuccess()
            ? promotionModel.data?.data?.promotionList
            : <PromotionData>[],
        isLazyLoading: false,
        isLastPage: promotionModel.data?.data?.pagination?.hasNextPage ?? false,
        searchPromoLoadState: LoadState.success,
      ),
    );
    log(state.promotions.toString());
  }

  Future<DataState<PromotionResponseModel>> _getListPromotionOnInit() async {
    return await _promotionRepo.getPromotionList(
      userId: getCurrentUser().id,
      pagingOffset: _currentPage,
    );
  }

  Future<void> _getListPromotion(
    PromotionListUpdateOnLoadingEvent event,
    Emitter<PromotionPageState> emitter,
  ) async {
    emitter(
      state.copyWith(
        getPromotionsLoadState: state.promotions?.isNotEmpty == true
            ? LoadState.success
            : LoadState.loading,
        isLazyLoading: event.isLazyLoading,
      ),
    );
    final DataState<PromotionResponseModel> promotionModel =
        await _promotionRepo.getPromotionList(
      userId: getCurrentUser().id,
      pagingOffset: _currentPage,
    );

    if (promotionModel.data?.data?.promotionList?.isEmpty == true) {
      emitter(
        state.copyWith(
          isLastPage:
              promotionModel.data?.data?.pagination?.hasNextPage ?? false,
          isLazyLoading: false,
        ),
      );
      return;
    }

    late List<PromotionData> currentPromotionListData =
        state.promotions ?? <PromotionData>[];
    if (_currentPage == 0) {
      currentPromotionListData =
          promotionModel.data?.data?.promotionList ?? <PromotionData>[];
    } else {
      currentPromotionListData.addAll(
        promotionModel.data?.data?.promotionList ?? <PromotionData>[],
      );
    }
    emitter(
      state.copyWith(
        getPromotionsLoadState:
            promotionModel.isSuccess() ? LoadState.success : LoadState.failure,
        promotions: promotionModel.isSuccess()
            ? currentPromotionListData
            : (state.promotions ?? currentPromotionListData),
        isLazyLoading: false,
        isLastPage: promotionModel.data?.data?.pagination?.hasNextPage ?? false,
      ),
    );
  }

  Future<void> _getNextPageOnLoading(
    GetNextPagePromotionEvent event,
    Emitter<PromotionPageState> emit,
  ) async {
    _currentPage = _currentPage + 1;
    emit(
      state.copyWith(currentPage: _currentPage),
    );
  }
}
