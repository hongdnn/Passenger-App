import 'dart:io';

import 'package:passenger/features/sendbird_chat/data/model/sb_data_state.dart';
import 'package:passenger/features/sendbird_chat/data/repo/sendbird_chat_repository.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';

import 'datasource/sendbird_chat_remote_data_source.dart';

class SendbirdChatRepositoryImpl extends SendbirdChatRepository {
  SendbirdChatRepositoryImpl(
    this._sendbirdChatRemoteDataSource,
  );

  final SendbirdChatRemoteDataSource _sendbirdChatRemoteDataSource;

  @override
  Future<SBDataState<List<BaseMessage>>> loadMessages({
    required GroupChannel channel,
    required MessageListParams params,
    int? timestamp,
  }) async {
    return _sendbirdChatRemoteDataSource.loadMessages(
      channel,
      params,
      timestamp,
    );
    //     .then((value) {
    //   // TODO: check reload
    //   if (value.data != null) {
    //     _chatLocalDataSource.saveRecentChat(channel.channelUrl, value.data!);
    //   }
    //
    //   return value;
    // });
  }

  @override
  Future<SBDataState<UserMessage>> sendTextMessage({
    required GroupChannel channel,
    required String text,
    required void Function(UserMessage) success,
    required void Function(UserMessage) failure,
  }) async {
    return _sendbirdChatRemoteDataSource.sendTextMessage(
      channel,
      text,
      success,
      failure,
    );
  }

  @override
  Future<SBDataState<FileMessage>> sendFileMessage(
    GroupChannel channel,
    File file,
    void Function(FileMessage) success,
    void Function(int, int) progress,
    void Function(FileMessage) failure,
  ) async {
    return _sendbirdChatRemoteDataSource.sendFileMessage(
      channel,
      file,
      success,
      progress,
      failure,
    );
  }

  Future<SBDataState<List<GroupChannel>>> searchByGroupName(
    GroupChannelListQuery query,
    String keyword,
  ) {
    return _sendbirdChatRemoteDataSource.searchByGroupName(query, keyword);
  }
}
