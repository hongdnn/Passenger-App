import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passenger/core/app_config/get_it/getit_config.dart';
import 'package:passenger/features/booking_page/data/model/cancel_booking_model.dart';
import 'package:passenger/features/booking_page/presentation/bloc/booking_page_bloc.dart';
import 'package:passenger/features/booking_page/presentation/booking_page.dart';
import 'package:passenger/features/booking_page/presentation/cancel_booking_page.dart';
import 'package:passenger/features/checkout/presentation/checkout_page.dart';
import 'package:passenger/features/driver_rating/presentation/driver_rating_page.dart';
import 'package:passenger/features/favorite_location/presentation/favorite_location_picker_page.dart';
import 'package:passenger/features/landing_page/presentation/bloc/landing_page_bloc.dart';
import 'package:passenger/features/location/presentation/bloc/search_bloc.dart';
import 'package:passenger/features/location/presentation/widget/location_picker_page.dart';
import 'package:passenger/features/booking_page/presentation/widget/car_detail_widget.dart';
import 'package:passenger/features/location/search_page.dart';
import 'package:passenger/features/map_page/presentation/map_page/bloc/map_page_bloc.dart';
import 'package:passenger/features/order_history/presentation/order_history_page.dart';
import 'package:passenger/features/payment/create_payment_method_page.dart';
import 'package:passenger/features/payment/presentation/bloc/payment_bloc.dart';
import 'package:passenger/features/payment/presentation/bloc_payment_method/payment_method_bloc.dart';
import 'package:passenger/features/payment/presentation/editing_payment_method_page.dart';
import 'package:passenger/features/payment/presentation/list_payment_method_page.dart';
import 'package:passenger/features/payment/presentation/payment_page.dart';
import 'package:passenger/features/promotion/presentation/promotion_page.dart';
import 'package:passenger/features/sendbird_chat/presentation/conversation_page.dart';
import 'package:passenger/features/sendbird_chat/presentation/view_photo_page.dart';
import 'package:passenger/features/tip_payment/presentation/bloc/tip_payment_bloc.dart';
import 'package:passenger/features/tip_payment/presentation/tip_payment_page.dart';
import 'package:passenger/features/tracking_page/presentation/bloc/tracking_page_bloc.dart';
import 'package:passenger/features/tracking_page/tracking_page.dart';
import 'package:passenger/features/trip_detail/trip_detail_page.dart';
import 'package:passenger/main.dart';
import 'package:passenger/util/mock_notification_supper_app_page.dart';

class AppRouter {
  final BookingPageBloc _bookingPageBloc = getIt<BookingPageBloc>();
  final TrackingPageBloc _trackingPageBloc = getIt<TrackingPageBloc>();
  final LandingPageBloc _landingPageBloc = getIt<LandingPageBloc>();
  final PaymentMethodBloc _paymentMethodBloc = getIt<PaymentMethodBloc>();
  final MapPageBloc _mapPageBloc = getIt<MapPageBloc>();
  final PaymentBloc _paymentBloc = getIt<PaymentBloc>();
  final SearchBloc _searchBloc = getIt<SearchBloc>();
  final TipPaymentBloc _tipPaymentBloc = getIt<TipPaymentBloc>();

