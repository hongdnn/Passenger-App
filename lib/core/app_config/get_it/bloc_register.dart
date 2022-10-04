import 'package:get_it/get_it.dart';
import 'package:passenger/features/sendbird_chat/presentation/bloc/conversation_page_bloc.dart';

class BlocRegister {
  BlocRegister._();

  static Future<void> init(GetIt injector) async {
    injector.registerFactory<ConversationPageBloc>(
      () => ConversationPageBloc(),
    );
  }
}
