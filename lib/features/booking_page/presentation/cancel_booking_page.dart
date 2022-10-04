import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passenger/core/app_config/get_it/getit_config.dart';
import 'package:passenger/core/util/localization.dart';
import 'package:passenger/features/booking_page/data/model/cancel_booking_model.dart';
import 'package:passenger/features/booking_page/presentation/bloc/booking_page_bloc.dart';
import 'package:passenger/features/booking_page/presentation/bloc_cancel/cancel_booking_bloc.dart';
import 'package:passenger/features/booking_page/presentation/widget/reason_item.dart';
import 'package:passenger/features/tracking_page/presentation/bloc/tracking_page_bloc.dart';
import 'package:passenger/main.dart';
import 'package:passenger/util/assets.dart';
import 'package:passenger/util/enum.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/styles.dart';
import 'package:passenger/util/widgets/custom_button.dart';
import 'package:passenger/util/widgets/custom_dialog.dart';

class Reason {
  Reason({required this.id, required this.name});

  final int id;
  final String name;
}

class CancelBooking extends StatefulWidget {
  const CancelBooking({Key? key, required this.cancelBookingArg})
      : super(key: key);
  static const String routeName = '/cancelBookingPage';
  final CancelBookingBody cancelBookingArg;
  @override
  State<CancelBooking> createState() => _CancelBookingState();
}

class _CancelBookingState extends State<CancelBooking> {
  List<Reason> mockReasons = <Reason>[
    Reason(id: 1, name: 'ระบุสถานที่ผิด'),
    Reason(id: 2, name: 'เปลี่ยนแผนเดินทาง'),
    Reason(id: 3, name: 'คนขับอยู่ไกล'),
    Reason(id: 4, name: 'เปลี่ยนการชำระเงิน'),
    Reason(id: 5, name: 'ติดต่อคนขับไม่ได้'),
    Reason(id: 6, name: 'เปลี่ยนคนขับ'),
  ];

  ValueNotifier<String> valueReason = ValueNotifier<String>('');
  late CancelBookingBody cancelBookingBody;
  late CancelBookingBloc blocCancelBooking;

  @override
  void initState() {
    super.initState();
    cancelBookingBody = widget.cancelBookingArg;
    blocCancelBooking = getIt();
  }

  @override
  void deactivate() {
    super.deactivate();
    BlocProvider.of<BookingPageBloc>(context).add(ClearStateEvent());
    BlocProvider.of<TrackingPageBloc>(context).add(ClearDataEvent());
  }

  void _onTapReason(int id) {
    blocCancelBooking.add(SelectReasonEvent(id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S(context).cancel_booking_title,
        ),
      ),
      backgroundColor: Colors.white,
      body: BlocProvider<CancelBookingBloc>(
        create: (BuildContext context) => blocCancelBooking,
        child: BlocListener<CancelBookingBloc, CancelBookingState>(
          listener: (BuildContext context, CancelBookingState state) {
            if (state.state == LoadState.loading) {
              showCustomDialogLoading(
                context: context,
              );
            }
            if (state.state == LoadState.success) {
              Navigator.popUntil(
                context,
                (Route<dynamic> route) =>
                    route.settings.name == MyHomePage.routeName,
              );
            }
            if (state.state == LoadState.failure) {
              Navigator.pop(context);
              showCommonErrorDialog(
                context: context,
                message: S(context).error_common_msg,
                negativeTitle: S(context).confirm,
              );
            }
          },
          child: ValueListenableBuilder<String>(
            valueListenable: valueReason,
            builder: (
              BuildContext context,
              String isReason,
              Widget? child,
            ) =>
                Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      PngAssets.imgBackgroundCancelBooking,
                      width: 215.w,
                      height: 210.h,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.h),
                    child: Text(
                      S(context).reason_cancel_booking,
                      textAlign: TextAlign.start,
                      style: StylesConstant.ts16w500,
                    ),
                  ),
                  Wrap(
                    spacing: 16.w,
                    runSpacing: 16.h,
                    children:
                        List<Widget>.generate(mockReasons.length, (int index) {
                      return BlocBuilder<CancelBookingBloc, CancelBookingState>(
                        builder:
                            (BuildContext context, CancelBookingState state) {
                          return ReasonItem(
                            onTap: () {
                              valueReason.value = mockReasons[index].name;
                              _onTapReason(mockReasons[index].id);
                            },
                            isSelected: state.idReason == mockReasons[index].id,
                            name: mockReasons[index].name,
                          );
                        },
                      );
                    }),
                  ),
                  const Expanded(child: SizedBox()),
                  CustomButton(
                    params: CustomButtonParams.primary(
                      text: S(context).confirm,
                      onPressed: () {
                        blocCancelBooking.add(
                          ConfirmCancelBookingEvent(
                            cancelBookingBody: CancelBookingBody(
                              id: cancelBookingBody.id,
                              cancelReason: isReason,
                              userId: cancelBookingBody.userId,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
