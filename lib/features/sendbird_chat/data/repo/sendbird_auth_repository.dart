
import 'package:passenger/features/sendbird_chat/data/model/sb_data_state.dart';

abstract class SendbirdAuthRepository {
  Future<SBDataState<bool>> connectToSendbird(
    String? userId,
    String? avatarUrl,
    String? nickname,
  );

  Future<SBDataState<bool>> signOutOfSendbird();

  Future<SBDataState<bool>> updateSendbirdUser(
    String? username,
    String? avatarUrl,
  );
}
