import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:passenger/core/app_config/dio/dio_config.dart';
import 'package:passenger/core/app_config/env/app_env.dart';
import 'package:passenger/core/app_config/get_it/bloc_register.dart';
import 'package:passenger/core/app_config/get_it/data_source_register.dart';
import 'package:passenger/core/app_config/get_it/repo_register.dart';
import 'package:passenger/core/app_config/navigation/connectivity_service.dart';
import 'package:passenger/core/app_config/notification/config_notification.dart';
import 'package:passenger/core/network/gg_client.dart';
import 'package:passenger/core/network/rh_base_api.dart';
import 'package:passenger/features/checkout/data/repo/checkout_repo.dart';
import 'package:passenger/features/checkout/data/repo/checkout_repo_impl.dart';
import 'package:passenger/features/checkout/presentation/bloc/checkout_page_bloc.dart';
import 'package:passenger/features/booking_page/presentation/bloc_cancel/cancel_booking_bloc.dart';
import 'package:passenger/features/driver_rating/data/repo/driver_rating_repo.dart';
import 'package:passenger/features/driver_rating/data/repo/driver_rating_repo_impl.dart';
import 'package:passenger/features/driver_rating/presentation/bloc/driver_rating_bloc.dart';
import 'package:passenger/features/favorite_location/presentation/bloc/favorite_location_bloc.dart';
import 'package:passenger/features/landing_page/data/repo/banner_repo.dart';
import 'package:passenger/features/landing_page/data/repo/banner_repo_impl.dart';
import 'package:passenger/features/landing_page/data/repo/booking_availability_repo.dart';
import 'package:passenger/features/landing_page/data/repo/booking_availability_repo_impl.dart';
import 'package:passenger/features/landing_page/data/repo/booking_history_repo.dart';
import 'package:passenger/features/landing_page/data/repo/booking_history_repo_impl.dart';
import 'package:passenger/features/landing_page/presentation/bloc/landing_page_bloc.dart';
import 'package:passenger/features/booking_page/data/repo/car_detail_impl.dart';
import 'package:passenger/features/booking_page/data/repo/car_repo.dart';
import 'package:passenger/features/booking_page/presentation/bloc/booking_page_bloc.dart';
import 'package:passenger/features/booking_page/data/repo/booking_repo.dart';
import 'package:passenger/features/booking_page/data/repo/booking_repo_impl.dart';
import 'package:passenger/features/location/data/repo/autocomplete_repo.dart';
import 'package:passenger/features/location/data/repo/autocomplete_repo_impl.dart';
import 'package:passenger/features/location/data/repo/current_location_repo.dart';
import 'package:passenger/features/location/data/repo/current_location_repo_impl.dart';
import 'package:passenger/features/favorite_location/data/repo/favorite_location_repo.dart';
import 'package:passenger/features/favorite_location/data/repo/favorite_location_repo_impl.dart';
import 'package:passenger/features/location/data/repo/geocoding_repo.dart';
import 'package:passenger/features/location/data/repo/geocoding_repo_imlp.dart';
import 'package:passenger/features/location/data/repo/placedetail_repo.dart';
import 'package:passenger/features/location/data/repo/placedetail_repo_impl.dart';
import 'package:passenger/features/location/data/repo/polyline_repo.dart';
import 'package:passenger/features/map_page/data/repo/map_page_repo.dart';
import 'package:passenger/features/map_page/data/repo/map_page_repo_impl.dart';
import 'package:passenger/features/map_page/presentation/map_page/bloc/map_page_bloc.dart';
import 'package:passenger/features/location/presentation/bloc/search_bloc.dart';
import 'package:passenger/features/order_history/data/repo/booking_history_trip_repo.dart';
import 'package:passenger/features/order_history/data/repo/booking_history_trip_repo_impl.dart';
import 'package:passenger/features/order_history/presentation/bloc/order_history_bloc.dart';
import 'package:passenger/features/payment/data/repo/payment_method_repo.dart';
import 'package:passenger/features/payment/data/repo/payment_method_repo_impl.dart';
import 'package:passenger/features/payment/data/repo/payment_repo.dart';
import 'package:passenger/features/payment/data/repo/payment_repo_impl.dart';
import 'package:passenger/features/payment/presentation/bloc/payment_bloc.dart';
import 'package:passenger/features/payment/presentation/bloc_payment_method/payment_method_bloc.dart';
import 'package:passenger/features/promotion/data/repo/promotion_repo.dart';
import 'package:passenger/features/promotion/data/repo/promotion_repo_impl.dart';
import 'package:passenger/features/promotion/presentation/bloc/promotion_page_bloc.dart';
import 'package:passenger/features/tip_payment/data/repo/tip_payment_repo.dart';
import 'package:passenger/features/tip_payment/data/repo/tip_payment_repo_impl.dart';
import 'package:passenger/features/tip_payment/presentation/bloc/tip_payment_bloc.dart';
import 'package:passenger/features/tracking_page/data/repo/tracking_page_repo.dart';
import 'package:passenger/features/tracking_page/data/repo/tracking_page_repo_impl.dart';
import 'package:passenger/features/tracking_page/presentation/bloc/tracking_page_bloc.dart';
import 'package:passenger/features/trip_detail/data/repo/invoice_repo.dart';
import 'package:passenger/features/trip_detail/data/repo/invoice_repo_impl.dart';
import 'package:passenger/features/trip_detail/presentation/bloc/invoice_bloc.dart';
import 'package:passenger/features/user/data/repo/user_repo.dart';
import 'package:passenger/features/user/data/repo/user_repo_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../env/logger_config.dart';
import '../sendbird/sendbird_di.dart';

