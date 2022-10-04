import 'package:flutter/material.dart';
import 'package:passenger/features/location/data/model/autocomplete_model.dart';
import 'package:passenger/util/assets.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/widgets/basic_list_tile.dart';

class SearchResultList extends StatelessWidget {
  const SearchResultList({
    super.key,
    required this.predictions,
    this.onItemTap,
  });
  final List<Prediction> predictions;
  final Function(Prediction item)? onItemTap;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(24.w),
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: 10.h);
      },
      shrinkWrap: true,
      primary: false,
      itemCount: predictions.length,
      itemBuilder: (BuildContext context, int index) {
        return BasicListTile(
          title: predictions[index].getMainText,
          subtitle: predictions[index].getSecondaryText,
          onTap: () {
            onItemTap?.call(predictions[index]);
          },
          icon: SvgAssets.icLocation,
        );
      },
    );
  }
}
