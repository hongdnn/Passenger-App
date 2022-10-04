import 'package:passenger/core/util/localization.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/date_util.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/styles.dart';

class ItemScrollPhysics extends ScrollPhysics {
  const ItemScrollPhysics({
    ScrollPhysics? parent,
    this.itemHeight,
    this.targetPixelsLimit = 0.0,
  })  : assert(itemHeight != null && itemHeight > 0),
        super(parent: parent);
  final double? itemHeight;
  final double targetPixelsLimit;

  @override
  ItemScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return ItemScrollPhysics(
      parent: buildParent(ancestor),
      itemHeight: itemHeight,
    );
  }

  double _getItem(ScrollPosition position) {
    double maxScrollItem =
        (position.maxScrollExtent / itemHeight!).floorToDouble();
    return min(max(0, position.pixels / itemHeight!), maxScrollItem);
  }

  double _getPixels(ScrollPosition position, double item) {
    return item * itemHeight!;
  }

  double _getTargetPixels(
    ScrollPosition position,
    Tolerance tolerance,
    double velocity,
  ) {
    double item = _getItem(position);
    if (velocity < -tolerance.velocity) {
      item -= targetPixelsLimit;
    } else if (velocity > tolerance.velocity) {
      item += targetPixelsLimit;
    }
    return _getPixels(position, item.roundToDouble());
  }

  @override
  Simulation? createBallisticSimulation(
    ScrollMetrics position,
    double velocity,
  ) {
    Tolerance tolerance = this.tolerance;
    final double target =
        _getTargetPixels(position as ScrollPosition, tolerance, velocity);
    if (target != position.pixels) {
      return ScrollSpringSimulation(
        spring,
        position.pixels,
        target,
        velocity,
        tolerance: tolerance,
      );
    }
    return null;
  }

  @override
  bool get allowImplicitScrolling => false;
}

typedef SelectedIndexCallback = void Function(int);
typedef TimePickerCallback = void Function(DateTime);

class TimePickerSpinner extends StatefulWidget {
  const TimePickerSpinner({
    Key? key,
    required this.time,
    this.minutesInterval = 1,
    this.highlightedTextStyle,
    this.normalTextStyle,
    this.itemHeight,
    this.itemWidth,
    this.dayAlignment,
    this.timeAlignment,
    this.spacing,
    this.is24HourMode = true,
    this.isFirstTime = false,
    this.onTimeChange,
  }) : super(key: key);
  final DateTime time;
  final int minutesInterval;

  final bool is24HourMode;
  final bool isFirstTime;

  final TextStyle? highlightedTextStyle;
  final TextStyle? normalTextStyle;
  final double? itemHeight;
  final double? itemWidth;
  final AlignmentGeometry? dayAlignment;
  final AlignmentGeometry? timeAlignment;
  final double? spacing;

  final TimePickerCallback? onTimeChange;

  @override
  TimePickerSpinnerState createState() => TimePickerSpinnerState();
}

class TimePickerSpinnerState extends State<TimePickerSpinner> {
  ScrollController dayController = ScrollController();
  ScrollController hourController = ScrollController();
  ScrollController minuteController = ScrollController();

  int currentSelectedHourIndex = -1;
  int currentSelectedDayIndex = -1;
  int currentSelectedMinuteIndex = -1;

  late DateTime currentTime;
  late DateTime selectedTime;
  bool isDayScrolling = false;
  bool isHourScrolling = false;
  bool isMinuteScrolling = false;

  final TextStyle defaultHighlightTextStyle =
      const TextStyle(fontSize: 32, color: Colors.black);
  final TextStyle defaultNormalTextStyle =
      const TextStyle(fontSize: 32, color: Colors.black54);
  final double defaultItemHeight = 60;
  final double defaultItemWidth = 100;
  final double defaultSpacing = 20;
  final AlignmentGeometry defaultDayAlignment = Alignment.centerRight;
  final AlignmentGeometry defaultTimeAlignment = Alignment.center;

  final List<String> days = <String>[];

  TextStyle? _getHighlightedTextStyle() {
    return widget.highlightedTextStyle ?? defaultHighlightTextStyle;
  }

  TextStyle? _getNormalTextStyle() {
    return widget.normalTextStyle ?? defaultNormalTextStyle;
  }

  int _getHourCount() {
    return widget.is24HourMode ? 24 : 12;
  }

  void _getDays() {
    final int currentDate = currentTime.day;
    const int numOfDayToShow = 7;
    final int daysInMonth =
        DateUtil.daysInMonth(currentTime.month, currentTime.year);
    String locale = Localizations.localeOf(context).languageCode;
    for (int i = currentDate; i <= daysInMonth; i++) {
      if (days.length > numOfDayToShow) {
        break;
      }
      days.add(
        DateFormat.MMMEd(locale).format(
          DateTime(
            currentTime.year,
            currentTime.month,
            i,
          ),
        ),
      );
    }
    if (days.length < numOfDayToShow) {
      final int numOfMissedDays = numOfDayToShow - days.length;
      for (int i = 1; i <= numOfMissedDays; i++) {
        if (days.length > numOfDayToShow) {
          break;
        }
        days.add(
          DateFormat.MMMEd(locale).format(
            DateTime(
              currentTime.year,
              DateUtil.getNextMonth(currentTime.month),
              i,
            ),
          ),
        );
      }
    }
  }

