import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passenger/core/app_config/constant.dart';
import 'package:passenger/core/util/localization.dart';
import 'package:passenger/features/booking_page/data/model/price_by_cartype_model.dart';
import 'package:passenger/util/assets.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/styles.dart';

class CarOptionWidget extends StatelessWidget {
  const CarOptionWidget({
    Key? key,
    this.color,
    this.borderColor,
    required this.data,
  }) : super(key: key);

  final Color? color;
  final Color? borderColor;

  final CarInfoByPrice data;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(
        horizontal: 16.w,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 8.h,
        vertical: 4.w,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
        color: color,
        border: Border.all(
          color: borderColor ?? Colors.transparent,
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Row(
              children: <Widget>[
                (data.carImage?.isNotEmpty == true)
                    ? CachedNetworkImage(
                        width: 48.w,
                        height: 48.h,
                        imageUrl: data.carImage ?? '',
                        errorWidget: (BuildContext context, String url, _) =>
                            SvgPicture.asset(
                          SvgAssets.icRbhCar,
                          width: 48.w,
                          height: 48.h,
                        ),
                        placeholder: (BuildContext context, String url) =>
                            const CupertinoActivityIndicator(),
                      )
                    : SvgPicture.asset(
                        SvgAssets.icRbhCar,
                        width: 48.w,
                        height: 48.h,
                      ),
                SizedBox(
                  width: 8.w,
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        data.typeName ?? '',
                        maxLines: 2,
                        style: StylesConstant.ts14w500.copyWith(
                          color: ColorsConstant.cBlack,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      Text(
                        data.typeSlogan ?? '',
                        maxLines: 2,
                        style: StylesConstant.ts12w400cFF73768C,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    '฿${data.price.toString().replaceAll(regexCarPrice, '')}',
                    style: StylesConstant.ts14w500,
                  ),
                  Text(
                    '5-10 ${S(context).min}',
                    style: StylesConstant.ts12w400,
                  ),
                ],
              ),
              SizedBox(
                width: 8.w,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 12.w,
                ),
                child: SvgPicture.asset(
                  (data.demandRate ?? defaultDemandRate) <= defaultDemandRate
                      ? SvgAssets.icDownArrow
                      : SvgAssets.icUpArrow,
                  width: 15.w,
                  height: 15.w,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
