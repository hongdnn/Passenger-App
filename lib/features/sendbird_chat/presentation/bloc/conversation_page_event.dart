part of 'conversation_page_bloc.dart';

@immutable
abstract class ConversationPageEvent {}

class InitializeChatEvent extends ConversationPageEvent {
  InitializeChatEvent({required this.driverId, this.initializeMessage});

  final String driverId;
  final String? initializeMessage;
}

class NewMessageReceivedEvent extends ConversationPageEvent {
  NewMessageReceivedEvent({
    required this.channel,
    required this.message,
  });

  final GroupChannel channel;
  final BaseMessage message;
}


class LoadPreviousMessageEvent extends ConversationPageEvent {}

class SendingMessageEvent extends ConversationPageEvent {
  SendingMessageEvent({required this.message});

  final String message;
}

class SendingFileEvent extends ConversationPageEvent {
  SendingFileEvent({required this.message});

  final List<File> message;
}

class RemoveMessageEvent extends ConversationPageEvent {
  RemoveMessageEvent({required this.messageId});

  final int messageId;
}

class RefreshMessageEvent extends ConversationPageEvent {
  RefreshMessageEvent();
}