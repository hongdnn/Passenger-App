import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passenger/core/util/localization.dart';
import 'package:passenger/util/assets.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/styles.dart';

class MessageInputWidget extends StatefulWidget {
  const MessageInputWidget({
    Key? key,
    required this.onPressAddMedia,
    required this.onPressCamera,
    required this.onPressSend,
    required this.onChanged,
  }) : super(key: key);
  final Future<void> Function() onPressAddMedia;
  final Future<void> Function() onPressCamera;
  final Function(String) onPressSend;

  final Function(String text) onChanged;

  @override
  MessageInputWidgetState createState() => MessageInputWidgetState();
}

class MessageInputWidgetState extends State<MessageInputWidget> {
  final ValueNotifier<bool> shouldShowMediaButton = ValueNotifier<bool>(true);
  final ValueNotifier<bool> enableSendButton = ValueNotifier<bool>(false);
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          const Divider(
            thickness: 1,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 15.w,
              right: 18.w,
              top: 15.h,
              bottom: 10.h,
            ),
            child: Row(
              children: <Widget>[
                ValueListenableBuilder<bool>(
                    valueListenable: shouldShowMediaButton,
                    builder: (_, bool showMediaButton, __) {
                      if (showMediaButton) {
                        return Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () async =>
                                  await widget.onPressCamera.call(),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(
                                  SvgAssets.icCamera,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async =>
                                  await widget.onPressAddMedia.call(),
                              child: SvgPicture.asset(SvgAssets.icLibrary),
                            ),
                          ],
                        );
                    }
                    return GestureDetector(
                      onTap: () {
                        shouldShowMediaButton.value = true;
                      },
                      child: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: ColorsConstant.cFF454754,
                      ),
                    );
                  },
                ),
                SizedBox(width: 13.w),
                Expanded(
                  child: Focus(
                    onFocusChange: (bool isFocused) {
                      shouldShowMediaButton.value = !isFocused;
                    },
                    child: TextField(
                      maxLines: 4,
                      minLines: 1,
                      style: StylesConstant.ts16w400,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8.h),
                        isDense: true,
                        fillColor: ColorsConstant.cFFF7F7F8,
                        filled: true,
                        hintText: S(context).type_message,
                        errorBorder: InputBorder.none,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                      controller: _textEditingController,
                      onChanged: (String text) {
                        widget.onChanged(text);
                        enableSendButton.value = text.isNotEmpty;
                      },
                    ),
                  ),
                ),
                SizedBox(width: 14.w),
                GestureDetector(
                  onTap: () {
                    widget.onPressSend(_textEditingController.text);
                    _textEditingController.text = '';
                  },
                  child: ValueListenableBuilder<bool>(
                    valueListenable: enableSendButton,
                    builder:
                        (BuildContext context, bool enable, Widget? widget) {
                      return SvgPicture.asset(
                        SvgAssets.icSendMsg,
                        color: enable
                            ? ColorsConstant.cFFA33AA3
                            : ColorsConstant.cFFABADBA,
                      );
                    },
                  ),
                ),

                // SizedBox(
                //   height: 30,
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: <Widget>[
                //       // const SizedBox(height: 10),
                //
                //       // const SizedBox(height: 10),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
