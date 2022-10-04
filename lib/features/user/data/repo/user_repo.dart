import 'package:passenger/core/util/data_state.dart';
import 'package:passenger/features/user/data/model/upsert_fcm_token_model.dart';
import 'package:passenger/features/user/data/model/user.dart';

abstract class UserRepo {
  User getCurrentUser();
  Future<void> saveUser();

  Future<DataState<FcmTokenModel>> upsertFCMToken({
    required String fcmToken,
  });
}
