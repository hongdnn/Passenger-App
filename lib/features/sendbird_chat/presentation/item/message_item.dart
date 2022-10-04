import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passenger/core/extension/int_extension.dart';
import 'package:passenger/core/extension/sendbird_base_message_extension.dart';
import 'package:passenger/core/util/localization.dart';
import 'package:passenger/features/sendbird_chat/data/util/sendbird_constant.dart';
import 'package:passenger/features/sendbird_chat/presentation/bloc/conversation_page_bloc.dart';
import 'package:passenger/util/assets.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/styles.dart';
import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/core/message/admin_message.dart';
import 'package:sendbird_sdk/core/message/base_message.dart';

class MessageItem extends StatefulWidget {
  const MessageItem({
    Key? key,
    required this.current,
    this.previous,
    this.next,
  }) : super(key: key);

  final BaseMessage current;
  final BaseMessage? previous;
  final BaseMessage? next;

  @override
  State<MessageItem> createState() => _MessageItemState();
}

class _MessageItemState extends State<MessageItem> {
  final GlobalKey key = GlobalKey();
  late OverlayEntry emojiEntry;

  @override
  Widget build(BuildContext context) {
    if (widget.current is AdminMessage) {
      return AdminWidget(adminMessage: widget.current.message);
    } else {
      return Visibility(
        visible: widget.current.customType == kMessageNormalKey,
        child: Align(
          alignment: widget.current.isMyMessage
              ? Alignment.topRight
              : Alignment.topLeft,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: (widget.previous?.isMyMessage == false &&
                        widget.current.isMyMessage)
                    ? 16
                    : 0,
              ),
              Visibility(
                visible: !widget.current.isSameDate(widget.previous),
                child: _buildDateWidget(),
              ),
              widget.current.isMyMessage
                  ? _buildRightWidget(context)
                  : _buildLeftWidget(context),
              SizedBox(height: (widget.next != null) ? 3 : 20),
            ],
          ),
        ),
      );
    }
  }

  Widget _buildLeftWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Visibility(
        //   visible: (!widget.current.isSendAtSameMinute(widget.previous) &&
        //           widget.current.isSameUser(widget.previous)) ||
        //       !widget.current.isSameUser(widget.previous) ||
        //       !widget.current.isSameDate(widget.previous),
        //   child: Row(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: <Widget>[
        //       _buildAvatarWidget(),
        //       _buildUserNameWidget(),
        //     ],
        //   ),
        // ),
        _buildLeftMessage(),
        // _buildReactions(),
      ],
    );
  }

  Widget _buildRightWidget(BuildContext context) {
    bool isSentSuccess =
        widget.current.sendingStatus == MessageSendingStatus.succeeded;
    return Container(
      padding: EdgeInsets.only(right: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: isSentSuccess
                        ? ColorsConstant.appPrimaryGradient
                        : null,
                    color: !isSentSuccess ? ColorsConstant.cFFABADBA : null,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  left: 8,
                  right: 8,
                  top: 8,
                  bottom: 8,
                ),
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.6,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const SizedBox(width: 4),
                        Flexible(
                          child: _buildUrlMessageWidget(
                            widget.current.message,
                            StylesConstant.ts16w400
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              if (widget.current.sendingStatus == MessageSendingStatus.failed) {
                final String msg = widget.current.message;
                final int msgId = widget.current.messageId;
                showCupertinoModalPopup(
                  context: context,
                  builder: (BuildContext buildContext) {
                    return CupertinoActionSheet(
                      actions: <Widget>[
                        CupertinoActionSheetAction(
                          child: Text(
                            S(context).resend,
                            style: StylesConstant.ts20w400
                                .copyWith(color: ColorsConstant.cFF229BF9),
                          ),
                          onPressed: () {
                            BlocProvider.of<ConversationPageBloc>(context)
                                .add(SendingMessageEvent(message: msg));
                            Navigator.pop(context);
                          },
                        ),
                        CupertinoActionSheetAction(
                          onPressed: () {
                            BlocProvider.of<ConversationPageBloc>(context)
                                .add(RemoveMessageEvent(messageId: msgId));
                            Navigator.pop(context);
                          },
                          isDestructiveAction: true,
                          child: Text(S(context).delete),
                        ),
                      ],
                      cancelButton: CupertinoActionSheetAction(
                        child: Text(
                          S(context).cancel,
                          style: StylesConstant.ts20w400
                              .copyWith(color: ColorsConstant.cFFEB6666),
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    );
                  },
                );
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                _buildSendStatusWidget(),
                const SizedBox(width: 4),
                Visibility(
                  visible: (!widget.current.isSendAtSameMinute(widget.next)),
                  child: isSentSuccess
                      ? _buildDateSentWidget()
                      : Text(
                          S(context).try_again,
                          style: StylesConstant.ts14w400cFFEB6666,
                        ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }

  Widget _buildLeftMessage() {
    return Container(
      padding: EdgeInsets.only(left: 16.w),
      child: Column(
        children: <Widget>[
          const SizedBox(width: 34),
          Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  key: key,
                  decoration: BoxDecoration(
                    // color: Colors.brown,
                    color: Colors.grey[200],
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                      topLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  left: 8,
                  right: 16,
                  top: 8,
                  bottom: 8,
                ),
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.6,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildUrlMessageWidget(
                      widget.current.message,
                      StylesConstant.ts16w400,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Visibility(
            visible: !widget.current.isSendAtSameMinute(widget.next),
            child: _buildDateSentWidget(),
          ),
        ],
      ),
    );
  }

  Widget _buildUrlMessageWidget(
    String url,
    TextStyle textStyle,
  ) {
    return Text(
      url,
      style: textStyle,
    );
  }

  Widget _buildSendStatusWidget() {
    switch (widget.current.sendingStatus) {
      case MessageSendingStatus.pending:
        return const SizedBox(
          height: 14,
          width: 14,
          child: FittedBox(
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: Colors.blue,
            ),
          ),
        );
      case MessageSendingStatus.failed:
        return SizedBox(
          height: 20,
          width: 20,
          child: FittedBox(
            child: SvgPicture.asset(SvgAssets.icRetry),
          ),
        );
      default:
        return Container();
    }
  }

  Widget _buildDateSentWidget() {
    final String time = widget.current.createdAt.toTimeInDay();
    // final String time = current.createdAt.toString();
    return Text(
      time,
      style: StylesConstant.ts14w400.copyWith(color: ColorsConstant.cFFABADBA),
    );
  }

  Widget _buildDateWidget() {
    final String date = widget.current.createdAt.toReadableDateWeekTime();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(height: 20.h),
          Text(
            date,
            style: StylesConstant.ts14w400
                .copyWith(color: ColorsConstant.cFFABADBA),
          ),
          SizedBox(height: 14.h),
        ],
      ),
    );
  }
}

class AdminWidget extends StatelessWidget {
  const AdminWidget({
    Key? key,
    required this.adminMessage,
  }) : super(key: key);

  final String adminMessage;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: FractionallySizedBox(
        widthFactor: 0.8,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  width: 18,
                  child: FittedBox(
                    child: CircleAvatar(
                      child: Icon(
                        Icons.notifications_on_outlined,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Flexible(child: Text(adminMessage)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
