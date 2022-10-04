import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:passenger/core/util/localization.dart';
import 'package:passenger/features/favorite_location/data/model/favorite_location.dart';
import 'package:passenger/util/assets.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/styles.dart';
import 'package:passenger/util/widgets/custom_dialog.dart';

class LocationSavedItem extends StatelessWidget {
  const LocationSavedItem({
    Key? key,
    this.icon,
    this.onTap,
    required this.data,
    this.onDelete,
    this.onEdit,
  }) : super(key: key);
  final Function()? onTap;
  final String? icon;
  final FavoriteLocation data;
  final Function(FavoriteLocation data)? onEdit;
  final Function(FavoriteLocation data)? onDelete;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 40.w,
              width: 40.w,
              decoration: BoxDecoration(
                color: ColorsConstant.cFFF7F7F8,
                borderRadius: BorderRadius.all(Radius.circular(8.w)),
              ),
              child: Center(
                child: SvgPicture.asset(
                  icon ?? SvgAssets.icSavedLocation,
                  width: 20.w,
                  height: 20.w,
                  color: ColorsConstant.cFF73768C,
                ),
              ),
            ),
            SizedBox(
              width: 12.w,
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  data.title != null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                width: double.maxFinite,
                                child: Text(
                                  data.title!,
                                  overflow: TextOverflow.ellipsis,
                                  style: StylesConstant.ts16w500,
                                ),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    onEdit?.call(data);
                                  },
                                  child: ShaderMask(
                                    blendMode: BlendMode.srcATop,
                                    shaderCallback: (Rect bounds) =>
                                        ColorsConstant.appPrimaryGradient
                                            .createShader(bounds),
                                    child: SvgPicture.asset(
                                      icon ?? SvgAssets.icEdit,
                                      width: 16.w,
                                      height: 16.w,
                                      color: ColorsConstant.cFF73768C,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 6.w,
                                ),
                                InkWell(
                                  onTap: () {
                                    showCustomDialog(
                                      context: context,
                                      options: CustomDialogParams(
                                        title:
                                            '''${S(context).delete} “${data.title}”''',
                                        message: S(context).msg_delete_favorite,
                                        negativeParams:
                                            CustomDialogButtonParams(
                                          title: S(context).cancel,
                                        ),
                                        positiveParams:
                                            CustomDialogButtonParams(
                                          hasGradient: true,
                                          title: S(context).confirm,
                                          onPressed: () {
                                            onDelete?.call(data);
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                  child: ShaderMask(
                                    blendMode: BlendMode.srcATop,
                                    shaderCallback: (Rect bounds) =>
                                        ColorsConstant.appPrimaryGradient
                                            .createShader(bounds),
                                    child: SvgPicture.asset(
                                      icon ?? SvgAssets.icDelete,
                                      width: 16.w,
                                      height: 16.w,
                                      color: ColorsConstant.cFF73768C,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      : const SizedBox(),
                  data.note?.isNotEmpty == true
                      ? Container(
                          alignment: Alignment.centerLeft,
                          width: double.maxFinite,
                          child: Text(
                            data.note!,
                            overflow: TextOverflow.ellipsis,
                            style: StylesConstant.ts14w500.copyWith(),
                          ),
                        )
                      : const SizedBox(),
                  data.address?.isNotEmpty == true
                      ? Container(
                          alignment: Alignment.centerLeft,
                          width: double.maxFinite,
                          child: Text(
                            data.address!,
                            overflow: TextOverflow.ellipsis,
                            style: StylesConstant.ts14w400.copyWith(),
                          ),
                        )
                      : const SizedBox()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
