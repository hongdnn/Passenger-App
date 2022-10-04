import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passenger/features/location/search_page.dart';
import 'package:passenger/util/assets.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/size.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    Key? key,
    this.contentPadding,
    this.hintText,
  }) : super(key: key);
  final EdgeInsetsGeometry? contentPadding;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, SearchPage.routeName),
      child: Container(
        padding: contentPadding ??
            EdgeInsets.symmetric(vertical: 12.w, horizontal: 20.w),
        decoration: BoxDecoration(
          color: ColorsConstant.cFFF7F7F8,
          borderRadius: BorderRadius.all(Radius.circular(8.w)),
        ),
        child: Row(
          children: <Widget>[
            SvgPicture.asset(SvgAssets.icLocationFill),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                hintText ?? '',
                style: const TextStyle(color: ColorsConstant.cFFABADBA),
              ),
            )
          ],
        ),
      ),
    );
  }
}
