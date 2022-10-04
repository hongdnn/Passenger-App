import 'package:flutter/material.dart';
import 'package:passenger/core/extension/int_extension.dart';
import 'package:passenger/core/extension/sendbird_base_message_extension.dart';
import 'package:passenger/core/extension/string_extension.dart';
import 'package:passenger/features/sendbird_chat/presentation/item/image_media_item.dart';
import 'package:passenger/features/sendbird_chat/presentation/item/message_item.dart';
import 'package:sendbird_sdk/core/message/admin_message.dart';
import 'package:sendbird_sdk/core/message/base_message.dart';
import 'package:sendbird_sdk/core/message/file_message.dart';
import 'package:sendbird_sdk/core/message/user_message.dart';

extension ListX on List<BaseMessage> {
  List<Widget> getMessageItemList({
    int unreadMessageCount = -1,
  }) {
    List<Widget> list = <Widget>[
      // const SizedBox(height: kDefaultPadding),
    ];
    BaseMessage current;
    BaseMessage? previous, next;
    FileMessage currentFileMessage;
    List<FileMessage> fileMessages;
    int tempIndex;
    for (int index = 0; index < length; index++) {
      previous = (index < length - 1) ? this[index + 1] : null;
      current = this[index];
      next = (index > 0) ? this[index - 1] : null;
      if (current is UserMessage || current is AdminMessage) {
        list.add(
          MessageItem(
            key: Key(current.messageId.toString()),
            previous: previous,
            current: current,
            next: next,
          ),
        );
      } else if (current is FileMessage) {
        currentFileMessage = this[index] as FileMessage;
        if (currentFileMessage.url.isMedia() ||
            currentFileMessage.localFile?.path.isMedia() == true) {
          tempIndex = index;
          fileMessages = <FileMessage>[currentFileMessage];

          if (current.url.isPhoto() ||
              currentFileMessage.localFile?.path.isMedia() == true) {
            list.add(
              ImageMediaItem(
                key: Key(fileMessages.last.requestId.toString()),
                previous: (tempIndex < length) ? this[tempIndex] : null,
                list: fileMessages.reversed.toList(),
              ),
            );
          }
        } else {}
      }
    }
    return list;
  }

  List<Widget> getMediaMessageList() {
    List<BaseMessage> originList = <BaseMessage>[
      ...this,
    ]..retainWhere(
        (BaseMessage element) =>
            element is FileMessage && element.url.isMedia(),
      );
    final List<Widget> listWidget = <Widget>[];
    List<FileMessage> fileMessages = <FileMessage>[];
    final List<dynamic> items = <dynamic>[];
    FileMessage current;
    FileMessage? previous;
    if (originList.isNotEmpty) {
      items.add(
        (originList.first as FileMessage).createdAt.toReadableDateWeekTime(),
      );
    }
    for (int index = 0; index < originList.length; index++) {
      previous = (index < originList.length - 1)
          ? (originList[index + 1]) as FileMessage
          : null;
      current = originList[index] as FileMessage;

      fileMessages.add(current);

      if (!current.isSameDate(previous) && fileMessages.isNotEmpty) {
        items.add(fileMessages.toList());
        if (index < originList.length - 1) {
          items.add(
            (originList[index + 1] as FileMessage)
                .createdAt
                .toReadableDateWeekTime(),
          );
        }
        fileMessages = <FileMessage>[];
      }
    }
    if (fileMessages.isNotEmpty) {
      items.add(fileMessages.toList());
    }

    for (dynamic element in items) {
      if (element is String) {
        listWidget.add(
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              top: 16,
              bottom: 8,
            ),
            child: Text(
              element,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        );
      }
    }

    return listWidget;
  }

  int getImageSize() {
    if (length <= 1) return 500;
    if (length == 2) return 400;
    if (length == 3) return 300;
    return 200;
  }

  double getPadding() {
    if (length <= 1) return 40;
    if (length == 2) return 30;
    if (length == 3) return 20;
    return 20;
  }

  List<Map<String, dynamic>> toBaseMessageJsonList() {
    return map((BaseMessage e) => e.toBaseMessageJson()).toList();
  }
}
