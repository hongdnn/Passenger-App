import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:passenger/util/assets.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/size.dart';

class SearchAppbarWidget extends StatelessWidget {
  SearchAppbarWidget({
    Key? key,
    this.onChanged,
    this.onFieldSubmitted,
    this.onTap,
    this.hintText = 'ค้นหา',
  }) : super(key: key);

  final Function(String text)? onChanged;
  final Function(String text)? onFieldSubmitted;
  final Function()? onTap;
  final String hintText;

  final ValueNotifier<String> _txtSearch = ValueNotifier<String>('');
  final TextEditingController controller = TextEditingController();

  _handleOnChange(String text) {
    onChanged?.call(text);
    _txtSearch.value = text;
  }

  _handleClearText() {
    controller.clear();
    onChanged?.call('');
    _txtSearch.value = '';
  }

  Widget _buildIcon(String text) {
    if (text.isEmpty) {
      return SvgPicture.asset(
        SvgAssets.icSearch,
        fit: BoxFit.scaleDown,
      );
    }
    return InkWell(
      onTap: _handleClearText,
      child: const Icon(
        Icons.close,
        color: ColorsConstant.cFF73768C,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      decoration: BoxDecoration(
        color: ColorsConstant.cFFF7F7F8,
        borderRadius: BorderRadius.all(Radius.circular(8.w)),
      ),
      child: TextFormField(
        onTap: onTap,
        controller: controller,
        onChanged: _handleOnChange,
        onFieldSubmitted: onFieldSubmitted,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 14.w, top: 4.h),
          suffixIcon: ValueListenableBuilder<String>(
            valueListenable: _txtSearch,
            builder: (_, String text, __) {
              return _buildIcon(text);
            },
          ),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: hintText,
        ),
      ),
    );
  }
}
