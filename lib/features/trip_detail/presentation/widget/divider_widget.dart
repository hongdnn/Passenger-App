

import 'package:flutter/material.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/size.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: const Divider(
        height: 1,
        color: ColorsConstant.cFFE3E4E8,
      ),
    ); 
  }
}