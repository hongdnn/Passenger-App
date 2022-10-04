import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:passenger/core/util/localization.dart';
import 'package:passenger/features/promotion/data/model/promotion_model.dart';
import 'package:passenger/util/assets.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/string_constant.dart';
import 'package:passenger/util/styles.dart';

class PromotionItem extends StatelessWidget {
  const PromotionItem({
    Key? key,
    required this.promotion,
    required this.onSelect,
  }) : super(key: key);

  final PromotionData promotion;
  final Function(PromotionData promotion) onSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: ColorsConstant.cFFE3E4E8),
      ),
      padding: EdgeInsets.symmetric(vertical: 8.h).copyWith(left: 16.w),
      margin: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: <Widget>[
          _prefixIcon(),
          SizedBox(width: 16.w),
          _content(context),
        ],
      ),
    );
  }

  Widget _prefixIcon() {
    if (promotion.iconUrl?.isNotEmpty == true) {
      return CachedNetworkImage(
        height: 36.w,
        width: 34.w,
        imageUrl: promotion.iconUrl!,
        errorWidget: (BuildContext context, String url, _) => SvgPicture.asset(
          SvgAssets.icRobinhood,
          height: 36.w,
          width: 34.w,
        ),
        placeholder: (BuildContext context, String url) =>
            const CupertinoActivityIndicator(),
      );
    } else {
      return SvgPicture.asset(
        SvgAssets.icRobinhood,
        height: 36.w,
        width: 34.w,
      );
    }
  }

  Expanded _content(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            promotion.promotionName ?? '',
            style: StylesConstant.ts14w500,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 2.h),
          Text(
            promotion.shortDescription ?? '',
            style: StylesConstant.ts14w400,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 2.h),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  '${S(context).promo_expiration} ${buildDateInLocale(
                    inputString:
                        promotion.endDate ?? StringConstant.mockDateTimeString,
                    context: context,
                  )}',
                  style: StylesConstant.ts12w400cFF73768C,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              _confirmBtn(context)
            ],
          )
        ],
      ),
    );
  }

  Widget _confirmBtn(BuildContext context) {
    return InkWell(
      highlightColor: ColorsConstant.cTransparent,
      splashColor: ColorsConstant.cTransparent,
      onTap: () {
        onSelect(promotion);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          S(context).promotion_apply_now,
          style:
              StylesConstant.ts14w400.copyWith(color: ColorsConstant.cFFA33AA3),
        ),
      ),
    );
  }
}
