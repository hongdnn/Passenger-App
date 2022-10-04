import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:passenger/core/app_config/env/logger_config.dart';
import 'package:passenger/core/app_config/get_it/getit_config.dart';
import 'package:passenger/features/sendbird_chat/data/model/sb_data_state.dart';
import 'package:passenger/features/sendbird_chat/data/repo/sendbird_auth_repository.dart';
import 'package:passenger/features/sendbird_chat/data/repo/sendbird_channel_repository.dart';
import 'package:passenger/features/sendbird_chat/data/repo/sendbird_chat_repository.dart';
import 'package:passenger/features/sendbird_chat/data/util/sendbird_constant.dart';
import 'package:passenger/features/user/data/repo/user_repo.dart';
import 'package:passenger/util/util.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';

part 'conversation_page_event.dart';

part 'conversation_page_state.dart';

class ConversationPageBloc
    extends Bloc<ConversationPageEvent, ConversationPageState>
    with ConnectionEventHandler, UserEventHandler, ChannelEventHandler {
  ConversationPageBloc() : super(ConversationPageState.init) {
    initSendbirdEvent();
    on<InitializeChatEvent>(_onInitialEvent);
    on<NewMessageReceivedEvent>(_onNewMessageReceived);
    on<SendingMessageEvent>(_onSendMessage);
    on<SendingFileEvent>(_onSendFile);
    on<LoadPreviousMessageEvent>(
      _onLoadPreviousMessage,
      transformer: debounce(
        const Duration(milliseconds: 3000),
      ),
    );
    on<RemoveMessageEvent>(_onRemoveMessage);
    on<RefreshMessageEvent>(_onRefresh);
  }

  GroupChannel? groupChannel;
  MessageListParams params = MessageListParams()
    ..isInclusive = false
    ..includeThreadInfo = true
    ..reverse = true
    ..previousResultSize = 30
    ..includeReactions = true;

  void initSendbirdEvent() {
    getIt<SendbirdSdk>().addChannelEventHandler(
      kConversationEventHandlerIdentifier,
      this,
    );
  }

  @override
  void onMessageReceived(BaseChannel channel, BaseMessage message) {
    if (channel is GroupChannel) {
      add(
        NewMessageReceivedEvent(
          channel: channel,
          message: message,
        ),
      );
    }
  }

  Future<void> _onNewMessageReceived(
    NewMessageReceivedEvent event,
    Emitter<ConversationPageState> emit,
  ) async {
    if (groupChannel?.key == event.channel.key) {
      List<BaseMessage> newList = <BaseMessage>[];
      final int index = state.listMessage.indexWhere(
        (BaseMessage element) => event.message.requestId == element.requestId,
      );
      if (index == -1) {
        newList = <BaseMessage>[
          ...state.listMessage,
        ]
          ..insert(
            0,
            event.message,
          )
          ..sort(
            (BaseMessage a, BaseMessage b) =>
                -a.createdAt.compareTo(b.createdAt),
          );
      } else {
        newList = <BaseMessage>[
          ...state.listMessage
            ..removeAt(index)
            ..insert(
              index,
              event.message,
            ),
        ];
      }

      emit(
        state.copyWith(
          status: ConversationPageStatus.newMessageReceived,
          listMessage: newList,
        ),
      );
    }
  }

  Future<void> _onRemoveMessage(
    RemoveMessageEvent event,
    Emitter<ConversationPageState> emit,
  ) async {
    List<BaseMessage> newList = <BaseMessage>[];
    final int index = state.listMessage.indexWhere(
      (BaseMessage element) => event.messageId == element.messageId,
    );
    newList = <BaseMessage>[
      ...state.listMessage,
    ]
      ..removeAt(index)
      ..sort(
        (BaseMessage a, BaseMessage b) => -a.createdAt.compareTo(b.createdAt),
      );

    emit(
      state.copyWith(
        status: ConversationPageStatus.newMessageReceived,
        listMessage: newList,
      ),
    );
  }

  Future<void> _loadAllMessages(
    Emitter<ConversationPageState> emit,
    GroupChannel channel,
  ) async {
    emit(
      state.copyWith(
        status: ConversationPageStatus.loadingAllMessages,
      ),
    );
    final List<BaseMessage> list = state.listMessage;
    final int? timestamp = list.isEmpty ? null : list.last.createdAt;

    final SBDataState<List<BaseMessage>> response =
        await getIt<SendbirdChatRepository>().loadMessages(
      channel: channel,
      params: params,
      timestamp: timestamp,
    );
    if (response.error != null &&
        response.error?.code != ErrorCode.queryInProgress) {
      // emit(
      //   state.copyWith(
      //     status: ConversationStatus.unknownError,
      //   ),
      // );
      return;
    } else if (response.data != null) {
      final List<BaseMessage> newMessages = <BaseMessage>[
        ...list,
        ...response.data!,
      ];

      emit(
        state.copyWith(
          status: ConversationPageStatus.loadingAllMessagesSuccess,
          listMessage: newMessages,
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        status: ConversationPageStatus.loadingAllMessagesFail,
      ),
    );
  }

  FutureOr<void> _onInitialEvent(
    InitializeChatEvent event,
    Emitter<ConversationPageState> emit,
  ) async {
    emit(
      state.copyWith(
        status: ConversationPageStatus.connectingToSendbird,
      ),
    );

    final SBDataState<bool> sendbirdConnectResult =
        await getIt<SendbirdAuthRepository>().connectToSendbird(
      getIt<UserRepo>().getCurrentUser().id,
      // 'demoDriverId',
      'myAvatarUrl',
      'myNickname',
    );

    if (sendbirdConnectResult.error != null) {
      loge(
        message: sendbirdConnectResult.error.toString(),
      );
      emit(
        state.copyWith(
          status: ConversationPageStatus.connectSendbirdFail,
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        status: ConversationPageStatus.initializingConversation,
      ),
    );
    final String driverId = event.driverId;

    final SBDataState<GroupChannel> channelDataState =
        await getIt<SendbirdChannelRepository>()
            .createPrivateConversation(id: driverId);

    if (channelDataState.error != null) {
      emit(
        state.copyWith(
          status: ConversationPageStatus.initConversationFail,
        ),
      );
      return;
    }
    if (channelDataState.data != null) {
      groupChannel = channelDataState.data;

      if (event.initializeMessage != null) {
        await getIt<SendbirdChatRepository>().sendTextMessage(
          channel: groupChannel!,
          text: event.initializeMessage!,
          success: (UserMessage userMessage) {
            add(RefreshMessageEvent());
          },
          failure: (UserMessage message) {
            add(RefreshMessageEvent());
          },
        );
      } else {
        await _loadAllMessages(emit, groupChannel!);
      }

      return;
    }

    // getIt<SendbirdSdk>()
    //   ..addUserEventHandler(
    //     kMainUserEventHandlerIdentifier,
    //     this,
    //   )
    //   ..addConnectionEventHandler(
    //     kMainConnectionHandlerIdentifier,
    //     this,
    //   );
  }

// @override
// Future<void> close() {
//   getIt<SendbirdSdk>()
//     ..removeUserEventHandler(
//       kMainUserEventHandlerIdentifier,
//     )
//     ..removeConnectionEventHandler(
//       kMainConnectionHandlerIdentifier,
//     );
//   return super.close();
// }

  FutureOr<void> _onSendMessage(
    SendingMessageEvent event,
    Emitter<ConversationPageState> emit,
  ) async {
    if (groupChannel == null) {
      return;
    }
    final String msg = event.message;
    logi(message: 'sending msg');
    await getIt<SendbirdChatRepository>().sendTextMessage(
      channel: groupChannel!,
      text: msg,
      success: (UserMessage message) {
        add(NewMessageReceivedEvent(channel: groupChannel!, message: message));
        logi(message: 'send msg success');
      },
      failure: (UserMessage message) {
        logi(message: 'send msg fail');
        add(
          NewMessageReceivedEvent(
            channel: groupChannel!,
            message: message
              ..sendingStatus = MessageSendingStatus.failed
              ..sender = Sender(
                userId: getIt<UserRepo>().getCurrentUser().id,
                nickname: '',
              ),
          ),
        );
      },
    );
  }

  FutureOr<void> _onLoadPreviousMessage(
    LoadPreviousMessageEvent event,
    Emitter<ConversationPageState> emit,
  ) async {
    await _loadAllMessages(emit, groupChannel!);
  }

  FutureOr<void> _onSendFile(
    SendingFileEvent event,
    Emitter<ConversationPageState> emit,
  ) async {
    for (File file in event.message) {
      final SBDataState<FileMessage> response =
          await getIt<SendbirdChatRepository>().sendFileMessage(
        groupChannel!,
        file,
        (FileMessage success) {
          logi(message: 'send file success');
          // final MyMediaMessage myMedia = MyMediaMessage(
          //   requestId: DateTime
          //       .now()
          //       .microsecondsSinceEpoch
          //       .toString(),
          //   channelUrl: success.channelUrl,
          //   file: file,
          //   sendingStatus: MessageSendingStatus.succeeded,
          //   progress: 1.0,
          // );
          add(
            NewMessageReceivedEvent(
              channel: groupChannel!,
              message: success
                ..sendingStatus = MessageSendingStatus.succeeded
                ..localFile = file,
            ),
          );
        },
        (int p0, int p1) {},
        (FileMessage failure) {
          logi(message: 'send file failure ${failure.message}');
        },
      );
      final FileMessage? fileMessage = response.data;
      add(
        NewMessageReceivedEvent(
          channel: groupChannel!,
          message: fileMessage!..localFile = file,
        ),
      );
    }
  }

  FutureOr<void> _onRefresh(
    RefreshMessageEvent event,
    Emitter<ConversationPageState> emit,
  ) async {
    await _loadAllMessages(emit, groupChannel!);
  }
}
