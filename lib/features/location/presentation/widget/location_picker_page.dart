import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:passenger/core/app_config/get_it/getit_config.dart';
import 'package:passenger/core/util/localization.dart';
import 'package:passenger/features/booking_page/presentation/booking_page.dart';
import 'package:passenger/features/landing_page/data/common_model/common_model.dart';
import 'package:passenger/util/widgets/basic_list_tile.dart';
import 'package:passenger/features/location/data/model/location_address_model.dart';
import 'package:passenger/features/location/presentation/bloc/search_bloc.dart';
import 'package:passenger/util/android_google_maps_back_mixin.dart';
import 'package:passenger/util/assets.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/enum.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/widgets/custom_button.dart';
import 'package:passenger/util/widgets/custom_dialog.dart';
import 'package:passenger/util/widgets/search_appbar_widget.dart';

class LocationPickerArg {
  LocationPickerArg({
    this.bookingLocation,
    this.locationPickParent = LocationPickParent.landing,
  }) {
    assert(bookingLocation != null);
  }

  final LocationAddressModel? bookingLocation;
  final LocationPickParent locationPickParent;
}

class LocationPickerPage extends StatefulWidget {
  const LocationPickerPage({Key? key, required this.args}) : super(key: key);
  static const String routeName = '/locationPickerPage';
  final LocationPickerArg args;

  @override
  State<LocationPickerPage> createState() => _LocationPickerPageState();
}

