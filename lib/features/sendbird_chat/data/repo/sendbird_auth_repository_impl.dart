
import 'package:passenger/features/sendbird_chat/data/model/sb_data_state.dart';
import 'package:passenger/features/sendbird_chat/data/repo/sendbird_auth_repository.dart';

import 'datasource/sendbird_auth_remote_data_source.dart';


class SendbirdAuthRepositoryImpl extends SendbirdAuthRepository {
  SendbirdAuthRepositoryImpl(this._authRemoteDataSource);

  final SendbirdAuthRemoteDataSource _authRemoteDataSource;

  @override
  Future<SBDataState<bool>> connectToSendbird(
    String? userId,
    String? avatarUrl,
    String? nickname,
  ) async {
    return _authRemoteDataSource.connectToSendbird(
      userId,
      avatarUrl,
      nickname,
    );
  }

  @override
  Future<SBDataState<bool>> signOutOfSendbird() async {
    return _authRemoteDataSource.signOutOfSendbird();
  }

  @override
  Future<SBDataState<bool>> updateSendbirdUser(
    String? username,
    String? avatarUrl,
  ) async {
    return _authRemoteDataSource.updateSendbirdUser(username, avatarUrl);
  }
}
