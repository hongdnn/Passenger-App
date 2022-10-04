import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:passenger/core/app_config/get_it/getit_config.dart';
import 'package:passenger/features/favorite_location/presentation/bloc/favorite_location_bloc.dart';
import 'package:passenger/features/favorite_location/presentation/bloc/favorite_location_event.dart';
import 'package:passenger/features/favorite_location/presentation/bloc/favorite_location_state.dart';
import 'package:passenger/features/favorite_location/presentation/utils/favorite_location_const.dart';
import 'package:passenger/features/favorite_location/data/model/favorite_location.dart';
import 'package:passenger/features/location/data/model/location_address_model.dart';
import 'package:passenger/features/location/search_page.dart';
import 'package:passenger/features/trip_detail/presentation/bloc/util/extension.dart';
import 'package:passenger/util/android_google_maps_back_mixin.dart';
import 'package:passenger/util/assets.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/enum.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/styles.dart';
import 'package:passenger/util/widgets/basic_list_tile.dart';
import 'package:passenger/util/widgets/custom_button.dart';
import 'package:passenger/util/widgets/custom_dialog.dart';
import 'package:passenger/util/widgets/custom_input_widget.dart';
import 'package:passenger/util/widgets/search_appbar_widget.dart';
import 'package:passenger/util/widgets/time_picker_widget.dart';

class FavoriteLocationPickerArg {
  FavoriteLocationPickerArg({
    this.favoriteLocation,
    this.modifyFavoriteLocation,
    this.locationPickParent = LocationPickParent.landing,
  });

  final FavoriteLocation? favoriteLocation;
  final Function(FavoriteLocation favoriteLocation)? modifyFavoriteLocation;
  final LocationPickParent locationPickParent;
}

class FavoriteLocationPickerPage extends StatefulWidget {
  const FavoriteLocationPickerPage({
    Key? key,
    required this.args,
  }) : super(key: key);

  final FavoriteLocationPickerArg args;

  static const String routeName = '/favoriteLocationPicker';

  @override
  State<FavoriteLocationPickerPage> createState() =>
      _FavoriteLocationPickerPageState();
}

