import 'package:get_it/get_it.dart';
import 'package:passenger/features/sendbird_chat/data/repo/datasource/sendbird_auth_remote_data_source.dart';
import 'package:passenger/features/sendbird_chat/data/repo/datasource/sendbird_channel_remote_data_source.dart';
import 'package:passenger/features/sendbird_chat/data/repo/datasource/sendbird_chat_remote_data_source.dart';

class DatasourceRegister {
  DatasourceRegister._();

  static Future<void> init(GetIt injector) async {
    injector.registerSingleton<SendbirdChannelRemoteDataSource>(
      SendbirdChannelRemoteDataSource(injector()),
    );
    injector.registerSingleton<SendbirdAuthRemoteDataSource>(
      SendbirdAuthRemoteDataSource(injector(),),
    );
    injector.registerSingleton<SendbirdChatRemoteDataSource>(
      SendbirdChatRemoteDataSource(injector()),
    );

  }
}
