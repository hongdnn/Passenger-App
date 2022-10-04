import 'dart:io';

import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/core/message/base_message.dart';
import 'package:sendbird_sdk/features/reaction/reaction.dart';

class MyMediaMessage extends BaseMessage {
  MyMediaMessage({
    int? messageId,
    String? requestId,
    MessageSendingStatus? sendingStatus,
    int? createdAt,
    required String channelUrl,
    required this.file,
    this.progress = 0,
    List<Reaction>? reactions,
  }) : super(
          messageId: messageId ?? 0,
          requestId: requestId,
          message: '',
          sendingStatus: sendingStatus,
          createdAt: createdAt ?? DateTime.now().millisecondsSinceEpoch,
          channelUrl: channelUrl,
          channelType: ChannelType.group,
          reactions: reactions,
        );
  final File file;
  final double progress;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'request_id': requestId,
        'message_id': messageId,
        'message': message,
        'sending_status': 'succeeded',
        'channel_url': channelUrl,
        'channel_type': 'group',
        'created_at': createdAt,
        'updated_at': updatedAt,
        'custom_type': customType,
        'message_survival_seconds': messageSurvivalSeconds,
        'force_update_last_message': forceUpdateLastMessage,
        'silent': isSilent,
        'error_code': errorCode,
        'is_op_msg': isOperatorMessage,
        'data': data,
        'og_tag': ogMetaData?.toJson(),
        'reactions': reactions?.map((Reaction e) => e.toJson()).toList(),
        'file': file.path,
        'progress': progress,
      };

  MyMediaMessage copyWith({
    int? messageId,
    String? requestId,
    MessageSendingStatus? sendingStatus,
    int? createdAt,
    String? channelUrl,
    File? file,
    double? progress = 0,
    List<Reaction>? reactions,
  }) {
    return MyMediaMessage(
      messageId: messageId ?? this.messageId,
      requestId: requestId ?? this.requestId,
      sendingStatus: sendingStatus ?? sendingStatus,
      createdAt: createdAt ?? this.createdAt,
      channelUrl: channelUrl ?? this.channelUrl,
      file: file ?? this.file,
      progress: progress ?? this.progress,
      reactions: reactions ?? this.reactions,
    );
  }
}
