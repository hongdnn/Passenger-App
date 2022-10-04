part of 'conversation_page_bloc.dart';

enum ConversationPageStatus {
  initial,
  connectingToSendbird,
  connectSendbirdSuccessfully,
  connectSendbirdFail,
  initializingConversation,
  initConversationSuccess,
  loadingAllMessages,
  loadingAllMessagesSuccess,
  loadingAllMessagesFail,
  initConversationFail,
  newMessageReceived,
}

@immutable
class ConversationPageState {
  const ConversationPageState({
    this.status = ConversationPageStatus.initial,
    this.listMessage = const <BaseMessage>[],
  });

  final ConversationPageStatus status;
  final List<BaseMessage> listMessage;

  ConversationPageState copyWith({
    required ConversationPageStatus status,
    List<BaseMessage>? listMessage,
  }) {
    return ConversationPageState(
      status: status,
      listMessage: listMessage ?? this.listMessage,
    );
  }

  static const ConversationPageState init = ConversationPageState();
}
