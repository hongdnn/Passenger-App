import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:passenger/core/app_config/constant.dart';
import 'package:passenger/core/util/localization.dart';
import 'package:passenger/features/booking_page/data/model/swap_item_location_model.dart';
import 'package:passenger/features/booking_page/data/model/upsert_draft_booking_model.dart';
import 'package:passenger/util/assets.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/string_constant.dart';
import 'package:passenger/util/styles.dart';

class CreateAddAddressWidget extends StatefulWidget {
  const CreateAddAddressWidget({
    Key? key,
    required this.onTapDestination,
    required this.listLocation,
    required this.onAdd,
    required this.onDelete,
    required this.onSwap,
    required this.onReorder,
  }) : super(key: key);

  final List<LocationRequest> listLocation;
  final Function(int destinationIndex)? onTapDestination;
  final Function(int destinationIndex)? onDelete;
  final Function()? onAdd;
  final Function(int first, int second)? onSwap;
  final Function(int oldIndex, int newIndex)? onReorder;
  @override
  State<CreateAddAddressWidget> createState() => _CreateAddAddressWidgetState();
}

class _CreateAddAddressWidgetState extends State<CreateAddAddressWidget> {
  late List<DestinationItem> _items;
  @override
  void initState() {
    super.initState();
    _items =
        List<DestinationItem>.generate(widget.listLocation.length, (int index) {
      return DestinationItem(index: index, model: widget.listLocation[index]);
    });
  }

  @override
  void didUpdateWidget(CreateAddAddressWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.listLocation != widget.listLocation) {
      _items = List<DestinationItem>.generate(widget.listLocation.length,
          (int index) {
        return DestinationItem(index: index, model: widget.listLocation[index]);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24.w,
      ).copyWith(top: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _destinationPin(),
          SizedBox(
            width: 12.w,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ReorderableListView(
                  physics: const NeverScrollableScrollPhysics(),
                  buildDefaultDragHandles: _items.length > minDestinationLength,
                  shrinkWrap: true,
                  primary: false,
                  children: List<Widget>.generate(_items.length, (int index) {
                    return Container(
                      key: ObjectKey(_items[index]),
                      decoration: BoxDecoration(
                        color: ColorsConstant.cFFF7F7F8,
                        borderRadius: BorderRadius.circular(8.w),
                      ),
                      margin: EdgeInsets.symmetric(vertical: 8.w),
                      child: ListTile(
                        onTap: () {
                          widget.onTapDestination?.call(index);
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.w),
                        ),
                        title: Text(
                          _items[index].model?.address ?? '',
                          maxLines: 1,
                        ),
                        trailing: _trailingWidget(index, context),
                      ),
                    );
                  }),
                  onReorder: (int oldIndex, int newIndex) {
                    widget.onReorder?.call(oldIndex, newIndex);
                  },
                ),
                addDestination(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _trailingWidget(int index, BuildContext context) {
    if (_items.length == minDestinationLength && index == _items.length - 1) {
      return switchDestination(index);
    } else if (_items.length > minDestinationLength) {
      return changeAndDeleteDestination(index);
    } else {
      return const SizedBox();
    }
  }

  Widget switchDestination(int index) {
    return InkWell(
      onTap: () {
        _onSwap(index);
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 8.h),
        child: SvgPicture.asset(
          SvgAssets.icSwitch,
          width: 24.w,
          height: 24.h,
        ),
      ),
    );
  }

  Widget changeAndDeleteDestination(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        InkWell(
          onTap: () {
            _onSwap(index);
          },
          child: Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: SvgPicture.asset(
              SvgAssets.icOthers,
            ),
          ),
        ),
        _items.length > minDestinationLength && index != 0
            ? InkWell(
                onTap: () {
                  _onDelete(index);
                },
                child: Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: SvgPicture.asset(
                    SvgAssets.icCloseGray,
                  ),
                ),
              )
            : SizedBox(
                width: 24.w,
                height: 24.h,
              ),
      ],
    );
  }

  void _onSwap(int index) {
    if (index == _items.length - 1) {
      widget.onSwap?.call(index, 0);
    } else {
      widget.onSwap?.call(index, index + 1);
    }
  }

  void _onDelete(int index) {
    widget.onDelete?.call(index);
  }

  Widget addDestination() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      child: _items.length < maxDestinationLength
          ? FittedBox(
            child: InkWell(
                onTap: () {
                  widget.onAdd?.call();
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset(
                      SvgAssets.icPlusBt,
                      width: 20.w,
                      height: 20.h,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      S(context).add_a_place,
                      style: StylesConstant.ts14w500.copyWith(
                        color: ColorsConstant.cFFA33AA3,
                      ),
                    ),
                  ],
                ),
              ),
          )
          : const SizedBox(),
    );
  }

  Widget _destinationPin() {
    List<Widget> pins = <Widget>[];
    pins
      ..add(
        SizedBox(height: 25.h),
      )
      ..add(
        SvgPicture.asset(SvgAssets.icPin),
      );

    if (_items.length <= minDestinationLength) {
      pins.add(
        Column(
          children: <Widget>[
            Container(
              height: 45.h,
              padding: EdgeInsets.all(5.h),
              child: SvgPicture.asset(SvgAssets.icStripedLines),
            ),
            SvgPicture.asset(SvgAssets.icPinDestination),
          ],
        ),
      );
    } else {
      for (int i = minDestinationLength - 1; i < _items.length; i++) {
        pins.add(
          Column(
            children: <Widget>[
              Container(
                height: 45.h,
                padding: EdgeInsets.all(5.h),
                child: SvgPicture.asset(SvgAssets.icStripedLines),
              ),
              SvgPicture.asset(StringConstant.iconDestination[i]!),
            ],
          ),
        );
      }
    }
    return Column(
      children: pins,
    );
  }
}