final GetIt getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerSingleton<AppEnvironment>(AppEnvironment());
  // Init get it for dio
  DioConfig.initDi();
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);

  // Services + API endpoints
  final EnvConfig appConfig = getIt<AppEnvironment>().getConfig();
  getIt.registerLazySingleton<GgClientApi>(
    () => GgClientApi(
      getIt<Dio>(),
      baseUrl: appConfig.networkConfig.ggBaseUrl,
    ),
  );
  getIt.registerLazySingleton<RhBaseApi>(
    () => RhBaseApi(
      getIt<Dio>(),
      baseUrl: appConfig.networkConfig.rhBaseUrl,
    ),
  );

  getIt.registerLazySingleton<ConnectivityService>(() => ConnectivityService());

  getIt.registerFactory<PromotionRepo>(() => PromotionRepoImpl(getIt()));
  getIt.registerFactory<PromotionPageBloc>(
    () => PromotionPageBloc(
      getIt(),
      getIt(),
    ),
  );
  getIt.registerFactory<AutocompleteRepo>(() => AutoCompleteRepoImpl(getIt()));
  getIt.registerFactory<GeocodingRepo>(() => GeocodingRepoImlp(getIt()));
  getIt
      .registerFactory<BookingRepository>(() => BookingRepositoryImpl(getIt()));
  getIt.registerFactory<PlaceDetailRepo>(
    () => PlaceDetailRepoImpl(
      getIt(),
      getIt(),
    ),
  );
  getIt.registerFactory<UserRepo>(
    () => UserRepoImpl(
      RhBaseApi(
        getIt<Dio>(),
        baseUrl: 'https://rbh-rh-cs-dev-api.gcp.alp-robinhood.com',
      ),
    ),
  );
  getIt.registerLazySingleton<CurrentLocationRepo>(
    () => CurrentLocationRepoImpl(),
  );
  getIt.registerLazySingleton<PolylineRepo>(
    () => PolylineRepoImpl(getIt()),
  );
  getIt.registerFactory<FavoriteLocationRepo>(
    () => FavoriteLocationRepoImpl(getIt()),
  );
  getIt.registerFactory<SearchBloc>(
    () => SearchBloc(
      getIt(),
      getIt(),
      getIt(),
      getIt(),
      getIt(),
      getIt(),
    ),
  );
  getIt.registerFactory<MapPageRepo>(() => MapPageRepoImpl(getIt()));

  getIt.registerFactory<MapPageBloc>(() => MapPageBloc(getIt(), getIt()));
  getIt.registerFactory<BannerRepo>(() => BannerRepoImpl(getIt()));
  getIt.registerFactory<BookingHistoryRepo>(
    () => BookingHistoryRepoImpl(getIt()),
  );
  getIt.registerFactory<BookingAvailabilityRepo>(
    () => BookingAvailabilityRepoImpl(getIt()),
  );
  getIt.registerFactory<LandingPageBloc>(
    () => LandingPageBloc(getIt(), getIt(), getIt(), getIt(), getIt()),
  );

  //Car description
  getIt.registerFactory<CarRepo>(() => CarRepoImpl(getIt()));
  getIt.registerFactory<BookingPageBloc>(
    () => BookingPageBloc(getIt(), getIt(), getIt(), getIt()),
  );

  getIt.registerFactory<DriverRatingRepo>(() => DriverRatingRepoImpl(getIt()));
  getIt.registerFactory<DriverRatingBloc>(() => DriverRatingBloc(getIt()));
  getIt.registerFactory<CheckoutRepository>(
    () => CheckoutRepositoryImpl(getIt()),
  );

  getIt.registerFactory<CancelBookingBloc>(() => CancelBookingBloc(getIt()));
  getIt.registerFactory<CheckoutPageBloc>(
    () => CheckoutPageBloc(getIt(), getIt()),
  );
  getIt.registerFactory<FavoriteLocationBloc>(
    () => FavoriteLocationBloc(getIt(), getIt(), getIt()),
  );

  getIt
      .registerFactory<TrackingPageRepo>((() => TrackingPageRepoImpl(getIt())));
  getIt.registerFactory<TrackingPageBloc>(
    (() => TrackingPageBloc(
          getIt(),
          getIt(),
          getIt(),
          getIt(),
        )),
  );
  getIt.registerFactory<PaymentRepo>((() => PaymentRepoImpl(getIt())));
  getIt.registerFactory<PaymentBloc>((() => PaymentBloc(getIt(), getIt())));

  getIt.registerFactory<BookingHistoryTripRepo>(
    (() => BookingHistoryTripRepoImpl(getIt())),
  );
  getIt.registerFactory<OrderHistoryBloc>(
    (() => OrderHistoryBloc(getIt(), getIt())),
  );
  getIt.registerFactory<InvoiceRepo>((() => InvoiceRepoImpl(getIt())));
  getIt.registerFactory<InvoiceBloc>((() => InvoiceBloc(getIt(), getIt())));
  getIt.registerFactory<PaymentMethodRepo>(
    (() => PaymentMethodRepoImpl(getIt())),
  );
  getIt.registerFactory<PaymentMethodBloc>(
    (() => PaymentMethodBloc(getIt(), getIt())),
  );
  getIt.registerLazySingleton<LoggerConfig>(
    () => LoggerConfig(
        // buildMode: buildMode
        ),
  );
  getIt.registerFactory<ConfigNotification>(
    () => ConfigNotification(getIt()),
  );

  getIt.registerFactory<TipPaymentRepo>(
    (() => TipPaymentRepoImpl(getIt())),
  );
  getIt.registerFactory<TipPaymentBloc>(
    (() => TipPaymentBloc(getIt(), getIt())),
  );

  SendbirdDI.init(getIt, environment: defaultEnv);
  DatasourceRegister.init(getIt);
  RepoRegister.init(getIt);
  BlocRegister.init(getIt);
}
