import 'package:flutter/material.dart';
import 'package:passenger/features/booking_page/presentation/bloc/booking_page_bloc.dart';
import 'package:passenger/features/booking_page/presentation/booking_page.dart';

extension BookingPageExt on State<BookingPage> {
  bool shouldListenDiffPrice(
    BookingPageState previous,
    BookingPageState current,
  ) {
    if (current.carPriceList?.isNotEmpty == true &&
        previous.carPriceList?.isNotEmpty == true) {
      if (previous.carPriceList?[0].cars?.isNotEmpty == true &&
          current.carPriceList?[0].cars?.isNotEmpty == true) {
        return previous.carPriceList?[0].cars?[0].price !=
            current.carPriceList?[0].cars?[0].price;
      }
    }
    return true;
  }
}
