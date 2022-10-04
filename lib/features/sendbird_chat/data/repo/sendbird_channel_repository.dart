import 'dart:io';

import 'package:passenger/features/sendbird_chat/data/model/custom_data_channel_model.dart';
import 'package:passenger/features/sendbird_chat/data/model/sb_data_state.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';

abstract class SendbirdChannelRepository {
  Future<SBDataState<GroupChannel>> createPrivateConversation({
    required String id,
    CustomDataChannelModel? data,
  });

  Future<SBDataState<GroupChannel>> createGroupChannel(
    List<String> userIds,
    String name,
    File? imageCover,
    CustomDataChannelModel? data,
  );

  Future<SBDataState<bool>> updateGroupChannel(
    GroupChannel channel,
    File? imageCover,
    String? name,
    CustomDataChannelModel? data,
  );

  Future<SBDataState<bool>> leaveChannel(
    GroupChannel channel,
  );

  Future<SBDataState<List<GroupChannel>>> loadRemoteGroupChannels(
    GroupChannelListQuery listQuery,
  );

  Future<SBDataState<bool>> markChannelAsRead(
    GroupChannel channel,
  );

  Future<SBDataState<bool>> changeTypingIndicator(
    GroupChannel channel,
    bool isTyping,
  );

  Future<SBDataState<int>> retrieveTotalUnreadMessageNumber();

  Future<SBDataState<bool>> inviteUserToChannel(
    GroupChannel channel,
    List<String> userIds,
  );
}
