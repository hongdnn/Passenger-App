import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passenger/core/util/localization.dart';
import 'package:passenger/util/assets.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/styles.dart';

class PaymentMethodTripDetailWidget extends StatelessWidget {
  const PaymentMethodTripDetailWidget({
    Key? key,
    required this.moneyType,
    this.amount,
    this.iconPaymentType,
    this.cardLastDigits,
    this.isCard,
    this.paymentMethodName,
    this.paymentTypeName,
  }) : super(key: key);

  final String moneyType;
  final double? amount;
  final String? iconPaymentType;
  final String? paymentMethodName;
  final String? paymentTypeName;
  final bool? isCard;
  final String? cardLastDigits;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorsConstant.cWhite,
      padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 24.w),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                moneyType,
                style: StylesConstant.ts16w400,
              ),
              Text(
                '$amount',
                style: StylesConstant.ts16w500,
              )
            ],
          ),
          SizedBox(height: 8.w),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                S(context).payment_methods_trip_detail,
                style: StylesConstant.ts16w400,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    iconPaymentType != null
                        ? CachedNetworkImage(
                            imageUrl: iconPaymentType!,
                            errorWidget:
                                (BuildContext context, String url, _) =>
                                    Image.asset(
                              PngAssets.icScb,
                              width: 35.w,
                              fit: BoxFit.fitWidth,
                            ),
                            width: 35.w,
                            fit: BoxFit.fitWidth,
                          )
                        : Image.asset(
                            PngAssets.icScb,
                            width: 35.w,
                            fit: BoxFit.fitWidth,
                          ),
                    SizedBox(width: 8.w),
                    Flexible(
                      child: Text(
                        paymentMethodName ?? (paymentTypeName ?? ''),
                        style: StylesConstant.ts16w500,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    isCard == true
                        ? Text(
                            '****${cardLastDigits ?? ''}',
                            style: StylesConstant.ts16w500,
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
