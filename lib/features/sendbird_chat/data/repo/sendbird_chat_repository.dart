import 'dart:io';

import 'package:passenger/features/sendbird_chat/data/model/sb_data_state.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';

abstract class SendbirdChatRepository {
  Future<SBDataState<List<BaseMessage>>> loadMessages({
    required GroupChannel channel,
    required MessageListParams params,
    int? timestamp,
  });

  Future<SBDataState<UserMessage>> sendTextMessage({required
   GroupChannel channel,
    required  String text,
    required void Function(UserMessage) success,
    required  void Function(UserMessage) failure,
  });

  Future<SBDataState<FileMessage>> sendFileMessage(
    GroupChannel channel,
    File file,
    void Function(FileMessage) success,
    void Function(int, int) progress,
    void Function(FileMessage) failure,
  );
}
