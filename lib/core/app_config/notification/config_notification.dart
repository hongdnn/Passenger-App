import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:passenger/core/app_config/get_it/getit_config.dart';
import 'package:passenger/core/app_config/notification/data_notification_model.dart';
import 'package:passenger/features/booking_page/data/model/booking_order_model.dart';
import 'package:passenger/features/booking_page/data/model/upsert_draft_booking_model.dart';
import 'package:passenger/features/landing_page/data/common_model/common_model.dart';
import 'package:passenger/features/landing_page/data/repo/booking_availability_repo.dart';
import 'package:passenger/features/sendbird_chat/presentation/conversation_page.dart';
import 'package:passenger/features/tracking_page/data/model/driver_accept_booking_model.dart';
import 'package:passenger/features/tracking_page/tracking_page.dart';
import 'package:passenger/features/user/data/repo/user_repo.dart';
import 'package:passenger/main.dart';
import 'package:passenger/util/mock_notification_supper_app_page.dart';

import '../../util/data_state.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description:
      'This channel is used for important notifications.', // description
  importance: Importance.high,
  playSound: true,
);

class ConfigNotification {
  ConfigNotification(this._userRepo);

  final UserRepo _userRepo;
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void initialize() async {
    await FirebaseMessaging.instance.setAutoInitEnabled(true);

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      log('User granted provisional permission');
    } else {
      log('User declined or has not accepted permission');
    }

    String? fcmToken = await messaging.getToken();
    log('fcmToken:$fcmToken');

    messaging.subscribeToTopic('UPDATE_PRICE');
    _userRepo.upsertFCMToken(fcmToken: fcmToken ?? '');

    messaging.onTokenRefresh.listen((String fcmToken) {}).onError((_) {});

    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      DataNotificationModel dataNotificationModel =
          DataNotificationModel.fromJson(message.data);
      log('onMessageOpenedApp:${jsonEncode(dataNotificationModel)}');

