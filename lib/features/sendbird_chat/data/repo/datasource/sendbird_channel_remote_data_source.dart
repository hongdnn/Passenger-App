// ignore_for_file: lines_longer_than_80_chars

import 'dart:convert';
import 'dart:io';

import 'package:passenger/core/app_config/env/logger_config.dart';
import 'package:passenger/core/extension/string_extension.dart';
import 'package:passenger/features/sendbird_chat/data/model/custom_data_channel_model.dart';
import 'package:passenger/features/sendbird_chat/data/model/sb_data_state.dart';
import 'package:passenger/features/sendbird_chat/data/util/sendbird_constant.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';

const String kPrivateChatCustomType = '1:1';
const String kGroupChatCustomType = 'N:N';

class SendbirdChannelRemoteDataSource {
  SendbirdChannelRemoteDataSource(this._sendbirdSdk);

  final SendbirdSdk _sendbirdSdk;

  /// Create or Get an existing 1-1 chat
  Future<SBDataState<GroupChannel>> createPrivateConversation(
    String id,
    CustomDataChannelModel? data,
  ) async {
    try {
      final List<String> userIds = <String>[
        _sendbirdSdk.currentUser!.userId,
        id,
      ];
      final GroupChannelParams params = GroupChannelParams()
        ..userIds = userIds
        ..isDistinct = true
        ..isPublic = false
        ..customType = kPrivateChatCustomType;
      if (data != null) params.data = jsonEncode(data);
      final GroupChannel newChannel = await GroupChannel.createChannel(params);

      logi(message: 'create conversation success with: $id', tag: 'Sendbird');
      return SBDataSuccess<GroupChannel>(newChannel);
    } on SBError catch (error) {
      return SBDataFailed<GroupChannel>(error);
    } catch (_) {
      return SBDataFailed<GroupChannel>(UnknownError());
    }
  }

  /// Create a group chat
  Future<SBDataState<GroupChannel>> createGroupChannel(
    List<String> userIds,
    String name,
    File? imageCover,
    CustomDataChannelModel? data,
  ) async {
    try {
      final GroupChannelParams params = GroupChannelParams()
        ..name = name
        ..userIds = userIds
        ..operatorUserIds = <String>[_sendbirdSdk.currentUser!.userId]
        ..customType = kGroupChatCustomType;
      if (imageCover != null) {
        params.coverImage = FileInfo.fromData(
          name: 'cover',
          file: imageCover,
          mimeType: 'image/jpeg',
        );
      } else {
        params.coverImage = FileInfo.fromUrl(
          url: '',
        );
      }
      if (data != null) params.data = jsonEncode(data);
      final GroupChannel newChannel = await GroupChannel.createChannel(params);
      // if (imageCoverUrl?.isEmptyOrNull() == false) {
      //   await newChannel.createMetaData(<String, String>{
      //     kSBGroupCoverMetaKey: imageCoverUrl!,
      //   });
      // }
      await newChannel.createMetaData(<String, String>{
        'user_id': userIds.toString(),
      });
      final UserMessageParams userMessageParams = UserMessageParams(
        message:
            '${_sendbirdSdk.currentUser?.nickname ?? 'someone'} added you into $name',
      )..customType = kMessageNotifyKey;
      newChannel.sendUserMessage(userMessageParams);
      return SBDataSuccess<GroupChannel>(newChannel);
    } on SBError catch (error) {
      return SBDataFailed<GroupChannel>(error);
    } catch (_) {
      return SBDataFailed<GroupChannel>(UnknownError());
    }
  }

