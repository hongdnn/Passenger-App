import 'package:flutter/material.dart';
import 'package:passenger/features/booking_page/data/model/invoice_model.dart';
import 'package:passenger/features/trip_detail/presentation/widget/divider_widget.dart';
import 'package:passenger/features/trip_detail/presentation/widget/title_and_value_widget.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/enum.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/string_constant.dart';
import 'package:passenger/util/styles.dart';
import 'package:passenger/core/util/localization.dart';

class DirectionInfoWidget extends StatelessWidget {
  const DirectionInfoWidget({
    Key? key,
    required this.invoice,
  }) : super(key: key);
  final InvoiceData invoice;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        invoice.invoiceStatus == InvoiceStatus.completed.value
            ? _buildDriverToPickUpPoint(invoice, context)
            : const SizedBox(),
        const DividerWidget(),
        invoice.invoiceStatus == InvoiceStatus.completed.value
            ? _buildPickUpPointToDestination(invoice, context)
            : const SizedBox.shrink(),
      ],
    );
  }

  Widget _buildPickUpPointToDestination(
    InvoiceData invoice,
    BuildContext context,
  ) {
    final String distance = invoice.booking?.trip?.distance?.toString() ??
        StringConstant.mockNullString;
    final String time = invoice.booking?.trip?.totalTime?.toString() ??
        StringConstant.mockNullString;
    return Container(
      color: ColorsConstant.cWhite,
      padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 24.w),
      child: _buildTimeAndDistance(
        distance: distance,
        time: time,
        title: S(context).pickup_point_to_destination,
        context: context,
      ),
    );
  }

  Widget _buildDriverToPickUpPoint(
    InvoiceData invoice,
    BuildContext context,
  ) {
    final String distance =
        invoice.booking?.driverToPickupDistance?.toString() ??
            StringConstant.mockNullString;
    final String time = invoice.booking?.driverToPickupTakeTime?.toString() ??
        StringConstant.mockNullString;

    return Container(
      color: ColorsConstant.cWhite,
      padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 24.w),
      child: _buildTimeAndDistance(
        distance: distance,
        time: time,
        title: S(context).driver_to_pickup_point,
        context: context,
      ),
    );
  }

  Column _buildTimeAndDistance({
    required String distance,
    required String time,
    required String title,
    required BuildContext context,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: StylesConstant.ts16w400,
        ),
        SizedBox(height: 16.h),
        TitleAndValueWidget(
          title: S(context).distance,
          value: '$distance ${S(context).km}.',
        ),
        SizedBox(height: 8.h),
        TitleAndValueWidget(
          title: S(context).travel_time,
          value: '$time ${S(context).minute}',
        ),
      ],
    );
  }
}
