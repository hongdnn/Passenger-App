import 'package:flutter/material.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/styles.dart';

class ReasonItem extends StatelessWidget {
  const ReasonItem({
    Key? key,
    required this.onTap,
    required this.isSelected,
    required this.name,
  }) : super(key: key);
  final Function onTap;
  final bool isSelected;
  final String name;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap.call();
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? ColorsConstant.cFFF6E5F6 : Colors.white,
          border: Border.all(
            color: isSelected ? ColorsConstant.cFFA33AA3 : Colors.transparent,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(100.w),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(
                0,
                3,
              ),
            ),
          ],
        ),
        width: 150.w,
        height: 44.h,
        child: Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: StylesConstant.ts16w400,
        ),
      ),
    );
  }
}