  /// Update a group channel, include name, image cover url
  Future<SBDataState<bool>> updateGroupChannel(
    GroupChannel channel,
    File? imageCover,
    String? name,
    CustomDataChannelModel? data,
  ) async {
    try {
      final GroupChannelParams params = GroupChannelParams(isUpdate: true);
      if (!name.isNullOrEmpty()) {
        params.name = name;
      }
      if (imageCover != null) {
        params.coverImage = FileInfo.fromData(
          name: '${channel.key}cover',
          file: imageCover,
          mimeType: 'image/jpeg',
        );
      }
      if (data != null) params.data = jsonEncode(data);
      // if (imageCoverUrl.isEmptyOrNull() == false) {
      //   await channel.updateMetaData(<String, String>{
      //     kSBGroupCoverMetaKey: imageCoverUrl!,
      //   });
      // }
      await channel.updateChannel(params);
      // if (!name.isEmptyOrNull()) {
      //   final UserMessageParams userMessageParams = UserMessageParams(
      //     message:
      //         '${_sendbirdSdk.currentUser?.nickname ?? 'someone'} changed the group name into $name',
      //   )..customType = 'NOTIFY';
      // }
      return const SBDataSuccess<bool>(true);
    } on SBError catch (error) {
      return SBDataFailed<bool>(error);
    } catch (_) {
      return SBDataFailed<bool>(UnknownError());
    }
  }

  /// Leave a channel
  Future<SBDataState<bool>> leaveChannel(
    GroupChannel channel,
  ) async {
    try {
      await channel.leave();
      return const SBDataSuccess<bool>(true);
    } on SBError catch (error) {
      return SBDataFailed<bool>(error);
    } catch (_) {
      return SBDataFailed<bool>(UnknownError());
    }
  }

  /// Load group channels
  ///
  /// This is not return all the groups but by the limit per query that you've passes into [GroupChannelListQuery]
  Future<SBDataState<List<GroupChannel>>> loadGroupChannels(
    GroupChannelListQuery listQuery,
  ) async {
    try {
      final List<GroupChannel> listChannels = await listQuery.loadNext();
      return SBDataSuccess<List<GroupChannel>>(listChannels);
    } on SBError catch (error) {
      return SBDataFailed<List<GroupChannel>>(error);
    } catch (ee) {
      return SBDataFailed<List<GroupChannel>>(UnknownError());
    }
  }

  /// Mark that you have read a channel
  ///
  /// Should call when you open a channel
  Future<SBDataState<bool>> markChannelAsRead(
    GroupChannel channel,
  ) async {
    try {
      channel.markAsRead();
      return const SBDataSuccess<bool>(true);
    } on MarkAsReadRateLimitExceededError catch (e) {
      return SBDataFailed<bool>(e);
    } on SBError catch (error) {
      return SBDataFailed<bool>(error);
    } catch (_) {
      return SBDataFailed<bool>(UnknownError());
    }
  }

  /// Notify the channel that you are typing or not
  Future<SBDataState<bool>> changeTypingIndicator(
    GroupChannel channel,
    bool isTyping,
  ) async {
    try {
      isTyping ? channel.startTyping() : channel.endTyping();
      return const SBDataSuccess<bool>(true);
    } on SBError catch (error) {
      return SBDataFailed<bool>(error);
    } catch (_) {
      return SBDataFailed<bool>(UnknownError());
    }
  }

  /// Get total unread messages of all the channel
  Future<SBDataState<int>> retrieveTotalUnreadMessageNumber() async {
    try {
      int count = await _sendbirdSdk.getTotalUnreadMessageCount();
      return SBDataSuccess<int>(count);
    } on SBError catch (error) {
      return SBDataFailed<int>(error);
    } catch (_) {
      return SBDataFailed<int>(UnknownError());
    }
  }

  /// Invite more users to the channel
  Future<SBDataState<bool>> inviteUserToChannel(
    GroupChannel channel,
    List<String> userIds,
  ) async {
    try {
      await channel.inviteUsers(userIds);
      return const SBDataSuccess<bool>(true);
    } on SBError catch (error) {
      return SBDataFailed<bool>(error);
    } catch (_) {
      return SBDataFailed<bool>(UnknownError());
    }
  }
}
