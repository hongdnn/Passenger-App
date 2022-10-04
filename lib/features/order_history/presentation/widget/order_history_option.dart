import 'package:flutter/material.dart';
import 'package:passenger/core/app_config/constant.dart';
import 'package:passenger/core/util/localization.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/styles.dart';
import 'package:passenger/util/widgets/custom_button.dart';

class OrderHistoryOption extends StatefulWidget {
  const OrderHistoryOption({
    Key? key,
    this.onOptionChanged,
    required this.onSelectedButton,
  }) : super(key: key);
  final Function(int index)? onOptionChanged;
  final int onSelectedButton;

  @override
  OrderHistoryOptionState createState() => OrderHistoryOptionState();
}

class OrderHistoryOptionState extends State<OrderHistoryOption> {
  final ValueNotifier<int> _btnSelected = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _btnSelected,
      builder: (_, int newValue, Widget? error) {
        return Padding(
          padding: EdgeInsets.only(right: 20.w),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List<Widget>.generate(
                tabCount,
                (int index) => Row(
                  children: <Widget>[
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        widget.onOptionChanged?.call(index);
                        _btnSelected.value = index;
                      },
                      child: CustomButton(
                        params: widget.onSelectedButton == index
                            ? _buildBtnIsSelected(context, index)
                            : _buildBtnUnselected(context, index),
                      ),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  CustomButtonParams _buildBtnUnselected(BuildContext context, int index) {
    return CustomButtonParams.primaryUnselected(
      text: _getTextOption(context, index),
    ).copyWith(
      textStyle:
          StylesConstant.ts14w400.copyWith(color: ColorsConstant.cFFABADBA),
      padding: EdgeInsets.symmetric(
        vertical: 4.w,
        horizontal: 8.w,
      ),
    );
  }

  String _getTextOption(BuildContext context, int index) {
    if (index == 0) {
      return S(context).ongoing;
    } else if (index == 1) {
      return S(context).completed;
    } else {
      return S(context).canceled;
    }
  }

  CustomButtonParams _buildBtnIsSelected(BuildContext context, int index) {
    return CustomButtonParams.primary(
      text: _getTextOption(context, index),
    ).copyWith(
      textStyle: StylesConstant.ts14w400cWhite.copyWith(
        fontWeight: FontWeight.w500,
      ),
      padding: EdgeInsets.symmetric(
        vertical: 4.w,
        horizontal: 8.w,
      ),
    );
  }
}