class _FavoriteLocationPickerPageState extends State<FavoriteLocationPickerPage>
    with AndroidGoogleMapsBackMixin<FavoriteLocationPickerPage> {
  final ValueNotifier<FavoriteLocationPageStep> step =
      ValueNotifier<FavoriteLocationPageStep>(
    FavoriteLocationPageStep.pickLocationOnMap,
  );

  final ValueNotifier<bool> isCameraMovable = ValueNotifier<bool>(true);
  final ValueNotifier<bool> isConfirmBtnEnabled = ValueNotifier<bool>(true);

  final TextEditingController titleEdtTxtCtrl = TextEditingController();
  final TextEditingController descEdtTxtCtrl = TextEditingController();

  LatLng? positionCenter;
  late GoogleMapController mapController;

  final FavoriteLocationBloc _bloc = getIt();

  bool _hasUserInteractedWithMap = false;
  late FavoriteLocation? favoriteLocation;

  @override
  void initState() {
    initArgs();
    super.initState();
  }

  void initArgs() {
    favoriteLocation = widget.args.favoriteLocation;
    if (favoriteLocation != null) {
      titleEdtTxtCtrl.text = favoriteLocation?.title ?? '';
      descEdtTxtCtrl.text = favoriteLocation?.note ?? '';
      step.value = FavoriteLocationPageStep.editName;
      isCameraMovable.value = false;
    }
  }

  @override
  void dispose() {
    mapController.dispose();
    titleEdtTxtCtrl.dispose();
    descEdtTxtCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<FavoriteLocationPageStep>(
      valueListenable: step,
      builder: (
        BuildContext _,
        FavoriteLocationPageStep pageStep,
        Widget? __,
      ) {
        return Scaffold(
          appBar: _buildAppBar(context: context, pageStep: pageStep),
          body: BlocProvider<FavoriteLocationBloc>(
            create: (BuildContext context) => _bloc
              ..add(
                InitializeEvent(favoriteLocation: favoriteLocation),
              ),
            child: BlocListener<FavoriteLocationBloc, FavoriteLocationState>(
              listenWhen: (
                FavoriteLocationState previous,
                FavoriteLocationState current,
              ) {
                final bool isPickedPlaceError =
                    previous.pickedPlaceState != current.pickedPlaceState &&
                        current.pickedPlaceState == LoadState.failure;

                return isPickedPlaceError;
              },
              listener: (BuildContext context, FavoriteLocationState state) {
                if (state.pickedPlaceState == LoadState.failure) {
                  showCommonErrorDialog(
                    context: context,
                    message: S(context).error_common_msg,
                    negativeTitle: S(context).confirm,
                  );
                  return;
                }
              },
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
                  _buildBottomInformation(pageStep: pageStep)
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  AppBar _buildAppBar({
    required BuildContext context,
    required FavoriteLocationPageStep pageStep,
  }) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          if (pageStep == FavoriteLocationPageStep.editName) {
            _toPickLocationStep();
          } else {
            popBack(context);
          }
        },
        icon: SvgPicture.asset(SvgAssets.icBackIos),
      ),
      titleSpacing: 0,
      centerTitle: pageStep == FavoriteLocationPageStep.editName ? true : false,
      title: pageStep == FavoriteLocationPageStep.pickLocationOnMap
          ? Padding(
              padding: EdgeInsets.only(right: 18.w),
              child: SearchAppbarWidget(
                onTap: () async {
                  final dynamic value = await Navigator.pushNamed(
                    context,
                    SearchPage.routeName,
                    arguments: SearchPageArgs(
                      optionSearchResult: OptionSearchResult.favorite,
                    ),
                  );
                  favoriteLocation = value as FavoriteLocation;
                  _bloc.add(
                    InitializeEvent(favoriteLocation: favoriteLocation),
                  );
                },
              ),
            )
          : Text(
              S(context).add_a_place,
              style: StylesConstant.ts20w500
                  .copyWith(color: ColorsConstant.cFF454754),
            ),
    );
  }

  Widget _buildMap() {
    return BlocBuilder<FavoriteLocationBloc, FavoriteLocationState>(
      buildWhen:
          (FavoriteLocationState previous, FavoriteLocationState current) {
        return previous.initialPosition != current.initialPosition;
      },
      builder: (BuildContext context, FavoriteLocationState state) {
        return ValueListenableBuilder<bool>(
          valueListenable: isCameraMovable,
          builder: (
            BuildContext _,
            bool canMoveCamera,
            Widget? __,
          ) {
            return GoogleMap(
              // Force to have key so that when initial position change
              // Map initialCameraPosition is called
              key: ObjectKey(state.initialPosition),
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: state.initialPosition ?? const LatLng(0, 0),
                zoom: 14.0,
              ),
              scrollGesturesEnabled: canMoveCamera,
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
                if (canMoveCamera &&
                    positionCenter != null &&
                    _hasUserInteractedWithMap) {
                  _bloc.add(
                    GetAddressFromLatLngEvent(
                      latLng: positionCenter!,
                    ),
                  );
                }
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

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
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

  Widget _buildButtonMyLocation() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 24.w, right: 24.w),
              child: GestureDetector(
                onTap: _animateToCurrentPosition,
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
      ),
    );
  }

  void _animateToCurrentPosition() {
    if (step.value == FavoriteLocationPageStep.editName) return;
    final LatLng? currentLatLng = _bloc.getCurrentPos;
    if (currentLatLng == null) return;
    mapController.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(
          currentLatLng.latitude,
          currentLatLng.longitude,
        ),
        14,
      ),
    );
  }

  Widget _buildBottomInformation({
    required FavoriteLocationPageStep pageStep,
  }) {
    return ValueListenableBuilder<bool>(
      valueListenable: isConfirmBtnEnabled,
      builder: (
        BuildContext _,
        bool enableButton,
        Widget? __,
      ) {
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
          child: Column(
            children: <Widget>[
              _pickLocationTile(pageStep: pageStep),
              SizedBox(
                height: 16.h,
              ),
              _buildInPutLocation(pageStep: pageStep),
              SizedBox(
                height: 16.h,
              ),
              CustomButton(
                params: enableButton
                    ? CustomButtonParams.primary(
                        hasGradient: enableButton,
                        onPressed: _onBottomInfoBtnPressed,
                        text: pageStep ==
                                FavoriteLocationPageStep.pickLocationOnMap
                            ? S(context).confirm
                            : S(context).save_address,
                      )
                    : CustomButtonParams.primaryUnselected(
                        text: pageStep ==
                                FavoriteLocationPageStep.pickLocationOnMap
                            ? S(context).confirm
                            : S(context).save_address,
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onBottomInfoBtnPressed() {
    if (step.value == FavoriteLocationPageStep.pickLocationOnMap) {
      _toEditNameStep();
    } else {
      if (isConfirmBtnEnabled.value) {
        final FavoriteLocation? oldFavoriteLocation = favoriteLocation;
        final LocationAddressModel locationAddress =
            LocationAddressModel.from(_bloc.getPickedPlace);

        FavoriteLocation favorite = FavoriteLocation(
          userId: _bloc.getCurrentUser().id,
          id: oldFavoriteLocation?.id,
          title: titleEdtTxtCtrl.text.trimValue(),
          note: descEdtTxtCtrl.text.trimValue(),
          addressName: locationAddress.nameAddress,
          address: locationAddress.formatAddress,
          longitude: locationAddress.longitude,
          latitude: locationAddress.latitude,
          referenceId: locationAddress.reference,
          googleId: locationAddress.placeId,
        );
        if (widget.args.locationPickParent == LocationPickParent.landing) {
          Navigator.of(context).pop();
        } else {
          popBackUntil(context, (Route<dynamic> route) {
            return route.settings.name == SearchPage.routeName;
          });
        }

        widget.args.modifyFavoriteLocation?.call(favorite);
      }
    }
  }

  Widget _pickLocationTile({required FavoriteLocationPageStep pageStep}) {
    return BlocBuilder<FavoriteLocationBloc, FavoriteLocationState>(
      builder: (BuildContext context, FavoriteLocationState state) {
        if (state.pickedPlaceState == LoadState.loading) {
          return SizedBox(
            height: 54.h,
            child: const CupertinoActivityIndicator(),
          );
        }

        if (state.pickedPlace != null) {
          return BasicListTile(
            iconTitle: pageStep == FavoriteLocationPageStep.editName
                ? IconButton(
                    onPressed: () {
                      _toPickLocationStep();
                    },
                    icon: SvgPicture.asset(SvgAssets.icEditLinear),
                  )
                : null,
            title: state.pickedPlace?.result?.name ?? '',
            subtitle: state.pickedPlace?.result?.formattedAddress ?? '',
            icon: pageStep == FavoriteLocationPageStep.editName
                ? SvgAssets.icLocation
                : null,
            onTap: () {
              popBack(context);
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildInPutLocation({required FavoriteLocationPageStep pageStep}) {
    if (pageStep == FavoriteLocationPageStep.pickLocationOnMap) {
      return const SizedBox.shrink();
    }
    return Column(
      children: <Widget>[
        CustomInputWidget(
          hintText: S(context).favorite_title_hint,
          controller: titleEdtTxtCtrl,
          onChange: (String value) {
            final bool shouldEnableBtn = value.trim().isNotEmpty;
            if (shouldEnableBtn != isConfirmBtnEnabled.value) {
              isConfirmBtnEnabled.value = shouldEnableBtn;
            }
          },
        ),
        SizedBox(
          height: 16.h,
        ),
        CustomInputWidget(
          hintText: S(context).favorite_desc_hint,
          controller: descEdtTxtCtrl,
        ),
      ],
    );
  }

  void _toEditNameStep() {
    step.value = FavoriteLocationPageStep.editName;
    isCameraMovable.value = false;
    isConfirmBtnEnabled.value = titleEdtTxtCtrl.text.isNotEmpty;
  }

  void _toPickLocationStep() {
    step.value = FavoriteLocationPageStep.pickLocationOnMap;
    isCameraMovable.value =
        (step.value == FavoriteLocationPageStep.pickLocationOnMap);
    if (!isConfirmBtnEnabled.value) {
      isConfirmBtnEnabled.value = true;
    }
  }
}
