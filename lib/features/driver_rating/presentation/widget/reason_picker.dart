import 'package:flutter/widgets.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/widgets/selectable_chip.dart';

class ReasonPicker extends StatelessWidget {
  const ReasonPicker({
    Key? key,
    required this.reasonList,
    required this.onSelected,
    this.selectedReasons,
  }) : super(key: key);

  final List<String> reasonList;
  final Function(String reason) onSelected;
  final List<String>? selectedReasons;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      mainAxisSpacing: 16.w,
      padding: EdgeInsets.zero,
      crossAxisSpacing: 16.w,
      // TODO: need to check this Aspect ratio
      childAspectRatio: 3.6,
      children: _reasonChips(),
    );
  }

  List<Widget> _reasonChips() {
    return reasonList
        .map(
          (String reason) => SelectableChip(
            isSelected: selectedReasons?.contains(reason) ?? false,
            text: reason,
            onTap: () {
              onSelected(reason);
            },
          ),
        )
        .toList();
  }
}
