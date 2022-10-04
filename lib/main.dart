import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:passenger/core/app_config/app_router.dart';
import 'package:passenger/core/app_config/app_theme.dart';
import 'package:passenger/core/app_config/permission/permission_config.dart';
import 'package:passenger/core/util/localization.dart';
import 'package:passenger/core/app_config/get_it/getit_config.dart';
import 'package:passenger/core/app_config/notification/config_notification.dart';
import 'package:passenger/core/util/route_observer.dart';
import 'package:passenger/features/landing_page/presentation/bloc/landing_page_bloc.dart';
import 'package:passenger/features/landing_page/presentation/landing_page.dart';
import 'package:passenger/features/map_page/presentation/map_page/bloc/map_page_bloc.dart';
import 'package:passenger/features/user/data/repo/user_repo.dart';
import 'package:passenger/util/assets.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/styles.dart';
import 'package:uni_links/uni_links.dart';
import 'core/app_config/get_it/getit_config.dart' as get_it;
import 'util/widgets/dropdown_alert/dropdown_alert.dart';
import 'package:passenger/util/widgets/custom_dialog.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

bool _initialUriIsHandled = false;
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await get_it.init();

  getIt<ConfigNotification>().initialize();
  getIt<ConfigNotification>()
      .flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: <SystemUiOverlay>[SystemUiOverlay.bottom, SystemUiOverlay.top],
  );
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await getIt<UserRepo>().saveUser();
  // Require Hybrid Composition mode on Android.
  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    mapsImplementation.useAndroidViewSurface = true;
  }
  // runApp(
  //   const MyApp(
  //     key: ValueKey<String>('my-app'),
  //   ),
  // );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: const ValueKey<String>('material-app'),
      navigatorObservers: <NavigatorObserver>[appRouteObserver],
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      locale: const Locale('th'),
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateRoute: AppRouter().generateRoute,
      navigatorKey: navigatorKey,
      builder: (BuildContext context, Widget? child) => Stack(
        children: <Widget>[
          child!,
          DropdownAlert(
            titleStyle:
                StylesConstant.ts16w400.copyWith(color: ColorsConstant.cWhite),
            successBackground: ColorsConstant.cFF6FCF97,
            errorBackground: ColorsConstant.cFFEB6666,
            successImage: SvgAssets.icSuccess,
            errorImage: SvgAssets.icInformation,
          )
        ],
      ),
      initialRoute: MyHomePage.routeName,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  static const String routeName = '/';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  final ValueNotifier<bool> showFillColor = ValueNotifier<bool>(false);
  final ValueNotifier<bool> showAskPermission = ValueNotifier<bool>(false);
  late AnimationController _controller;
  late int currentTabIndex;

  // ignore: unused_field
  late Object? _err;
  late StreamSubscription<Uri?> _sub;
  BuildContext? contextDialog;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    currentTabIndex = 0;
    _handleIncomingLinks();
    _handleInitialUri();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<LandingPageBloc>(context).add(InitializeLandingEvent());
      PermissionConfig().askPermissionRequire(
        listenPermission: <PermissionModel>[
          PermissionModel(
            title: S(context).location,
            permission: Permission.location,
            function: () {
              showCustomDialogPermission(
                context: context,
                permission: S(context).location,
                functionContext: (BuildContext ctx) {
                  contextDialog = ctx;
                },
              );
            },
          ),
        ],
      );
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      if (contextDialog != null) {
        Navigator.pop(contextDialog!);
      }
      BlocProvider.of<MapPageBloc>(context)
        ..add(GetLocationCurrentEvent())
        ..add(GetListCarEvent());
    } else {
      return;
    }
  }

  void _handleIncomingLinks() {
    // It will handle app links while the app is already started - be it in
    // the foreground or in the background.
    _sub = uriLinkStream.listen(
      (Uri? uri) {
        if (!mounted) return;
        if (kDebugMode) {
          print('got uri: $uri');
          print(
            'got initial uri 123: ${uri?.scheme} ${uri?.path}${uri?.fragment}',
          );
        }
        if (uri?.path != null) {
          String routeName = uri!.path.replaceAll('/', '');
          Navigator.pushNamed(context, '/$routeName');
        }
        setState(() {
          _err = null;
        });
      },
      onError: (Object err) {
        if (!mounted) return;
        if (kDebugMode) {
          print('got err: $err');
        }
        setState(() {
          if (err is FormatException) {
            _err = err;
          } else {
            _err = null;
          }
        });
      },
    );
  }

  Future<void> _handleInitialUri() async {
    // In this example app this is an almost useless guard, but it is here to
    // show we are not going to call getInitialUri multiple times, even if this
    // was a weidget that will be disposed of (ex. a navigation route change).
    if (!_initialUriIsHandled) {
      _initialUriIsHandled = true;
      try {
        final Uri? uri = await getInitialUri();
        if (uri == null) {
        } else {
          if (kDebugMode) {
            print('got initial uri: $uri');
          }
        }
        if (!mounted) return;
      } on PlatformException {
        // Platform messages may fail but we ignore the exception
        if (kDebugMode) {
          print('falied to get initial uri');
        }
      } on FormatException catch (err) {
        if (!mounted) return;
        if (kDebugMode) {
          print('malformed initial uri');
        }
        setState(() => _err = err);
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    _controller.dispose();
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const LandingPage(
      key: ValueKey<String>('landing-page'),
    );
  }
}
