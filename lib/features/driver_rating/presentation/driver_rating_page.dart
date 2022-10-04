import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:passenger/core/app_config/constant.dart';
import 'package:passenger/core/app_config/get_it/getit_config.dart';
import 'package:passenger/core/util/localization.dart';
import 'package:passenger/features/booking_page/presentation/bloc/booking_page_bloc.dart';
import 'package:passenger/features/driver_rating/data/model/request/rate_driver_request.dart';
import 'package:passenger/features/driver_rating/presentation/bloc/driver_rating_bloc.dart';
import 'package:passenger/features/driver_rating/presentation/util/driver_rating_diff_ext.dart';
import 'package:passenger/features/driver_rating/presentation/widget/reason_picker.dart';
import 'package:passenger/features/driver_rating/presentation/widget/star_rating_widget.dart';
import 'package:passenger/features/driver_rating/presentation/widget/tip_picker_widget.dart';
import 'package:passenger/features/landing_page/presentation/bloc/landing_page_bloc.dart';
import 'package:passenger/features/tip_payment/presentation/tip_payment_page.dart';
import 'package:passenger/features/tracking_page/presentation/bloc/tracking_page_bloc.dart';
import 'package:passenger/features/trip_detail/trip_detail_page.dart';
import 'package:passenger/main.dart';
import 'package:passenger/util/assets.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/enum.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/string_constant.dart';
import 'package:passenger/util/styles.dart';
import 'package:passenger/util/widgets/custom_button.dart';
import 'package:passenger/util/widgets/custom_dialog.dart';
import 'package:passenger/util/widgets/custom_input_widget.dart';
import 'package:passenger/util/widgets/screen_collapse_appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DriverRatingPageArgs {
  DriverRatingPageArgs({required this.bookingId, this.isPopBack = false});

  final String bookingId;
  final bool isPopBack;
}

class DriverRatingPage extends StatefulWidget {
  const DriverRatingPage({
    Key? key,
    required this.args,
  }) : super(key: key);
  static const String routeName = '/driverRating';

  final DriverRatingPageArgs args;

  @override
  State<DriverRatingPage> createState() => _DriverRatingPageState();
}

class _DriverRatingPageState extends State<DriverRatingPage> {
  final DriverRatingBloc _bloc = getIt();

  void clearAllData() {
    BlocProvider.of<LandingPageBloc>(context).add(ClearDataLandingEvent());
    BlocProvider.of<LandingPageBloc>(context).add(InitializeLandingEvent());
    BlocProvider.of<BookingPageBloc>(context).add(ClearStateEvent());
    BlocProvider.of<TrackingPageBloc>(context).add(ClearDataEvent());
  }

