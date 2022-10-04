
import 'package:passenger/core/app_config/get_it/getit_config.dart';
import 'package:passenger/core/extension/datetime_extensions.dart';
import 'package:passenger/features/sendbird_chat/data/util/sendbird_constant.dart';
import 'package:passenger/features/user/data/repo/user_repo.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';




extension BaseMessageX on BaseMessage {
  bool get isMyMessage =>
      sender?.userId == getIt<UserRepo>().getCurrentUser().id;

  bool isSameDate(BaseMessage? b) {
    if (b == null) return false;
    if (b.customType == kMessageNotifyKey) return false;
    final DateTime aTime = DateTime.fromMillisecondsSinceEpoch(createdAt);
    final DateTime bTime = DateTime.fromMillisecondsSinceEpoch(b.createdAt);

    return aTime.isSameDate(bTime);
  }

  bool isSendAtSameMinute(BaseMessage? b) {
    if (b == null) return false;
    if (sender?.userId != b.sender?.userId) return false;

    final DateTime aTime = DateTime.fromMillisecondsSinceEpoch(createdAt);
    final DateTime bTime = DateTime.fromMillisecondsSinceEpoch(b.createdAt);
    return aTime.isSendAtSameMinute(bTime);
  }

  bool isSameUser(BaseMessage? b) {
    if (b == null) return false;
    return sender?.userId == b.sender?.userId;
  }



  Map<String, dynamic> toBaseMessageJson() {
    String type = 'MESG';
    if (this is UserMessage) {
      type = 'MESG';
    } else if (this is FileMessage) {
      type = 'FILE';
    } else if (this is AdminMessage) {
      type = 'ADMM';
    }
    // else if (this is MyMediaMessage) {
    //   type = 'MYMEDIA';
    // }
    return toJson()..addAll(<String, dynamic>{'type': type});
  }
}

extension FileMessageX on FileMessage {
  bool get isMyMessage =>
      sender?.userId == getIt<UserRepo>().getCurrentUser().id;

  bool isSameDate(BaseMessage? b) {
    if (b == null) return false;
    final DateTime aTime = DateTime.fromMillisecondsSinceEpoch(createdAt);
    final DateTime bTime = DateTime.fromMillisecondsSinceEpoch(b.createdAt);

    return aTime.isSameDate(bTime);
  }

  bool isSendAtSameMinute(BaseMessage? b) {
    if (b == null) return false;
    if (sender?.userId != b.sender?.userId) return false;

    final DateTime aTime = DateTime.fromMillisecondsSinceEpoch(createdAt);
    final DateTime bTime = DateTime.fromMillisecondsSinceEpoch(b.createdAt);
    return aTime.isSendAtSameMinute(bTime);
  }

  bool isSameUser(BaseMessage? b) {
    if (b == null) return false;
    return sender?.userId == b.sender?.userId;
  }
}
