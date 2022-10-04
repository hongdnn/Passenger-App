import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:passenger/core/util/data_state.dart';
import 'package:passenger/features/booking_page/data/model/payment_method_model.dart';
import 'package:passenger/features/payment/data/model/payment_items_model.dart';
import 'package:passenger/features/payment/data/model/payment_type_model.dart';
import 'package:passenger/features/payment/data/repo/payment_method_repo.dart';
import 'package:passenger/features/user/data/model/user.dart';
import 'package:passenger/features/user/data/repo/user_repo.dart';
import 'package:passenger/util/enum.dart';
import 'package:passenger/util/util.dart';
import 'package:passenger/util/widgets/dropdown_alert/data_alert.dart';
import 'package:collection/collection.dart';

part 'payment_method_event.dart';
part 'payment_method_state.dart';

class PaymentMethodBloc extends Bloc<PaymentMethodEvent, PaymentMethodState> {
  PaymentMethodBloc(this._userRepo, this._paymentMethod)
      : super(PaymentMethodState()) {

    on<SelectPaymentMethodEvent>(_onSelectPaymentMethod);
    on<GetDefaultPaymentMethodEvent>(_getDefaultPaymentMethod);
    on<GetAllPaymentTypeEvent>(_getAllPaymentMethod);
    on<GetAllPaymentItemEvent>(_getAllPaymentItem);
    on<CreatePaymentMethodEvent>(_createPaymentMethod);
    on<EditPaymentMethodEvent>(_editPaymentMethod);
    on<DeletePaymentMethodEvent>(_deletePaymentMethod);
    on<GetInfoPaymentEvent>(_getInfoPayment);
  }

  final UserRepo _userRepo;
  final PaymentMethodRepo _paymentMethod;

  Future<void> _onSelectPaymentMethod(
    SelectPaymentMethodEvent event,
    Emitter<PaymentMethodState> emit,
  ) async {
    emit(
      state.copyWith(
        setPaymentDefaultState: LoadState.loading,
      ),
    );

    final DataState<PaymentMethodModel> setDefaultPaymentState =
        await _paymentMethod.setDefaultPaymentMethod(
      paymentId: event.idPaymentMethod,
      userId: event.idUser,
    );

    emit(
      state.copyWith(
        setPaymentDefaultState: setDefaultPaymentState.isSuccess()
            ? LoadState.success
            : LoadState.failure,
        currentPayment: setDefaultPaymentState.isSuccess()
            ? setDefaultPaymentState.data?.data
            : state.currentPayment,
      ),
    );
  }

  User getCurrentUser() {
    return _userRepo.getCurrentUser();
  }

  Future<void> _getDefaultPaymentMethod(
    GetDefaultPaymentMethodEvent event,
    Emitter<PaymentMethodState> emit,
  ) async {
    emit(
      state.copyWith(
        defaultPaymentState: LoadState.loading,
      ),
    );

    final DataState<PaymentMethodModel> defaultPaymentState =
        await _paymentMethod.getDefaultPaymentMethod(id: event.userID);

    emit(
      state.copyWith(
        defaultPaymentState: defaultPaymentState.isSuccess()
            ? LoadState.success
            : LoadState.failure,
        currentPayment: defaultPaymentState.isSuccess()
            ? defaultPaymentState.data?.data
            : state.currentPayment,
      ),
    );
  }

  Future<void> _getAllPaymentItem(
    GetAllPaymentItemEvent event,
    Emitter<PaymentMethodState> emit,
  ) async {
    emit(
      state.copyWith(
        allPaymentItemsState: LoadState.loading,
      ),
    );

    final DataState<PaymentItemsModel> allPaymentItemState =
        await _paymentMethod.getAllPaymentItem(id: event.userID);

    emit(
      state.copyWith(
        allPaymentItemsState: allPaymentItemState.isSuccess()
            ? LoadState.success
            : LoadState.failure,
        listPaymentItem: allPaymentItemState.isSuccess()
            ? allPaymentItemState.data?.data
            : state.listPaymentItem,
      ),
    );
  }

  Future<void> _getAllPaymentMethod(
    GetAllPaymentTypeEvent event,
    Emitter<PaymentMethodState> emit,
  ) async {
    emit(
      state.copyWith(
        allPaymentTypeState: LoadState.loading,
      ),
    );

    final DataState<PaymentTypeModel> allPaymentTypeState =
        await _paymentMethod.getAllPaymentType();

    emit(
      state.copyWith(
        allPaymentTypeState: allPaymentTypeState.isSuccess()
            ? LoadState.success
            : LoadState.failure,
        listPaymentType: allPaymentTypeState.isSuccess()
            ? allPaymentTypeState.data?.data
            : state.listPaymentType,
      ),
    );
  }

  Future<void> _createPaymentMethod(
    CreatePaymentMethodEvent event,
    Emitter<PaymentMethodState> emit,
  ) async {
    emit(
      state.copyWith(
        createPaymentMethodState: LoadState.loading,
      ),
    );

    final DataState<PaymentMethodModel> createPaymentState =
        await _paymentMethod.createPaymentMethod(payload: event.payload);
    PaymentMethodData? paymentMethod = createPaymentState.data?.data;
    List<PaymentMethodData> listPaymentItem = state.listPaymentItem;
    if (createPaymentState.isSuccess() && paymentMethod != null) {
      listPaymentItem.add(paymentMethod);
    }
    emit(
      state.copyWith(
        createPaymentMethodState: createPaymentState.isSuccess()
            ? LoadState.success
            : LoadState.failure,
        listPaymentItem: listPaymentItem,
      ),
    );
  }

