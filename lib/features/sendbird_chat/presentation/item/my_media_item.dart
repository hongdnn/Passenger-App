import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passenger/core/app_config/env/logger_config.dart';
import 'package:passenger/core/extension/int_extension.dart';
import 'package:passenger/core/extension/list_extension.dart';
import 'package:passenger/core/extension/sendbird_base_message_extension.dart';
import 'package:passenger/features/sendbird_chat/data/model/my_media_message.dart';
import 'package:passenger/features/sendbird_chat/presentation/view_photo_page.dart';
import 'package:passenger/util/assets.dart';
import 'package:passenger/util/size.dart';
import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/core/message/base_message.dart';

class MyMediaItem extends StatelessWidget {
  const MyMediaItem({
    Key? key,
    required this.list,
    this.previous,
  }) : super(key: key);
  final List<MyMediaMessage> list;
  final BaseMessage? previous;

  @override
  Widget build(BuildContext context) {

    logi(message: 'list.first.isMyMessage: ${list.first.isMyMessage}');

    return Column(
      children: <Widget>[
        Visibility(
          visible: !list.last.isSameDate(previous) &&
              !list.first.isSameDate(previous),
          child: _buildDateWidget(),
        ),
        SizedBox(height: 20.h),
        list.first.isMyMessage
            ? _buildRightImageWidget(context)
            : _buildLeftImageWidget(context),
      ],
    );
  }

  Widget _buildRightImageWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          SizedBox(
            width: 204.w,
            height: 204.h,
            child: _buildImageMessageWidget(
              context: context,
              e: list.first,
              imageSize: list.getImageSize(),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              _buildSendStatusWidget(),
              const SizedBox(width: 4),
              _buildDateSentWidget()
            ],
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }

  Widget _buildLeftImageWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 204.w,
            height: 204.h,
            child: _buildImageMessageWidget(
              context: context,
              e: list.first,
              imageSize: list.getImageSize(),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _buildSendStatusWidget(),
              const SizedBox(width: 4),
              _buildDateSentWidget()
            ],
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }

  Widget _buildSendStatusWidget() {
    switch (list.first.sendingStatus) {
      case MessageSendingStatus.pending:
        return const SizedBox(
          height: 14,
          width: 14,
          child: FittedBox(
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: Colors.blue,
            ),
          ),
        );
      case MessageSendingStatus.failed:
        return SizedBox(
          height: 20,
          width: 20,
          child: FittedBox(
            child: SvgPicture.asset(SvgAssets.icRetry),
          ),
        );
      default:
        return Container();
    }
  }

  Widget _buildImageMessageWidget({
    required BuildContext context,
    required MyMediaMessage e,
    int? imageSize,
  }) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          ViewPhotoPage.routeName,
          arguments: ViewPhotoPageArg(file: e.file),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Stack(
          children: <Widget>[
            Image(
              image: FileImage(e.file),
              alignment: Alignment.center,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: (e.progress == 1.0)
                      ? Colors.transparent
                      : Colors.black.withOpacity(0.5),
                ),
                child: Visibility(
                  visible: e.progress != 1,
                  child: Padding(
                    padding: EdgeInsets.all(list.getPadding()),
                    child: FittedBox(
                      child: CircularProgressIndicator(
                        value: e.progress,
                        color: Colors.white,
                        strokeWidth: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSentWidget() {
    final String time = list.last.createdAt.toTimeInDay();
    return Text(
      time,
      style: const TextStyle(color: Colors.grey),
    );
  }

  Widget _buildDateWidget() {
    final String date = list.first.createdAt.toReadableDateWeekTime();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 40,
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            date,
          ),
        ],
      ),
    );
  }
}
