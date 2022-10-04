import 'dart:io';

import 'package:passenger/features/sendbird_chat/data/model/custom_data_channel_model.dart';
import 'package:passenger/features/sendbird_chat/data/model/sb_data_state.dart';
import 'package:passenger/features/sendbird_chat/data/repo/sendbird_channel_repository.dart';
import 'package:sendbird_sdk/core/channel/group/group_channel.dart';
import 'package:sendbird_sdk/query/channel_list/group_channel_list_query.dart';

import 'datasource/sendbird_channel_remote_data_source.dart';

class SendbirdChannelRepositoryImpl extends SendbirdChannelRepository {
  SendbirdChannelRepositoryImpl(
    this._channelRemoteDataSource,
  );

  final SendbirdChannelRemoteDataSource _channelRemoteDataSource;

  @override
  Future<SBDataState<GroupChannel>> createPrivateConversation({
    required String id,
    CustomDataChannelModel? data,
  }) async {
    return _channelRemoteDataSource.createPrivateConversation(
      id,
      data,
    );
  }

  @override
  Future<SBDataState<GroupChannel>> createGroupChannel(
    List<String> userIds,
    String name,
    File? imageCover,
    CustomDataChannelModel? data,
  ) async {
    return _channelRemoteDataSource.createGroupChannel(
      userIds,
      name,
      imageCover,
      data,
    );
  }

  @override
  Future<SBDataState<bool>> updateGroupChannel(
    GroupChannel channel,
    File? imageCover,
    String? name,
    CustomDataChannelModel? data,
  ) async {
    return _channelRemoteDataSource.updateGroupChannel(
      channel,
      imageCover,
      name,
      data,
    );
  }

  @override
  Future<SBDataState<bool>> leaveChannel(
    GroupChannel channel,
  ) async {
    return _channelRemoteDataSource.leaveChannel(channel);
  }

  /// Currently only saves the first page in the database to reduce
  ///
  /// complexity of paging and stuffs, improve latter
  @override
  Future<SBDataState<List<GroupChannel>>> loadRemoteGroupChannels(
    GroupChannelListQuery listQuery,
  ) async {
    return _channelRemoteDataSource.loadGroupChannels(listQuery);
    //     .then((SBDataState<List<GroupChannel>> value) {
    //   if (value is SBDataSuccess && isReload) {
    //     _channelLocalDataSource.saveRecentGroupChannels(value.data ?? []);
    //   }
    //
    //   return value;
    // });
  }

  @override
  Future<SBDataState<bool>> markChannelAsRead(
    GroupChannel channel,
  ) async {
    return _channelRemoteDataSource.markChannelAsRead(channel);
  }

  @override
  Future<SBDataState<bool>> changeTypingIndicator(
    GroupChannel channel,
    bool isTyping,
  ) async {
    return _channelRemoteDataSource.changeTypingIndicator(
      channel,
      isTyping,
    );
  }

  @override
  Future<SBDataState<int>> retrieveTotalUnreadMessageNumber() async {
    return _channelRemoteDataSource.retrieveTotalUnreadMessageNumber();
  }

  @override
  Future<SBDataState<bool>> inviteUserToChannel(
    GroupChannel channel,
    List<String> userIds,
  ) async {
    return _channelRemoteDataSource.inviteUserToChannel(
      channel,
      userIds,
    );
  }
}
