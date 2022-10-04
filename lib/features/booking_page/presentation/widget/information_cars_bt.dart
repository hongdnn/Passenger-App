import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passenger/util/assets.dart';

class InformationOfCarsBt extends StatelessWidget {
  const InformationOfCarsBt({
    Key? key,
    required this.selectedCarTypeId,
    required this.onViewCarDetail,
  }) : super(key: key);

  final int selectedCarTypeId;
  final Function()? onViewCarDetail;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onViewCarDetail?.call();
      },
      child: SvgPicture.asset(SvgAssets.icInfo),
    );
  }
}