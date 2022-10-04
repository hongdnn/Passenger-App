import 'dart:developer';

import 'package:passenger/core/network/rh_base_api.dart';
import 'package:passenger/core/util/data_state.dart';
import 'package:passenger/features/sendbird_chat/presentation/conversation_page.dart';
import 'package:passenger/features/user/data/model/upsert_fcm_token_model.dart';
import 'package:passenger/features/user/data/model/user.dart';
import 'package:passenger/features/user/data/repo/user_repo.dart';
import 'package:platform_device_id/platform_device_id.dart';

User user = User(id: demoUserId, nickname: '', deviceId: '');

class UserRepoImpl extends UserRepo {
  UserRepoImpl(this._rhBaseApi);

  final RhBaseApi _rhBaseApi;
  @override
  User getCurrentUser() {
    return user;
  }

  @override
  Future<void> saveUser() async {
    log('saveUser');
    String deviceId = await PlatformDeviceId.getDeviceId ?? '';
    user = User(id: deviceId, deviceId: deviceId, nickname: '');
    return;
  }

  @override
  Future<DataState<FcmTokenModel>> upsertFCMToken({
    required String fcmToken,
  }) async {
    try {
      FcmTokenModel fcmTokenModel = await _rhBaseApi.upsertFCMToken(
        fcmTokenResponse: FcmTokenResponse(
          deviceId: getCurrentUser().deviceId,
          userId: getCurrentUser().id,
          token: fcmToken,
        ),
      );
      return DataSuccess<FcmTokenModel>(fcmTokenModel);
    } on Exception catch (e) {
      return DataFailed<FcmTokenModel>(e);
    }
  }
}
