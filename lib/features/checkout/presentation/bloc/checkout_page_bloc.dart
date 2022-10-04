import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passenger/core/util/data_state.dart';
import 'package:passenger/features/checkout/data/repo/checkout_repo.dart';
import 'package:passenger/features/landing_page/data/common_model/common_model.dart';
import 'package:passenger/features/landing_page/data/model/check_booking_availability_model.dart';
import 'package:passenger/features/promotion/data/model/promotion_model.dart';
import 'package:passenger/features/user/data/model/user.dart';
import 'package:passenger/features/user/data/repo/user_repo.dart';
import 'package:passenger/util/enum.dart';

part 'checkout_page_event.dart';

part 'checkout_page_state.dart';

class CheckoutPageBloc extends Bloc<CheckoutPageEvent, CheckoutPageState> {
  CheckoutPageBloc(
    this._userRepo,
    this._checkoutRepo,
  ) : super(CheckoutPageState()) {
    on<AddNoteToDriverEvent>(
      _addNoteToDriver,
    );
    on<ClearDataCheckoutEvent>(_clearData);
    on<GetPromotionEvent>(
      _getPromotion,
    );
    on<GetRbhCoinDiscountEvent>(
      _getRbhCoinDiscount,
    );
    on<GetTotalPriceEvent>(
      getTotalPriceOnChangePromo,
    );
    on<GetDraftingTripByDeviceIdEvent>(
      _getDraftingTripByDeviceIdEvent,
    );
    getCurrentUser();
  }

  User getCurrentUser() {
    return _userRepo.getCurrentUser();
  }

  final UserRepo _userRepo;
  final CheckoutRepository _checkoutRepo;

  void _addNoteToDriver(
    AddNoteToDriverEvent event,
    Emitter<CheckoutPageState> emit,
  ) {
    String? note = event.note;
    emit(
      state.copyWith(
        note: note,
        status: CheckoutPageStatus.addNoteToDriver,
      ),
    );
  }

  Future<void> _clearData(
    ClearDataCheckoutEvent event,
    Emitter<CheckoutPageState> emit,
  ) async {
    emit(
      state.clear(),
    );
  }

  Future<void> _getPromotion(
    GetPromotionEvent event,
    Emitter<CheckoutPageState> emit,
  ) async {
    if (event.selectedPromotionItem == false) {
      emit(state.copyWith(getPromotionStatus: LoadState.loading));
      return;
    }

    emit(
      state.copyWith(
        getPromotionStatus: event.promotionListItem == null
            ? LoadState.loading
            : LoadState.success,
        promotionListItem: event.promotionListItem,
      ),
    );
  }

  Future<void> _getRbhCoinDiscount(
    GetRbhCoinDiscountEvent event,
    Emitter<CheckoutPageState> emit,
  ) async {
    emit(
      state.copyWith(
        rbhCoinDiscount: event.rbhCoinDiscount,
      ),
    );
  }

  void getTotalPriceOnChangePromo(
    GetTotalPriceEvent event,
    Emitter<CheckoutPageState> emit,
  ) {
    emit(
      state.copyWith(
        totalPrice: event.totalPrice,
      ),
    );
  }

  double? getTotalPrice() {
    return state.totalPrice;
  }

  PromotionData getPromotionItem() {
    return state.promotionListItem ?? PromotionData();
  }

  Future<void> _getDraftingTripByDeviceIdEvent(
    GetDraftingTripByDeviceIdEvent event,
    Emitter<CheckoutPageState> emit,
  ) async {
    emit(
      state.copyWith(
        loadDraftTripDataStatus: LoadState.loading,
      ),
    );

    final DataState<Trip> result =
        await _checkoutRepo.getDraftingTripByDeviceId(deviceId: event.deviceId);
    emit(
      state.copyWith(
        loadDraftTripDataStatus:
            result.isSuccess() ? LoadState.success : LoadState.failure,
        draftTripData: result.data,
      ),
    );
  }

  
}