      DriverAcceptBookingModel driverAcceptBookingModel =
          await getDriverAcceptBookingInfo(
        id: dataNotificationModel.bookingId ?? '',
      );
      List<LocationRequest> listLocaleRequest = <LocationRequest>[];
      for (TripLocation location
          in driverAcceptBookingModel.data!.trip!.locations!) {
        listLocaleRequest.add(
          LocationRequest(
            longitude: location.longitude,
            latitude: location.latitude,
            address: location.address,
            googleId: location.googleId,
            referenceId: location.referenceId,
            addressName: location.addressName,
            note: location.note.toString(),
          ),
        );
      }
      // -     DRIVER_CANCEL_TRIP= 1,
      // -     DRIVER_ACCEPT_TRIP:2,
      // -     DRIVER_WILL_ARRIVE_IN_1_HOUR:3,
      // -     DRIVER_ALMOST_ARRIVE:4,
      // -     DRIVER_ARRIVE:5,
      // -     DRIVER_CONFIRM_PICKUP_PASSENGER:6,
      // -     DRIVER_FINISH_ONE_DESTINATION:7,
      // -     DRIVER_FINISH_TRIP:8
      // -     DRIVER_UPDATE_PRICE:9
      // -     DRIVER_TRACKING_LOCATION: 10,
      // -     PAYMENT_VERIFICATION_IN_PROGRESS: 11,
      // -     PAYMENT_FAIL: 12,
      switch (dataNotificationModel.actionCode) {
        case '1':
          navigateScreen(
            routePath: TrackingPage.routeName,
            arg: TrackingArgs(
              isDriverFound: true,
              bookingOrderModel: BookingOrderModel(
                data: BookingData(
                  id: driverAcceptBookingModel.data?.id,
                  userId: driverAcceptBookingModel.data?.userId,
                ),
              ),
              distance: 2.2,
              driverAcceptBookingModel: driverAcceptBookingModel,
              isBookingNow: true,
              listLocationRequest: listLocaleRequest,
              price: 10.5,
              timeEst: 2.6,
              isLandingPageNavTo: true,
            ),
          );
          break;
        case '2':
          navigateScreen(
            routePath: TrackingPage.routeName,
            arg: TrackingArgs(
              isDriverFound: true,
              bookingOrderModel: BookingOrderModel(
                data: BookingData(
                  id: driverAcceptBookingModel.data?.id,
                  userId: driverAcceptBookingModel.data?.userId,
                ),
              ),
              distance: 2.2,
              driverAcceptBookingModel: driverAcceptBookingModel,
              isBookingNow: true,
              listLocationRequest: listLocaleRequest,
              price: 10.5,
              timeEst: 2.6,
              isLandingPageNavTo: true,
            ),
          );
          break;
        case '3':
          break;
        case '4':
          navigateScreen(
            routePath: ConversationPage.routeName,
            arg: ConversationArg(
              driverId: driverAcceptBookingModel.data?.driverId ?? demoDriverId,
              driverName: driverAcceptBookingModel.data?.driverInfo?.name ??
                  demoDriverName,
            ),
          );
          break;
        case '5':
          navigateScreen(
            routePath: ConversationPage.routeName,
            arg: ConversationArg(
              driverId: driverAcceptBookingModel.data?.driverId ?? demoDriverId,
              driverName: driverAcceptBookingModel.data?.driverInfo?.name ??
                  demoDriverName,
            ),
          );
          break;
        case '6':
          navigateScreen(
            routePath: TrackingPage.routeName,
            arg: TrackingArgs(
              isDriverFound: true,
              bookingOrderModel: BookingOrderModel(
                data: BookingData(
                  id: driverAcceptBookingModel.data?.id,
                  userId: driverAcceptBookingModel.data?.userId,
                ),
              ),
              distance: 2.2,
              driverAcceptBookingModel: driverAcceptBookingModel,
              isBookingNow: true,
              listLocationRequest: listLocaleRequest,
              price: 10.5,
              timeEst: 2.6,
              isLandingPageNavTo: true,
            ),
          );
          break;

        case '9':
          navigateScreen(
            routePath: TrackingPage.routeName,
            arg: TrackingArgs(
              isDriverFound: true,
              bookingOrderModel: BookingOrderModel(
                data: BookingData(
                  id: driverAcceptBookingModel.data?.id,
                  userId: driverAcceptBookingModel.data?.userId,
                ),
              ),
              distance: 2.2,
              driverAcceptBookingModel: driverAcceptBookingModel,
              isBookingNow: true,
              listLocationRequest: listLocaleRequest,
              price: 10.5,
              timeEst: 2.6,
              isLandingPageNavTo: true,
            ),
          );

          break;
        case '10':
          navigateScreen(routePath: MockNotificationSupperAppPage.routeName);

          break;
        case '11':
          navigateScreen(routePath: MockNotificationSupperAppPage.routeName);

          break;

        case '12':
          navigateScreen(
            routePath: TrackingPage.routeName,
            arg: TrackingArgs(
              isDriverFound: true,
              bookingOrderModel: BookingOrderModel(
                data: BookingData(
                  id: driverAcceptBookingModel.data?.id,
                  userId: driverAcceptBookingModel.data?.userId,
                ),
              ),
              distance: 2.2,
              driverAcceptBookingModel: driverAcceptBookingModel,
              isBookingNow: true,
              listLocationRequest: listLocaleRequest,
              price: 10.5,
              timeEst: 2.6,
              isLandingPageNavTo: true,
            ),
          );
          break;
        case '13':
          navigateScreen(
            routePath: TrackingPage.routeName,
            arg: TrackingArgs(
              isDriverFound: true,
              bookingOrderModel: BookingOrderModel(
                data: BookingData(
                  id: driverAcceptBookingModel.data?.id,
                  userId: driverAcceptBookingModel.data?.userId,
                ),
              ),
              distance: 2.2,
              driverAcceptBookingModel: driverAcceptBookingModel,
              isBookingNow: true,
              listLocationRequest: listLocaleRequest,
              price: 10.5,
              timeEst: 2.6,
              isLandingPageNavTo: true,
            ),
          );
          break;
        default:
      }
    });
  }

  Future<DriverAcceptBookingModel> getDriverAcceptBookingInfo({
    required String id,
  }) async {
    final DataState<DriverAcceptBookingModel> model =
        await getIt<BookingAvailabilityRepo>().getBookingAvailabilityInfo(
      id,
    );
    if (model.isSuccess()) {
      return model.data ?? DriverAcceptBookingModel();
    } else {
      return DriverAcceptBookingModel();
    }
  }

  void navigateScreen({required String routePath, dynamic arg}) {
    log(
      '''routePath:${ModalRoute.of(navigatorKey.currentState!.context)?.settings.name == routePath}''',
    );
    Navigator.pushNamed(
      navigatorKey.currentState!.context,
      routePath,
      arguments: arg,
    );
  }
}