  Future<void> _editPaymentMethod(
    EditPaymentMethodEvent event,
    Emitter<PaymentMethodState> emit,
  ) async {
    emit(
      state.copyWith(
        editPaymentMethodState: LoadState.loading,
      ),
    );

    final DataState<PaymentMethodModel> editPaymentState =
        await _paymentMethod.editPaymentMethod(
      name: event.name,
      paymentId: event.id,
    );
    PaymentMethodData? paymentMethod = editPaymentState.data?.data;
    List<PaymentMethodData> listPaymentItem = state.listPaymentItem;
    if (paymentMethod != null) {
      listPaymentItem[listPaymentItem.indexWhere(
        (PaymentMethodData element) => element.id == paymentMethod.id,
      )] = paymentMethod;
    }
    alertDropdownNotify(
      editPaymentState.isSuccess() ? event.messageSuccess : event.messageError,
      '',
      editPaymentState.isSuccess() ? TypeAlert.success : TypeAlert.error,
    );
    emit(
      state.copyWith(
        editPaymentMethodState: editPaymentState.isSuccess()
            ? LoadState.success
            : LoadState.failure,
        listPaymentItem: listPaymentItem,
        currentPayment: state.currentPayment?.id == event.id
            ? paymentMethod
            : state.currentPayment,
      ),
    );
  }

  Future<void> _deletePaymentMethod(
    DeletePaymentMethodEvent event,
    Emitter<PaymentMethodState> emit,
  ) async {
    emit(
      state.copyWith(
        deletePaymentMethodState: LoadState.loading,
      ),
    );
    PaymentMethodData? defaultPayment;

    final DataState<PaymentMethodModel> deletePaymentState =
        await _paymentMethod.deletePaymentMethod(
      paymentId: event.paymentId,
    );
    if (event.isPrimaryCard) {
      //set default payment to scb
      PaymentMethodData? scbPayment = state.listPaymentItem.firstWhereOrNull(
        (PaymentMethodData element) =>
            element.paymentType?.name?.toLowerCase().contains('scb') == true,
      );
      if (scbPayment != null) {
        final DataState<PaymentMethodModel> setDefaultPaymentState =
            await _paymentMethod.setDefaultPaymentMethod(
          paymentId: scbPayment.id ?? '',
          userId: event.userId,
        );
        if (setDefaultPaymentState.isSuccess()) {
          defaultPayment = scbPayment;
        }
      }
    }
    List<PaymentMethodData> listPaymentItem = state.listPaymentItem
        .where((PaymentMethodData element) => element.id != event.paymentId)
        .toList();
    alertDropdownNotify(
      deletePaymentState.isSuccess()
          ? event.messageSuccess
          : event.messageError,
      '',
      deletePaymentState.isSuccess() ? TypeAlert.success : TypeAlert.error,
    );
    emit(
      state.copyWith(
        deletePaymentMethodState: deletePaymentState.isSuccess()
            ? LoadState.success
            : LoadState.failure,
        listPaymentItem: listPaymentItem,
        currentPayment: defaultPayment ?? state.currentPayment,
      ),
    );
  }

  Future<void> _getInfoPayment(
    GetInfoPaymentEvent event,
    Emitter<PaymentMethodState> emit,
  ) async {
    emit(
      state.copyWith(
        infoPaymentState: LoadState.loading,
      ),
    );

    final DataState<PaymentMethodModel> defaultPaymentState =
        await _paymentMethod.getDefaultPaymentMethod(id: event.userID);
    final DataState<PaymentItemsModel> allPaymentItemState =
        await _paymentMethod.getAllPaymentItem(id: event.userID);
    if (defaultPaymentState.isSuccess() && allPaymentItemState.isSuccess()) {
      PaymentMethodData? defaultPayment;
      if (defaultPaymentState.data?.data == null) {
        //set easy scb payment
        List<PaymentMethodData> allPaymentMethod =
            allPaymentItemState.data?.data ?? <PaymentMethodData>[];
        PaymentMethodData? scbPayment = allPaymentMethod.firstWhereOrNull(
          (PaymentMethodData element) =>
              element.paymentType?.name?.toLowerCase().contains('scb') == true,
        );
        final DataState<PaymentMethodModel> setDefaultPaymentState =
            await _paymentMethod.setDefaultPaymentMethod(
          paymentId: scbPayment?.id ?? '',
          userId: event.userID,
        );
        if (setDefaultPaymentState.isSuccess() &&
            setDefaultPaymentState.data?.data != null) {
          defaultPayment = setDefaultPaymentState.data?.data;
        }
      } else {
        defaultPayment = defaultPaymentState.data?.data;
      }
      emit(
        state.copyWith(
          infoPaymentState: LoadState.success,
          listPaymentItem:
              allPaymentItemState.data?.data ?? state.listPaymentItem,
          currentPayment: defaultPayment ?? state.currentPayment,
        ),
      );
    } else {
      emit(
        state.copyWith(
          infoPaymentState: LoadState.failure,
        ),
      );
    }
  }
}
