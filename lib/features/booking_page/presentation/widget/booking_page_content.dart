import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passenger/core/app_config/constant.dart';
import 'package:passenger/core/util/localization.dart';
import 'package:passenger/features/booking_page/data/model/price_by_cartype_model.dart';
import 'package:passenger/features/booking_page/data/model/upsert_draft_booking_model.dart';
import 'package:passenger/features/booking_page/presentation/bloc/booking_page_bloc.dart';
import 'package:passenger/features/booking_page/presentation/booking_page.dart';
import 'package:passenger/features/booking_page/presentation/widget/booking_options_widget.dart';
import 'package:passenger/features/booking_page/presentation/widget/car_type_widget.dart';
import 'package:passenger/features/booking_page/presentation/widget/silent_ride.dart';
import 'package:passenger/features/booking_page/presentation/widget/time_picker.dart';
import 'package:passenger/features/checkout/presentation/checkout_page.dart';
import 'package:passenger/features/location/search_page.dart';
import 'package:passenger/util/enum.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/widgets/create_and_add_new_address_widget.dart';
import 'package:passenger/util/widgets/custom_dialog.dart';

class BookingPageContent extends StatefulWidget {
  const BookingPageContent({
    Key? key,
    required this.runExpandCheck,
    required this.isBookingNow,
    required this.selectedCarType,
    required this.selectedDateTime,
    required this.listLocaleRequest,
    required this.currentCategory,
    required this.bookingAdvanceAnimation,
    this.distanceEst = 0,
    this.timeEst = 0,
    required this.onTapCarItem,
    required this.valueSilentRide,
  }) : super(key: key);
  final Function(bool) runExpandCheck;
  final ValueNotifier<bool> isBookingNow;
  final ValueNotifier<CarInfoByPrice?> selectedCarType;
  final ValueNotifier<DateTime?> selectedDateTime;
  final ValueNotifier<bool> valueSilentRide;
  final ValueNotifier<int> currentCategory;
  final Animation<double> bookingAdvanceAnimation;
  final List<LocationRequest> listLocaleRequest;
  final double distanceEst;
  final double timeEst;
  final Function({
    int currentTypeId,
    int driverIndex,
    BookingPageState bookingPageState,
  }) onTapCarItem;

  @override
  State<BookingPageContent> createState() => _BookingPageContentState();
}

class _BookingPageContentState extends State<BookingPageContent> {
  void _changeValueDestination(int destinationIndex, BookingArg arguments) {
    if (arguments.bookingLocationList?.location != null) {
      BlocProvider.of<BookingPageBloc>(context).add(
        ChangeValueEvent(
          index: destinationIndex,
          data: LocationRequest.fromLocationAddressModel(
            arguments.bookingLocationList!.location!,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: <Widget>[
          SizedBox(height: 8.h),
          BookingOptionsWidget(
            onOptionChanged: (int index) {
              widget.runExpandCheck(index == bookInAdvanceIndex);
              widget.isBookingNow.value = index != bookInAdvanceIndex;
              if (index != bookInAdvanceIndex) {
                widget.selectedDateTime.value = null;
              }
              widget.selectedCarType.value = null;
            },
          ),
          BlocConsumer<BookingPageBloc, BookingPageState>(
            listenWhen: (BookingPageState previous, BookingPageState current) {
              return (current.upsertBookingState !=
                      previous.upsertBookingState) ||
                  (current.updateDestinationStatus == true);
            },
            listener: (BuildContext context, BookingPageState state) {
              if (state.updateDestinationStatus == true) {
                BlocProvider.of<BookingPageBloc>(context).add(
                  GetDirectionFromOriginToDestination(
                    listLocaleRequest: state.listLocaleRequest,
                  ),
                );
              }

              if (state.upsertBookingState == LoadState.success &&
                  state.updateDestinationStatus == false) {
                Navigator.pop(context);
                Navigator.pushNamed(
                  context,
                  CheckoutPage.routeName,
                  arguments: CheckoutArg(
                    carName: widget.selectedCarType.value?.typeName,
                  ),
                ).then((_) {
                  BlocProvider.of<BookingPageBloc>(context).add(
                    LoadingCarPriceListEvent(
                      getPriceRequestBody: GetPriceRequestBody(
                        depLat: widget.listLocaleRequest.first.latitude,
                        depLng: widget.listLocaleRequest.first.longitude,
                        desLat: widget.listLocaleRequest.last.latitude,
                        desLng: widget.listLocaleRequest.last.longitude,
                        distance: radiusDriverMeter.toInt(),
                      ),
                    ),
                  );
                });
              } else if (state.upsertBookingState == LoadState.failure) {
                showCommonErrorDialog(
                  context: context,
                  message: S(context).upsert_error_content,
                  negativeTitle: S(context).confirm,
                  title: S(context).upsert_error_title,
                );
              }
            },
            builder: (BuildContext context, BookingPageState state) {
              return CreateAddAddressWidget(
                listLocation:
                    List<LocationRequest>.from(state.listLocaleRequest),
                onAdd: () {
                  BlocProvider.of<BookingPageBloc>(context)
                      .add(AddNewToListBooking());
                },
                onDelete: (int index) {
                  BlocProvider.of<BookingPageBloc>(context)
                      .add(RemoveAtListBooking(index: index));
                },
                onSwap: (int first, int second) {
                  BlocProvider.of<BookingPageBloc>(context).add(
                    SwapListBooking(first: first, second: second),
                  );
                },
                onReorder: (int oldIndex, int newIndex) {
                  BlocProvider.of<BookingPageBloc>(context).add(
                    ReOrderListBooking(
                      newIndex: newIndex,
                      oldIndex: oldIndex,
                    ),
                  );
                },
                onTapDestination: (int index) {
                  Navigator.pushNamed(
                    context,
                    SearchPage.routeName,
                    arguments: SearchPageArgs(
                      locationPickParent: LocationPickParent.booking,
                    ),
                  ).then((_) {
                    final BookingArg arguments = ModalRoute.of(context)
                        ?.settings
                        .arguments as BookingArg;
                    _changeValueDestination(index, arguments);
                  });
                },
              );
            },
          ),
          SizedBox(height: 10.h),
          TimePickerContent(
            bookingAdvanceAnimation: widget.bookingAdvanceAnimation,
            selectedDateTime: widget.selectedDateTime,
          ),
          SizedBox(height: 16.h),
          CarTypeWidget(
            currentCategory: widget.currentCategory,
            onTapCarItem: widget.onTapCarItem,
            selectedCarType: widget.selectedCarType,
          ),
          SizedBox(height: 24.h),
          SilentRide(
            valueSilentRide: widget.valueSilentRide,
          ),
          SizedBox(height: 100.h),
        ],
      ),
    );
  }
}
