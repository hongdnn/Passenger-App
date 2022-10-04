import 'package:flutter/cupertino.dart';
import 'package:passenger/util/styles.dart';

class TitleAndValueWidget extends StatelessWidget {
  const TitleAndValueWidget({
    super.key,
    required this.title,
    required this.value,
    this.titleStyle,
    this.valueStyle,
  });
  final String title;
  final String value;
  final TextStyle? titleStyle;
  final TextStyle? valueStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Text(
            title,
            style: titleStyle ?? StylesConstant.ts16w400,
            maxLines: 1,
          ),
        ),
        Text(
          value,
          style: valueStyle ?? StylesConstant.ts16w500,
          maxLines: 1,
        )
      ],
    );
  }
}