  Route<dynamic> generateRoute(RouteSettings settings) {
    log('Screen Name: ${settings.name}');
    switch (settings.name) {
      case MyHomePage.routeName:
        return MaterialPageRoute<MyHomePage>(
          builder: (_) => MultiBlocProvider(
            providers: <BlocProvider<dynamic>>[
              BlocProvider<BookingPageBloc>.value(
                value: _bookingPageBloc,
              ),
              BlocProvider<TrackingPageBloc>.value(
                value: _trackingPageBloc,
              ),
              BlocProvider<LandingPageBloc>.value(
                value: _landingPageBloc,
              ),
              BlocProvider<MapPageBloc>.value(
                value: _mapPageBloc,
              ),
              BlocProvider<SearchBloc>.value(
                value: _searchBloc,
              ),
            ],
            child: const MyHomePage(),
          ),
          settings: settings,
        );
      case BookingPage.routeName:
        BookingArg bookingArg = settings.arguments as BookingArg;
        return MaterialPageRoute<BookingPage>(
          builder: (_) => BlocProvider<BookingPageBloc>.value(
            value: _bookingPageBloc,
            child: BookingPage(
              arg: bookingArg,
            ),
          ),
          settings: RouteSettings(
            name: BookingPage.routeName,
            arguments: BookingArg(
              bookingLocationList: BookingLocationList(),
            ),
          ),
        );
      case SearchPage.routeName:
        late SearchPageArgs args;
        if (settings.arguments is SearchPageArgs) {
          args = settings.arguments as SearchPageArgs;
        } else {
          args = SearchPageArgs();
        }
        return MaterialPageRoute<dynamic>(
          builder: (_) => SearchPage(
            args: args,
          ),
          settings: settings,
        );
      case PromotionPage.routeName:
        late PromotionPageArg args;
        if (settings.arguments is PromotionPageArg) {
          args = settings.arguments as PromotionPageArg;
        } else {
          args = PromotionPageArg();
        }
        return MaterialPageRoute<PromotionPage>(
          builder: (_) => PromotionPage(
            args: args,
          ),
          settings: RouteSettings(
            name: PromotionPage.routeName,
            arguments: args,
          ),
        );
      case LocationPickerPage.routeName:
        late LocationPickerArg args;
        if (settings.arguments is LocationPickerArg) {
          args = settings.arguments as LocationPickerArg;
        } else {
          args = LocationPickerArg();
        }
        log(args.toString());
        return MaterialPageRoute<LocationPickerPage>(
          builder: (_) => LocationPickerPage(
            args: args,
          ),
          settings: settings,
        );
      case CarDetailWidget.routeName:
        late CarDetailArgs args;
        if (settings.arguments is CarDetailArgs) {
          args = settings.arguments as CarDetailArgs;
        } else {
          args = CarDetailArgs();
        }
        return MaterialPageRoute<CarDetailWidget>(
          builder: (_) => BlocProvider<BookingPageBloc>.value(
            value: _bookingPageBloc,
            child: CarDetailWidget(
              args: args,
            ),
          ),
          settings: settings,
        );
      case DriverRatingPage.routeName:
        late DriverRatingPageArgs args;
        if (settings.arguments is DriverRatingPageArgs) {
          args = settings.arguments as DriverRatingPageArgs;
        } else {
          args = DriverRatingPageArgs(bookingId: '');
        }
        return MaterialPageRoute<DriverRatingPage>(
          builder: (_) => MultiBlocProvider(
            providers: <BlocProvider<dynamic>>[
              BlocProvider<BookingPageBloc>.value(
                value: _bookingPageBloc,
              ),
              BlocProvider<TrackingPageBloc>.value(
                value: _trackingPageBloc,
              ),
              BlocProvider<LandingPageBloc>.value(
                value: _landingPageBloc,
              ),
            ],
            child: DriverRatingPage(
              args: args,
            ),
          ),
          settings: settings,
        );
      case CheckoutPage.routeName:
        late CheckoutArg args;
        if (settings.arguments is CheckoutArg) {
          args = settings.arguments as CheckoutArg;
        } else {
          args = CheckoutArg();
        }
        return MaterialPageRoute<CheckoutPage>(
          builder: (_) => MultiBlocProvider(
            providers: <BlocProvider<dynamic>>[
              BlocProvider<BookingPageBloc>.value(
                value: _bookingPageBloc,
              ),
              BlocProvider<LandingPageBloc>.value(
                value: _landingPageBloc,
              ),
              BlocProvider<PaymentMethodBloc>.value(
                value: _paymentMethodBloc,
              ),
            ],
            child: CheckoutPage(
              args: args,
            ),
          ),
          settings: settings,
        );
      case CancelBooking.routeName:
        CancelBookingBody cancelBookingArg;
        if (settings.arguments != null) {
          cancelBookingArg = settings.arguments as CancelBookingBody;
        } else {
          cancelBookingArg = CancelBookingBody();
        }

        return MaterialPageRoute<CancelBooking>(
          builder: (_) => MultiBlocProvider(
            providers: <BlocProvider<dynamic>>[
              BlocProvider<BookingPageBloc>.value(
                value: _bookingPageBloc,
              ),
              BlocProvider<TrackingPageBloc>.value(
                value: _trackingPageBloc,
              ),
              BlocProvider<LandingPageBloc>.value(
                value: _landingPageBloc,
              ),
            ],
            child: CancelBooking(
              cancelBookingArg: cancelBookingArg,
            ),
          ),
          settings: settings,
        );
      case TrackingPage.routeName:
        late TrackingArgs args;
        if (settings.arguments is TrackingArgs) {
          args = settings.arguments as TrackingArgs;
        } else {
          args = TrackingArgs(isDriverFound: false, isLandingPageNavTo: false);
        }
        return MaterialPageRoute<TrackingPage>(
          builder: (_) => MultiBlocProvider(
            providers: <BlocProvider<dynamic>>[
              BlocProvider<BookingPageBloc>.value(
                value: _bookingPageBloc,
              ),
              BlocProvider<TrackingPageBloc>.value(
                value: _trackingPageBloc,
              ),
              BlocProvider<LandingPageBloc>.value(
                value: _landingPageBloc,
              ),
              BlocProvider<PaymentMethodBloc>.value(
                value: _paymentMethodBloc,
              ),
            ],
            child: TrackingPage(
              trackingArgs: args,
            ),
          ),
          settings: settings,
        );
      case FavoriteLocationPickerPage.routeName:
        late FavoriteLocationPickerArg args;
        if (settings.arguments is FavoriteLocationPickerArg) {
          args = settings.arguments as FavoriteLocationPickerArg;
        } else {
          args = FavoriteLocationPickerArg();
        }
        return MaterialPageRoute<FavoriteLocationPickerPage>(
          builder: (_) => FavoriteLocationPickerPage(
            args: args,
          ),
          settings: settings,
        );
      case PaymentPage.routeName:
        late PaymentArg args;
        if (settings.arguments is PaymentArg) {
          args = settings.arguments as PaymentArg;
        } else {
          args = PaymentArg(listLocation: null);
        }
        return MaterialPageRoute<PaymentPage>(
          builder: (_) => MultiBlocProvider(
            providers: <BlocProvider<dynamic>>[
              BlocProvider<PaymentMethodBloc>.value(
                value: _paymentMethodBloc,
              ),
              BlocProvider<PaymentBloc>.value(
                value: _paymentBloc,
              ),
            ],
            child: PaymentPage(
              args: args,
            ),
          ),
          settings: settings,
        );
      case OrderHistoryPage.routeName:
        late OrderHistoryPageArgs args;
        if (settings.arguments is OrderHistoryPageArgs) {
          args = settings.arguments as OrderHistoryPageArgs;
        } else {
          args = OrderHistoryPageArgs();
        }
        return MaterialPageRoute<OrderHistoryPage>(
          builder: (_) => OrderHistoryPage(
            args: args,
          ),
          settings: RouteSettings(
            name: OrderHistoryPage.routeName,
            arguments: OrderHistoryPageArgs(),
          ),
        );
      case TripDetailPage.routeName:
        TripDetailPageArgs args;
        if (settings.arguments != null) {
          args = settings.arguments as TripDetailPageArgs;
        } else {
          args = TripDetailPageArgs();
        }
        return MaterialPageRoute<TripDetailPage>(
          builder: (_) => TripDetailPage(
            args: args,
          ),
          settings: RouteSettings(
            name: TripDetailPage.routeName,
            arguments: TripDetailPageOutputArgs(),
          ),
        );
      case ConversationPage.routeName:
        ConversationArg arg;
        if (settings.arguments != null) {
          arg = settings.arguments as ConversationArg;
        } else {
          arg = ConversationArg(
            driverId: '',
            driverName: '',
          );
        }

        return MaterialPageRoute<TripDetailPage>(
          builder: (_) => ConversationPage(
            arg: arg,
          ),
          settings: settings,
        );
      case ListPaymentMethodPage.routeName:
        ListPaymentMethodArg listPaymentMethodArg;
        if (settings.arguments != null) {
          listPaymentMethodArg = settings.arguments as ListPaymentMethodArg;
        } else {
          listPaymentMethodArg = ListPaymentMethodArg();
        }

        return MaterialPageRoute<ListPaymentMethodArg>(
          builder: (_) => MultiBlocProvider(
            providers: <BlocProvider<dynamic>>[
              BlocProvider<PaymentMethodBloc>.value(
                value: _paymentMethodBloc,
              ),
            ],
            child: ListPaymentMethodPage(
              listPaymentMethodArg: listPaymentMethodArg,
            ),
          ),
          settings: settings,
        );
      case CreatePaymentMethodPage.routeName:
        return MaterialPageRoute<CreatePaymentMethodPage>(
          builder: (_) => BlocProvider<PaymentMethodBloc>.value(
            value: _paymentMethodBloc,
            child: const CreatePaymentMethodPage(),
          ),
          settings: settings,
        );

      case EditingPaymentMethodPage.routeName:
        return MaterialPageRoute<EditingPaymentMethodPage>(
          builder: (_) => BlocProvider<PaymentMethodBloc>.value(
            value: _paymentMethodBloc,
            child: const EditingPaymentMethodPage(),
          ),
          settings: settings,
        );
      case MockNotificationSupperAppPage.routeName:
        return MaterialPageRoute<MockNotificationSupperAppPage>(
          builder: (_) => const MockNotificationSupperAppPage(),
          settings: settings,
        );

      case TipPaymentPage.routeName:
        TipPaymentPageArgs args;
        if (settings.arguments != null) {
          args = settings.arguments as TipPaymentPageArgs;
        } else {
          args = TipPaymentPageArgs();
        }
        return MaterialPageRoute<TipPaymentPage>(
          builder: (_) => MultiBlocProvider(
            providers: <BlocProvider<dynamic>>[
              BlocProvider<PaymentMethodBloc>.value(
                value: _paymentMethodBloc,
              ),
              BlocProvider<TipPaymentBloc>.value(
                value: _tipPaymentBloc,
              ),
            ],
            child: TipPaymentPage(
              args: args,
            ),
          ),
        );
      case ViewPhotoPage.routeName:
        ViewPhotoPageArg args;
        if (settings.arguments != null) {
          args = settings.arguments as ViewPhotoPageArg;
        } else {
          args = ViewPhotoPageArg(imageUrl: '');
        }
        return MaterialPageRoute<ViewPhotoPage>(
          builder: (_) => ViewPhotoPage(
            arg: args,
          ),
          settings: settings,
        );
      default:
        return MaterialPageRoute<Scaffold>(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
          settings: settings,
        );
    }
  }
}
