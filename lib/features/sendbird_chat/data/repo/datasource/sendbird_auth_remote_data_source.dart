import 'dart:io';

import 'package:passenger/core/app_config/env/logger_config.dart';
import 'package:passenger/core/extension/string_extension.dart';
import 'package:passenger/features/sendbird_chat/data/model/sb_data_state.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';

class SendbirdAuthRemoteDataSource {
  SendbirdAuthRemoteDataSource(
    this._sendbirdSdk,
  );

  final SendbirdSdk _sendbirdSdk;

  Future<SBDataState<bool>> connectToSendbird(
    String? userId,
    String? avatarUrl,
    String? nickname,
  ) async {
    try {
      bool isReconnect = false;
      if (_sendbirdSdk.currentUser == null ||
          _sendbirdSdk.getConnectionState() == ConnectionState.closed) {
        isReconnect = _sendbirdSdk.reconnect();
      }
      String? id = userId;
      if (!isReconnect) {
        if (userId.isNullOrEmpty()) {}
        if (!id.isNullOrEmpty()) {
          await _sendbirdSdk.connect(
            id!,
            nickname: nickname,
          );
          if (!avatarUrl.isNullOrEmpty()) {
            updateSendbirdUser(
              null,
              avatarUrl,
            );
          }
          const String token = 'getIt<AppUser>().remoteMessageToken';
          // if (Platform.isIOS) {
          //   token = await FirebaseMessaging.instance.getAPNSToken();
          // } else {
          //   token = await FirebaseMessaging.instance.getToken();
          // }
          if (!token.isNullOrEmpty()) {
            await _sendbirdSdk.registerPushToken(
              // type:PushTokenType.fcm,
              type: Platform.isIOS ? PushTokenType.apns : PushTokenType.fcm,
              token: token,
              alwaysPush: true,
            );
            await _sendbirdSdk.setPushTemplate('default');
            await _sendbirdSdk.setPushTriggerOption(PushTriggerOption.all);
          }
          // if (avatarUrl?.isEmptyOrNull() == false) {
          //   user.createMetaData(<String, String>{
          //     kSBAvatarMetaKey: avatarUrl!,
          //   });
          // }
        } else {
          return SBDataFailed<bool>(
            SBError(
              message: 'The ID to connect to Sendbird cannot be empty!',
            ),
          );
        }
      }
      logi(
        message: 'Connect to Sendbird success with ID: $id',
        tag: 'Sendbird',
      );
      return const SBDataSuccess<bool>(true);
    } on SBError catch (error) {
      return SBDataFailed<bool>(error);
    } catch (_) {
      return SBDataFailed<bool>(UnknownError());
    }
  }

  Future<SBDataState<bool>> signOutOfSendbird() async {
    try {
      const String token = 'getIt<AppUser>().remoteMessageToken';
      if (!token.isNullOrEmpty()) {
        await _sendbirdSdk.unregisterPushToken(
          type: Platform.isIOS ? PushTokenType.apns : PushTokenType.fcm,
          token: token,
        );
      }
      await _sendbirdSdk.disconnect();
      return const SBDataSuccess<bool>(true);
    } on SBError catch (error) {
      return SBDataFailed<bool>(error);
    } catch (_) {
      return SBDataFailed<bool>(UnknownError());
    }
  }

  Future<SBDataState<bool>> updateSendbirdUser(
    String? nickname,
    String? avatarUrl,
  ) async {
    try {
      await _sendbirdSdk.updateCurrentUserInfo(
        nickname: nickname,
        fileInfo: FileInfo.fromUrl(
          url: avatarUrl,
          fileSize: 100,
        ),
      );
      // if (avatarUrl != null) {
      //   _sendbirdSdk.currentUser?.updateMetaData(<String, String>{
      //     kSBAvatarMetaKey: avatarUrl!,
      //   });
      // }
      return const SBDataSuccess<bool>(true);
    } on SBError catch (error) {
      return SBDataFailed<bool>(error);
    } catch (_) {
      return SBDataFailed<bool>(UnknownError());
    }
  }
}
