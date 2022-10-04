import 'dart:io';

import 'package:passenger/core/app_config/env/logger_config.dart';
import 'package:passenger/features/sendbird_chat/data/model/sb_data_state.dart';
import 'package:passenger/features/sendbird_chat/data/util/sendbird_constant.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';

class SendbirdChatRemoteDataSource {
  SendbirdChatRemoteDataSource(this._sendbirdSdk);

  final SendbirdSdk _sendbirdSdk;

  /// Load messages in a group
  ///
  /// Return the messages from a specific timestamp
  Future<SBDataState<List<BaseMessage>>> loadMessages(
    GroupChannel channel,
    MessageListParams params,
    int? timestamp,
  ) async {
    try {
      final List<BaseMessage> messages = await channel.getMessagesByTimestamp(
        timestamp ?? DateTime.now().millisecondsSinceEpoch,
        params,
      );
      return SBDataSuccess<List<BaseMessage>>(messages);
    } on SBError catch (error) {
      _sendbirdSdk.toString();
      return SBDataFailed<List<BaseMessage>>(error);
    } catch (_) {
      return SBDataFailed<List<BaseMessage>>(UnknownError());
    }
  }

  Future<SBDataState<UserMessage>> sendTextMessage(
    GroupChannel channel,
    String text,
    void Function(UserMessage) success,
    void Function(UserMessage) failure,
  ) async {
    try {
      final UserMessageParams params = UserMessageParams(
        message: text,
        customType: kMessageNormalKey,
      );
      final UserMessage res = channel.sendUserMessage(
        params,
        onCompleted: (UserMessage msg, Error? error) {
          (error != null) ? failure.call(msg) : success.call(msg);
        },
      );
      return SBDataSuccess<UserMessage>(res);
    } on SBError catch (error) {
      return SBDataFailed<UserMessage>(error);
    } catch (_) {
      return SBDataFailed<UserMessage>(UnknownError());
    }
  }

  Future<SBDataState<FileMessage>> sendFileMessage(
    GroupChannel channel,
    File file,
    void Function(FileMessage) success,
    void Function(int, int) progress,
    void Function(FileMessage) failure,
  ) async {
    try {
      logi(message: file.path);
      final FileMessageParams params = FileMessageParams.withFile(
        file,
        name: file.path,
      );
      final FileMessage res = channel.sendFileMessage(
        params,
        onCompleted: (
          FileMessage msg,
          Error? error,
        ) {
          (error != null) ? failure.call(msg) : success.call(msg);
        },
        progress: (
          int sentBytes,
          int totalBytes,
        ) {
          progress.call(sentBytes, totalBytes);
        },
      );
      return SBDataSuccess<FileMessage>(res);
    } on SBError catch (error) {
      return SBDataFailed<FileMessage>(error);
    } catch (_) {
      return SBDataFailed<FileMessage>(UnknownError());
    }
  }

  Future<SBDataState<List<GroupChannel>>> searchByGroupName(
    GroupChannelListQuery query,
    String keyword,
  ) async {
    try {
      final List<GroupChannel> result = await query.loadNext();
      return SBDataSuccess<List<GroupChannel>>(result);
    } on SBError catch (error) {
      return SBDataFailed<List<GroupChannel>>(error);
    } catch (_) {
      return SBDataFailed<List<GroupChannel>>(UnknownError());
    }
  }
}
