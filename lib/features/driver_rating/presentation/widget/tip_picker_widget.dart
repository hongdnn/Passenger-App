import 'package:flutter/widgets.dart';
import 'package:passenger/core/app_config/constant.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/widgets/selectable_chip.dart';

class TipPicker extends StatelessWidget {
  const TipPicker({
    Key? key,
    required this.tipList,
    required this.onTipSelected,
    this.selectedTip,
  }) : super(key: key);

  final List<num> tipList;
  final Function(num tip) onTipSelected;
  final num? selectedTip;

  @override
  Widget build(BuildContext context) {
    if (tipList.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 44.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, int index) {
          final num item = tipList[index];
          return Padding(
            padding: index == 0 ? EdgeInsets.only(left: 24.w) : EdgeInsets.zero,
            child: SelectableChip(
              horizontalPaddingChip: 30.h,
              isSelected: selectedTip == defaultSelectedTip
                  ? false
                  : item == selectedTip,
              text: '฿${item.toString()}',
              onTap: () {
                onTipSelected(item);
              },
            ),
          );
        },
        separatorBuilder: (_, int index) {
          return SizedBox(width: 16.w);
        },
        itemCount: tipList.length,
      ),
    );
  }
}