class _LocationPickerPageState extends State<LocationPickerPage>
    with AndroidGoogleMapsBackMixin<LocationPickerPage> {
  late GoogleMapController controller;

  LatLng? positionCenter;
  final ValueNotifier<bool> isMoveCameraListen = ValueNotifier<bool>(false);

  late LocationAddressModel? bookingLocation;

  final SearchBloc _searchBloc = getIt();

  // When map open initial position
  bool _hasUserInteractedWithMap = false;

  @override
  void initState() {
    bookingLocation = widget.args.bookingLocation;
    _searchBloc
      ..add(GetCurrentLocationEvent())
      ..add(
        GetAddressFromLatLngEvent(
          longitude: bookingLocation?.longitude ?? 0,
          latitude: bookingLocation?.latitude ?? 0,
        ),
      );

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: BlocProvider<SearchBloc>(
        create: (BuildContext context) => _searchBloc,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                children: <Widget>[
                  _buildMap(),
                  _buildCenterLocation(),
                  _buildButtonMyLocation(),
                ],
              ),
            ),
            _buildBottomInformation()
          ],
        ),
      ),
    );
  }

  Center _buildCenterLocation() {
    return Center(
      child: SvgPicture.asset(
        SvgAssets.icLocationFill,
        width: 30.w,
        height: 42.h,
      ),
    );
  }

  Widget _buildBottomInformation() {
    return Container(
      padding: EdgeInsets.only(
        left: 24.w,
        right: 24.w,
        bottom: 24.w,
      ),
      decoration: BoxDecoration(
        color: ColorsConstant.cWhite,
        borderRadius: BorderRadius.circular(24.w),
      ),
      width: double.infinity,
      child: BlocConsumer<SearchBloc, SearchState>(
        listenWhen: (SearchState previous, SearchState current) {
          return (current.geoCodingLoadState == LoadState.success &&
                  current.geoCodingLoadState != previous.geoCodingLoadState) ||
              current.geoCodingLoadState == LoadState.failure;
        },
        listener: (BuildContext context, SearchState state) {
          if (state.geoCodingLoadState == LoadState.success) {
            bookingLocation = LocationAddressModel.from(
              state.placeToAddOrToGo,
            );
          } else if (state.geoCodingLoadState == LoadState.failure) {
            showCommonErrorDialog(
              context: context,
              message: S(context).error_common_msg,
              negativeTitle: S(context).confirm,
              onPressed: () {
                Navigator.of(context).pop();
              },
            );
          }
        },
        builder: (BuildContext context, SearchState state) {
          return Column(
            children: <Widget>[
              _pickLocationTile(
                state: state,
              ),
              SizedBox(
                height: 16.h,
              ),
              CustomButton(
                params: state.geoCodingLoadState == LoadState.success
                    ? CustomButtonParams.primary(
                        hasGradient: true,
                        onPressed: () {
                          _onWantToBook();
                        },
                        text: S(context).confirm,
                      )
                    : CustomButtonParams.primaryUnselected(
                        text: S(context).confirm,
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _pickLocationTile({
    required SearchState state,
  }) {
    if (state.geoCodingLoadState == LoadState.success) {
      return BasicListTile(
        iconTitle: null,
        title: state.placeToAddOrToGo?.result?.name ?? '',
        subtitle: state.placeToAddOrToGo?.result?.formattedAddress ?? '',
        icon: null,
        onTap: () {
          Navigator.pop(context);
        },
      );
    }
    return BasicListTile(
      iconTitle: null,
      title: '',
      subtitle: '',
      icon: null,
      onTap: () {},
    );
  }

  Widget _buildButtonMyLocation() {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (BuildContext context, SearchState state) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 24.w, right: 24.w),
                child: GestureDetector(
                  onTap: () {
                    controller.animateCamera(
                      CameraUpdate.newLatLngZoom(
                        LatLng(
                          state.placeDetailLocationCurrent?.getLatitude ?? 0,
                          state.placeDetailLocationCurrent?.getLongitude ?? 0,
                        ),
                        14,
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(5.w),
                    decoration: const BoxDecoration(
                      color: ColorsConstant.cWhite,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(PngAssets.icMyLocation),
                  ),
                ),
              ),
              Container(
                height: 24.w,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorsConstant.cWhite,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      24.w,
                    ),
                    topRight: Radius.circular(
                      24.w,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMap() {
    return ValueListenableBuilder<bool>(
      valueListenable: isMoveCameraListen,
      builder: (
        BuildContext _,
        bool valueMoveCamera,
        Widget? __,
      ) {
        return BlocBuilder<SearchBloc, SearchState>(
          builder: (BuildContext context, SearchState state) {
            return GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  bookingLocation?.latitude ?? 0,
                  bookingLocation?.longitude ?? 0,
                ),
                zoom: 14.0,
              ),
              scrollGesturesEnabled: true,
              onCameraMoveStarted: () {
                _hasUserInteractedWithMap = true;
              },
              onCameraMove: (CameraPosition cameraPosition) {
                positionCenter = LatLng(
                  cameraPosition.target.latitude,
                  cameraPosition.target.longitude,
                );
              },
              onCameraIdle: () {
                if (valueMoveCamera && _hasUserInteractedWithMap) {
                  _searchBloc.add(
                    GetAddressFromLatLngEvent(
                      latitude: positionCenter?.latitude ?? 0.0,
                      longitude: positionCenter?.longitude ?? 0.0,
                    ),
                  );
                }
                isMoveCameraListen.value = true;
              },
              myLocationButtonEnabled: false,
              myLocationEnabled: false,
              zoomControlsEnabled: false,
              mapType: MapType.normal,
            );
          },
        );
      },
    );
  }

  AppBar _buildAppBar(
    BuildContext context,
  ) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          popBack(context);
        },
        icon: SvgPicture.asset(SvgAssets.icBackIos),
      ),
      titleSpacing: 0,
      title: Padding(
        padding: EdgeInsets.only(right: 19.w),
        child: SearchAppbarWidget(
          onTap: () {
            popBack(context);
          },
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controllerParam) {
    setState(() {
      controller = controllerParam;
    });
  }

  void _onWantToBook() {
    if (widget.args.locationPickParent == LocationPickParent.landing) {
      Navigator.pushNamed(
        context,
        BookingPage.routeName,
        arguments: BookingArg(
          bookingLocationList: BookingLocationList(
            firstLocation: bookingLocation,
          ),
          reorderBookingData: BookingData(),
        ),
      );
    } else if (widget.args.locationPickParent == LocationPickParent.booking) {
      Navigator.of(context).popUntil((Route<dynamic> route) {
        if (route.settings.name == BookingPage.routeName) {
          (route.settings.arguments as BookingArg)
              .bookingLocationList
              ?.location = bookingLocation;
          return true;
        } else {
          return false;
        }
      });
    }
  }
}
