part of 'payment_method_bloc.dart';

@immutable
abstract class PaymentMethodEvent {}

class SelectPaymentMethodEvent extends PaymentMethodEvent {
  SelectPaymentMethodEvent(this.idPaymentMethod, this.idUser);

  final String idPaymentMethod;
  final String idUser;
}

class GetDefaultPaymentMethodEvent extends PaymentMethodEvent {
  GetDefaultPaymentMethodEvent(this.userID);

  final String userID;
}

class GetAllPaymentTypeEvent extends PaymentMethodEvent {
  GetAllPaymentTypeEvent();
}

class GetAllPaymentItemEvent extends PaymentMethodEvent {
  GetAllPaymentItemEvent(this.userID);

  final String userID;
}

class CreatePaymentMethodEvent extends PaymentMethodEvent {
  CreatePaymentMethodEvent(this.payload);

  final PaymentRequestBody payload;
}

class EditPaymentMethodEvent extends PaymentMethodEvent {
  EditPaymentMethodEvent({
    required this.id,
    required this.name,
    required this.messageError,
    required this.messageSuccess,
  });

  final String id;
  final String name;
  final String messageError;
  final String messageSuccess;
}

class DeletePaymentMethodEvent extends PaymentMethodEvent {
  DeletePaymentMethodEvent({
    required this.paymentId,
    required this.messageError,
    required this.messageSuccess,
    required this.isPrimaryCard,
    required this.userId,
  });

  final String paymentId;
  final String messageError;
  final String messageSuccess;
  final bool isPrimaryCard;
  final String userId;
}

class GetInfoPaymentEvent extends PaymentMethodEvent {
  GetInfoPaymentEvent(this.userID);

  final String userID;
}
