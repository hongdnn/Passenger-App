part of 'payment_method_bloc.dart';

class PaymentMethodState {
  PaymentMethodState({
    this.currentPayment,
    this.defaultPaymentState,
    this.allPaymentItemsState,
    this.allPaymentTypeState,
    this.setPaymentDefaultState,
    this.createPaymentMethodState,
    this.editPaymentMethodState,
    this.deletePaymentMethodState,
    this.infoPaymentState,
    this.listPaymentType = const <PaymentType>[],
    this.listPaymentItem = const <PaymentMethodData>[],
  });

  final PaymentMethodData? currentPayment;
  final LoadState? defaultPaymentState;
  final LoadState? allPaymentTypeState;
  final LoadState? allPaymentItemsState;
  final LoadState? setPaymentDefaultState;
  final LoadState? createPaymentMethodState;
  final LoadState? editPaymentMethodState;
  final LoadState? deletePaymentMethodState;
  final LoadState? infoPaymentState;
  final List<PaymentType>? listPaymentType;
  final List<PaymentMethodData> listPaymentItem;

  PaymentMethodState copyWith({
    LoadState? defaultPaymentState,
    LoadState? allPaymentTypeState,
    LoadState? allPaymentItemsState,
    LoadState? setPaymentDefaultState,
    LoadState? createPaymentMethodState,
    LoadState? editPaymentMethodState,
    LoadState? deletePaymentMethodState,
    LoadState? infoPaymentState,
    PaymentMethodData? currentPayment,
    List<PaymentType>? listPaymentType,
    List<PaymentMethodData>? listPaymentItem,
  }) {
    return PaymentMethodState(
      defaultPaymentState: defaultPaymentState ?? this.defaultPaymentState,
      allPaymentTypeState: allPaymentTypeState ?? this.allPaymentTypeState,
      allPaymentItemsState: allPaymentItemsState ?? this.allPaymentItemsState,
      createPaymentMethodState:
          createPaymentMethodState ?? this.createPaymentMethodState,
      editPaymentMethodState:
          editPaymentMethodState ?? this.editPaymentMethodState,
      deletePaymentMethodState:
          deletePaymentMethodState ?? this.deletePaymentMethodState,
      infoPaymentState: infoPaymentState ?? this.infoPaymentState,
      setPaymentDefaultState:
          setPaymentDefaultState ?? this.setPaymentDefaultState,
      currentPayment: currentPayment ?? this.currentPayment,
      listPaymentType: listPaymentType ?? this.listPaymentType,
      listPaymentItem: listPaymentItem ?? this.listPaymentItem,
    );
  }
}
