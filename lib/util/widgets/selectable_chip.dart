import 'package:flutter/material.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/styles.dart';

class SelectableChip extends StatefulWidget {
  const SelectableChip({
    Key? key,
    required this.text,
    this.onTap,
    this.isSelected = false,
    this.horizontalPaddingChip = 8,
  }) : super(key: key);

  final String text;
  final bool isSelected;
  final VoidCallback? onTap;
  final double horizontalPaddingChip;

  @override
  State<SelectableChip> createState() => _SelectableChipState();
}

class _SelectableChipState extends State<SelectableChip> {
  BoxDecoration get decoration {
    return BoxDecoration(
      color: widget.isSelected ? ColorsConstant.cFFF6E5F6 : Colors.white,
      border: Border.all(
        color: widget.isSelected ? ColorsConstant.cFFA33AA3 : Colors.white,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(100.w),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withAlpha(8),
          offset: const Offset(0, 2),
          blurRadius: 8,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onTap?.call(),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: widget.horizontalPaddingChip,
          vertical: 8,
        ),
        decoration: decoration,
        child: Center(
          child: Text(
            widget.text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: StylesConstant.ts16w400,
          ),
        ),
      ),
    );
  }
}