  int _getMinuteCount() {
    return (60 / widget.minutesInterval).floor();
  }

  double? _getItemHeight() {
    return widget.itemHeight ?? defaultItemHeight;
  }

  double? _getItemWidth() {
    return widget.itemWidth ?? defaultItemWidth;
  }

  double? _getSpacing() {
    return widget.spacing ?? defaultSpacing;
  }

  AlignmentGeometry? _getDayAlignment() {
    return widget.dayAlignment ?? defaultDayAlignment;
  }

  AlignmentGeometry? _getTimeAlignment() {
    return widget.timeAlignment ?? defaultDayAlignment;
  }

  bool isLoop(int value) {
    return value > 3;
  }

  DateTime getDateTime() {
    int dayIndex = currentSelectedDayIndex - days.length;
    int hour = currentSelectedHourIndex - _getHourCount();
    if (!widget.is24HourMode) hour += 12;
    int minute = (currentSelectedMinuteIndex -
            (isLoop(_getMinuteCount()) ? _getMinuteCount() : 1)) *
        widget.minutesInterval;
    final String date = days[dayIndex];
    String locale = Localizations.localeOf(context).languageCode;
    DateTime parseDate = DateFormat.MMMEd(locale).parse(date);
    return DateTime(
      currentTime.year,
      parseDate.month,
      parseDate.day,
      hour,
      minute,
    );
  }

