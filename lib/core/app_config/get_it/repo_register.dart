import 'package:get_it/get_it.dart';
import 'package:passenger/features/sendbird_chat/data/repo/sendbird_auth_repository.dart';
import 'package:passenger/features/sendbird_chat/data/repo/sendbird_auth_repository_impl.dart';
import 'package:passenger/features/sendbird_chat/data/repo/sendbird_channel_repository.dart';
import 'package:passenger/features/sendbird_chat/data/repo/sendbird_channel_repository_impl.dart';
import 'package:passenger/features/sendbird_chat/data/repo/sendbird_chat_repository.dart';
import 'package:passenger/features/sendbird_chat/data/repo/sendbird_chat_repository_impl.dart';

class RepoRegister {
  RepoRegister._();

  static Future<void> init(GetIt injector) async {
    injector.registerFactory<SendbirdAuthRepository>(
      () => SendbirdAuthRepositoryImpl(injector()),
    );
    injector.registerFactory<SendbirdChannelRepository>(
      () => SendbirdChannelRepositoryImpl(injector()),
    );
    injector.registerFactory<SendbirdChatRepository>(
      () => SendbirdChatRepositoryImpl(injector()),
    );

  }
}