  void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        hideKeyboard();
      },
      child: Scaffold(
        backgroundColor: ColorsConstant.cWhite,
        body: BlocProvider<DriverRatingBloc>(
          create: (BuildContext context) =>
              _bloc..add(InitializeRating(bookingId: widget.args.bookingId)),
          child: BlocConsumer<DriverRatingBloc, DriverRatingState>(
            buildWhen: shouldRebuildMainContent,
            listener: (BuildContext context, DriverRatingState state) {
              if (state.initialLoadState == LoadState.failure) {
                showCommonErrorDialog(
                  context: context,
                  message: S(context).error_common_msg,
                  negativeTitle: S(context).confirm,
                );
                return;
              }
            },
            builder: (BuildContext context, DriverRatingState state) {
              if (state.initialLoadState == LoadState.success) {
                return _buildMainContent();
              } else {
                return _buildLoading();
              }
            },
          ),
        ),
      ),
    );
  }

  ScreenCollapseAppbar _buildLoading() {
    return ScreenCollapseAppbar(
      isTapOnIconBack: true,
      flexibleBackground: Container(
        height: 360.h,
        decoration: BoxDecoration(
          gradient: ColorsConstant.appPrimaryGradient,
        ),
        child: Column(
          children: <Widget>[
            _buildAppBar(),
            const Expanded(
              child: Center(
                child: CupertinoActivityIndicator(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      height: 360.h,
      leadingIcon: SvgPicture.asset(SvgAssets.icClose),
      isLeadingIconBackgroundColor: true,
      isSliverAppBarScrolled: true,
      flexibleTitle: S(context).rating_page_title,
      content: Padding(
        padding: EdgeInsets.only(top: 128.h),
        child: const CupertinoActivityIndicator(),
      ),
    );
  }

  ScreenCollapseAppbar _buildMainContent() {
    return ScreenCollapseAppbar(
      hasTrailingIcon: true,
      flexibleBackground: _buildHeader(),
      height: 360.h,
      leadingIcon: SvgPicture.asset(SvgAssets.icClose),
      isTapOnIconBack: true,
      isLeadingIconBackgroundColor: true,
      isSliverAppBarScrolled: true,
      flexibleTitle: S(context).rating_page_title,
      onTapIconBack: () {
        if (widget.args.isPopBack == false) {
          getIt<SharedPreferences>().setBool('isBookingNow', true);
          clearAllData();
          Navigator.of(context).popUntil(
            (Route<dynamic> route) =>
                route.settings.name == MyHomePage.routeName,
          );
        }
      },
      content: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildReasonPicker(),
            _buildTipPicker(),
            const SizedBox(height: 8),
            _buildSectionTitle(S(context).rating_section_title_comment),
            _buildCommentSection(),
            _buildConfirmButton(),
          ],
        ),
      ),
    );
  }

  Container _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        gradient: ColorsConstant.appPrimaryGradient,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildAppBar(),
          const SizedBox(height: 16),
          _buildDriverInfo(),
          _buildStarRating(),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _buildDriverInfo() {
    return BlocBuilder<DriverRatingBloc, DriverRatingState>(
      buildWhen: (DriverRatingState previous, DriverRatingState current) =>
          shouldRebuildDriverInfo(previous, current),
      builder: (BuildContext context, DriverRatingState state) {
        return Column(
          children: <Widget>[
            ClipOval(
              child: state.ratingOptions?.driverInfo?.avatar?.isNotEmpty == true
                  ? CachedNetworkImage(
                      imageUrl: state.ratingOptions!.driverInfo!.avatar!,
                      width: 80.w,
                      height: 80.w,
                      fit: BoxFit.cover,
                      errorWidget: (BuildContext context, String url, _) =>
                          Image.asset(
                        PngAssets.mockThumbnail,
                        height: 80.w,
                        width: 80.w,
                      ),
                      placeholder: (BuildContext context, String url) =>
                          const CircularProgressIndicator(),
                    )
                  : SizedBox(
                      width: 80.w,
                      height: 80.w,
                    ),
            ),
            SizedBox(height: 16.h),
            Text(
              state.ratingOptions?.driverInfo?.name ??
                  StringConstant.mockNullString,
              style: StylesConstant.ts20w400.copyWith(
                color: ColorsConstant.cWhite,
              ),
            ),
            const SizedBox(height: 8),
          ],
        );
      },
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      title: Center(
        child: Text(
          S(context).rating_page_title,
          style: StylesConstant.ts20w500.copyWith(
            color: ColorsConstant.cWhite,
          ),
        ),
      ),
    );
  }

  StarRating _buildStarRating() {
    return StarRating(
      onStarsSelected: (int stars) {
        hideKeyboard();
        _bloc.add(SelectStarEvent(stars));
      },
    );
  }

  Padding _buildDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: const Divider(color: ColorsConstant.cFFE3E4E8),
    );
  }

  Padding _buildSectionTitle(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Text(
        text,
        style: StylesConstant.ts16w500,
      ),
    );
  }

  Widget _buildReasonPicker() {
    return BlocBuilder<DriverRatingBloc, DriverRatingState>(
      buildWhen: shouldRebuildReasonPicker,
      builder: (BuildContext context, DriverRatingState state) {
        final List<String> displayedReasons = state.displayedReason;
        if (state.rating <= 0 || displayedReasons.isEmpty) {
          return const SizedBox.shrink();
        }
        return Column(
          children: <Widget>[
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: _buildSectionTitle(S(context).rating_section_title_reason),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
              child: ReasonPicker(
                selectedReasons: state.selectedReasons,
                reasonList: displayedReasons,
                onSelected: (String reason) {
                  hideKeyboard();
                  _bloc.add(SelectReasonEvent(reason));
                },
              ),
            ),
            _buildDivider()
          ],
        );
      },
    );
  }

  Widget _buildTipPicker() {
    return BlocBuilder<DriverRatingBloc, DriverRatingState>(
      buildWhen: shouldRebuildTipPicker,
      builder: (BuildContext context, DriverRatingState state) {
        if (state.ratingOptions?.tipAmounts?.isEmpty ?? false) {
          return const SizedBox.shrink();
        }
        return Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: _buildSectionTitle(S(context).rating_section_title_tip),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: TipPicker(
                selectedTip: state.selectedTip,
                tipList: state.ratingOptions?.tipAmounts ?? <num>[],
                onTipSelected: (num tip) {
                  hideKeyboard();
                  _bloc.add(SelectTipEvent(tip));
                },
              ),
            ),
            _buildDivider()
          ],
        );
      },
    );
  }

  Padding _buildCommentSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: CustomInputWidget(
        minLines: 3,
        maxLines: 3,
        hintText: S(context).rating_comment_hint,
        onChange: (String? text) => _bloc.add(CommentEvent(text)),
      ),
    );
  }

  Widget _buildConfirmButton() {
    return BlocConsumer<DriverRatingBloc, DriverRatingState>(
      listenWhen: (DriverRatingState previous, DriverRatingState current) {
        return previous.confirmLoadState != current.confirmLoadState;
      },
      listener: (BuildContext context, DriverRatingState state) {
        if (state.confirmLoadState == LoadState.success) {
          if (state.selectedTip == defaultSelectedTip) {
            if (widget.args.isPopBack == true) {
              log('abc:TripDetailPage');

              clearAllData();
              Navigator.of(context).popUntil((Route<dynamic> route) {
                if (route.settings.name == TripDetailPage.routeName) {
                  (route.settings.arguments as TripDetailPageOutputArgs)
                      .reload = true;
                  return true;
                } else {
                  return false;
                }
              });
            } else {
              log('abc:MyHomePage');

              getIt<SharedPreferences>().setBool('isBookingNow', true);
              clearAllData();
              Navigator.of(context).popUntil(
                (Route<dynamic> route) =>
                    route.settings.name == MyHomePage.routeName,
              );
              return;
            }
          } else {
            log('abc:TipPaymentPage');

            Navigator.pushNamed(
              context,
              TipPaymentPage.routeName,
              arguments: TipPaymentPageArgs(
                rateDriverRequest: RateDriverRequest(
                  bookingId: widget.args.bookingId,
                ),
                isPopBack: widget.args.isPopBack,
              ),
            );
          }
        }
        if (state.confirmLoadState == LoadState.failure) {
          showCommonErrorDialog(
            context: context,
            message: S(context).error_common_msg,
            negativeTitle: S(context).confirm,
          );
          return;
        }
      },
      builder: (BuildContext context, DriverRatingState state) {
        return CustomButton(
          params: CustomButtonParams.primary(
            text: S(context).confirm,
            onPressed: () {
              _onRateTrip(state);
            },
          ).copyWith(
            margin: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
          ),
        );
      },
    );
  }

  _onRateTrip(DriverRatingState state) {
    _bloc.add(
      ConfirmRatingEvent(
        ratingRequest: RateDriverRequest(
          bookingId: widget.args.bookingId,
          rating: state.rating != 0 ? state.rating : maxRatingStar,
          ratingReasons: state.selectedReasons ?? <String>[],
          tipAmount:
              state.selectedTip == defaultSelectedTip ? 0 : state.selectedTip,
          additionalComments: state.comment,
        ),
      ),
    );
  }
}
