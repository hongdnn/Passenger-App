import 'package:passenger/core/util/data_state.dart';
import 'package:passenger/features/booking_page/data/model/payment_method_model.dart';
import 'package:passenger/features/payment/data/model/payment_items_model.dart';
import 'package:passenger/features/payment/data/model/payment_type_model.dart';

abstract class PaymentMethodRepo {
  Future<DataState<PaymentMethodModel>> getDefaultPaymentMethod({
    required String id,
  });

  Future<DataState<PaymentItemsModel>> getAllPaymentItem({
    required String id,
  });

  Future<DataState<PaymentTypeModel>> getAllPaymentType();

  Future<DataState<PaymentMethodModel>> setDefaultPaymentMethod({
    required String userId,
    required String paymentId,
  });

  Future<DataState<PaymentMethodModel>> createPaymentMethod({
    required PaymentRequestBody payload,
  });

  Future<DataState<PaymentMethodModel>> editPaymentMethod({
    required String paymentId,
    required String name,
  });

  Future<DataState<PaymentMethodModel>> deletePaymentMethod({
    required String paymentId,
  });
}
