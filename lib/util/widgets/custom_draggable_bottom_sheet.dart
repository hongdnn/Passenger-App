import 'package:flutter/material.dart';
import 'package:passenger/util/colors.dart';

class CustomDraggableBottomSheet extends StatelessWidget {
  const CustomDraggableBottomSheet({
    Key? key,
    this.initialChildSize = 0.5,
    this.minChildSize = 0.5,
    this.expand = true,
    this.maxChildSize = 1.0,
    this.snap = false,
    required this.content,
  }) : super(key: key);
  final double initialChildSize;
  final double minChildSize;
  final double maxChildSize;
  final bool? expand;
  final bool? snap;
  final Widget content;
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: initialChildSize,
      minChildSize: minChildSize,
      maxChildSize: maxChildSize,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: ColorsConstant.cWhite,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: content,
          ),
        );
      },
    );
  }
}