  @override
  void initState() {
    currentTime = DateTime.now();
    selectedTime = widget.time;
    super.initState();

    if (widget.onTimeChange != null) {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => widget.onTimeChange!(getDateTime()));
    }
  }

  @override
  void didChangeDependencies() {
    _getDays();
    _setUpController();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> contents = <Widget>[
      SizedBox(
        width: _getItemWidth(),
        height: _getItemHeight()! * 3,
        child: _buildDateSpinner(
          dayController,
          days.length,
          currentSelectedDayIndex,
          isDayScrolling,
          (int index) {
            currentSelectedDayIndex = index;
            isDayScrolling = false;
          },
          () => isDayScrolling = false,
        ),
      ),
      _spacer(),
      SizedBox(
        width: _getItemWidth(),
        height: _getItemHeight()! * 3,
        child: _buildSpinner(
          hourController,
          _getHourCount(),
          currentSelectedHourIndex,
          isHourScrolling,
          (int index) {
            currentSelectedHourIndex = index;
            isHourScrolling = true;
          },
          () => isHourScrolling = false,
          interval: 1,
        ),
      ),
      _spacer(),
      SizedBox(
        width: _getItemWidth(),
        height: _getItemHeight()! * 3,
        child: _buildSpinner(
          minuteController,
          _getMinuteCount(),
          currentSelectedMinuteIndex,
          isMinuteScrolling,
          (int index) {
            currentSelectedMinuteIndex = index;
            isMinuteScrolling = false;
          },
          () => isMinuteScrolling = false,
          interval: widget.minutesInterval,
        ),
      ),
    ];
    return Stack(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: contents,
        ),
        Positioned(
          top: 78.h,
          child: _divider(),
        ),
        Positioned(
          top: 158.h,
          child: _divider(),
        ),
      ],
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      width: ScreenSize.width - 48.w,
      height: 1.5,
      color: ColorsConstant.cFFE3E4E8,
    );
  }

  Widget _spacer() {
    return SizedBox(
      width: _getSpacing(),
      height: _getItemHeight()! * 3,
    );
  }

  Widget _buildDateSpinner(
    ScrollController controller,
    int max,
    int selectedIndex,
    bool isScrolling,
    SelectedIndexCallback onUpdateSelectedIndex,
    VoidCallback onScrollEnd,
  ) {
    String locale = Localizations.localeOf(context).languageCode;
    Widget spinner = NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollNotification) {
        if (scrollNotification is UserScrollNotification) {
          if (scrollNotification.direction == ScrollDirection.idle) {
            if (isLoop(max)) {
              int segment = (selectedIndex / max).floor();
              if (segment == 0) {
                onUpdateSelectedIndex(selectedIndex + max);
                controller
                    .jumpTo(controller.offset + (max * _getItemHeight()!));
              } else if (segment == 2) {
                onUpdateSelectedIndex(selectedIndex - max);
                controller
                    .jumpTo(controller.offset - (max * _getItemHeight()!));
              }
            }

            setState(() {
              onScrollEnd();
              if (widget.onTimeChange != null) {
                widget.onTimeChange!(getDateTime());
              }
            });
          }
        } else if (scrollNotification is ScrollUpdateNotification) {
          setState(() {
            onUpdateSelectedIndex(
              (controller.offset / _getItemHeight()!).round() + 1,
            );
          });
        }
        return true;
      },
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          String? text = '';
          final String date = days[index % max];
          DateTime parseDate = DateFormat.MMMEd(locale).parse(date);
          if (parseDate.day == currentTime.day) {
            text = S(context).today;
          } else if (isLoop(max)) {
            text = date;
          } else if (index != 0 && index != max + 1) {
            text = (((index - 1) % max)).toString();
          }
          return Container(
            height: _getItemHeight(),
            alignment: _getDayAlignment(),
            child: Text(
              text,
              textAlign: TextAlign.end,
              style: selectedIndex == index
                  ? StylesConstant.ts16w400
                      .copyWith(color: ColorsConstant.cFFA33AA3)
                  : StylesConstant.ts16w400
                      .copyWith(color: ColorsConstant.cFFABADBA),
            ),
          );
        },
        controller: dayController,
        itemCount: isLoop(max) ? max * 3 : max + 2,
        physics: ItemScrollPhysics(itemHeight: _getItemHeight()),
        padding: EdgeInsets.zero,
      ),
    );

    return Stack(
      children: <Widget>[
        Positioned.fill(child: spinner),
        isScrolling
            ? Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0),
                ),
              )
            : Container()
      ],
    );
  }

  Widget _buildSpinner(
    ScrollController controller,
    int max,
    int selectedIndex,
    bool isScrolling,
    SelectedIndexCallback onUpdateSelectedIndex,
    VoidCallback onScrollEnd, {
    int interval = 1,
  }) {
    Widget spinner = NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollNotification) {
        if (scrollNotification is UserScrollNotification) {
          if (scrollNotification.direction == ScrollDirection.idle) {
            int segment = (selectedIndex / max).floor();
            if (segment == 0) {
              onUpdateSelectedIndex(selectedIndex + max);
              controller.jumpTo(controller.offset + (max * _getItemHeight()!));
            } else if (segment == 2) {
              onUpdateSelectedIndex(selectedIndex - max);
              controller.jumpTo(controller.offset - (max * _getItemHeight()!));
            }
            setState(() {
              onScrollEnd();
              if (widget.onTimeChange != null) {
                widget.onTimeChange!(getDateTime());
              }
            });
          }
        } else if (scrollNotification is ScrollUpdateNotification) {
          setState(() {
            onUpdateSelectedIndex(
              (controller.offset / _getItemHeight()!).round() + 1,
            );
          });
        }
        return false;
      },
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          String text = '';
          if (isLoop(max)) {
            text = ((index % max) * interval).toString();
          } else if (index != 0 && index != max + 1) {
            text = (((index - 1) % max) * interval).toString();
          }
          if (!widget.is24HourMode &&
              controller == hourController &&
              text == '0') {
            text = '12';
          }
          if (text.isNotEmpty) {
            text = text.padLeft(2, '0');
          }
          return Container(
            height: _getItemHeight(),
            alignment: _getTimeAlignment(),
            child: Center(
              child: Text(
                text,
                style: selectedIndex == index
                    ? _getHighlightedTextStyle()
                    : _getNormalTextStyle(),
              ),
            ),
          );
        },
        controller: controller,
        itemCount: isLoop(max) ? max * 3 : max + 2,
        physics: ItemScrollPhysics(itemHeight: _getItemHeight()),
        padding: EdgeInsets.zero,
      ),
    );

    return Stack(
      children: <Widget>[
        Positioned.fill(child: spinner),
        isScrolling
            ? Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0),
                ),
              )
            : const SizedBox()
      ],
    );
  }

  @override
  void dispose() {
    dayController.dispose();
    hourController.dispose();
    minuteController.dispose();
    super.dispose();
  }

  void _setUpController() {
    currentSelectedDayIndex = days.length;
    dayController = ScrollController(
      initialScrollOffset: (currentSelectedDayIndex - 1) * _getItemHeight()!,
    );

    currentSelectedHourIndex =
        (currentTime.hour % (widget.is24HourMode ? 24 : 12)) + _getHourCount();

    if (widget.isFirstTime) {
      currentSelectedHourIndex += 1;
    }
    hourController = ScrollController(
      initialScrollOffset: (currentSelectedHourIndex - 1) * _getItemHeight()!,
    );

    currentSelectedMinuteIndex =
        (currentTime.minute / widget.minutesInterval).floor() +
            (isLoop(_getMinuteCount()) ? _getMinuteCount() : 1);
    minuteController = ScrollController(
      initialScrollOffset: (currentSelectedMinuteIndex - 1) * _getItemHeight()!,
    );
  }
}
