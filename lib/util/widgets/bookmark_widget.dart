import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:passenger/core/util/localization.dart';
import 'package:passenger/features/favorite_location/data/model/favorite_location.dart';
import 'package:passenger/features/location/data/model/location_address_model.dart';
import 'package:passenger/features/location/presentation/widget/location_picker_page.dart';
import 'package:passenger/util/assets.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/widgets/custom_card_widget.dart';
import 'package:passenger/util/widgets/flat_chip_widget.dart';

class Bookmark extends StatelessWidget {
  const Bookmark({
    Key? key,
    required this.data,
    this.onAdd,
  }) : super(key: key);

  final List<FavoriteLocation> data;
  final Function()? onAdd;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      child: CustomCardWidget<FavoriteLocation>(
        scrollDirection: Axis.horizontal,
        data: data,
        itemBuilder: (BuildContext context, FavoriteLocation item, _) {
          return _bookmarkItem(context, item);
        },
      ),
    );
  }

  Widget _bookmarkItem(BuildContext context, FavoriteLocation item) {
    return Container(
      margin: EdgeInsets.only(right: 8.w),
      child: item.id == null
          ? _buildAddItem(context)
          : _buildBookMarkItem(item, context),
    );
  }

  FlatChip _buildBookMarkItem(FavoriteLocation item, BuildContext context) {
    return FlatChip(
      text: item.title ?? '',
      onPressed: () {
        Navigator.pushNamed(
          context,
          LocationPickerPage.routeName,
          arguments: LocationPickerArg(
            bookingLocation: LocationAddressModel.fromFavoriteLocation(item),
          ),
        );
      },
      icon: SvgPicture.asset(
        SvgAssets.icBookmark,
        width: 16.w,
        height: 16.w,
        color: ColorsConstant.cFF73768C,
      ),
    );
  }

  Widget _buildAddItem(BuildContext context) {
    return FlatChip(
      text: S(context).bookmark_add_new_title,
      onPressed: () {
        onAdd?.call();
      },
      icon: const Icon(Icons.add),
    );
  }
}
