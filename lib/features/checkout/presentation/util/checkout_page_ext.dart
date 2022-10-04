import 'package:passenger/features/checkout/presentation/bloc/checkout_page_bloc.dart';

extension CheckoutNoteToDriverExtension on CheckoutPageState {
  bool isNoteValid() {
    return note?.isNotEmpty ?? false;
  }
}
