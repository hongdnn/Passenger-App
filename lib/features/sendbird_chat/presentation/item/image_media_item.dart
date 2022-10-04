import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passenger/core/extension/int_extension.dart';
import 'package:passenger/core/extension/list_extension.dart';
import 'package:passenger/core/extension/sendbird_base_message_extension.dart';
import 'package:passenger/core/extension/string_extension.dart';
import 'package:passenger/features/sendbird_chat/presentation/view_photo_page.dart';
import 'package:passenger/util/assets.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/styles.dart';
import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/core/message/base_message.dart';
import 'package:sendbird_sdk/core/message/file_message.dart';

class ImageMediaItem extends StatefulWidget {
  const ImageMediaItem({
    Key? key,
    required this.list,
    this.previous,
  }) : super(key: key);
  final List<FileMessage> list;
  final BaseMessage? previous;

  @override
  State<ImageMediaItem> createState() => _ImageMediaItemState();
}

class _ImageMediaItemState extends State<ImageMediaItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Visibility(
          visible: !widget.list.last.isSameDate(widget.previous) &&
              !widget.list.first.isSameDate(widget.previous),
          child: _buildDateWidget(),
        ),
        SizedBox(height: 20.h),
        widget.list.first.isMyMessage
            ? _buildRightImageWidget(context)
            : _buildLeftImageWidget(
                context,
              ),
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
              e: widget.list.first,
              imageSize: widget.list.getImageSize(),
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              _buildSendStatusWidget(),
              SizedBox(width: 4.w),
              _buildDateSentWidget()
            ],
          ),
          SizedBox(height: 4.h),
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
              e: widget.list.first,
              imageSize: widget.list.getImageSize(),
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _buildSendStatusWidget(),
              SizedBox(width: 4.w),
              _buildDateSentWidget()
            ],
          ),
          SizedBox(height: 4.h),
        ],
      ),
    );
  }

  Widget _buildSendStatusWidget() {
    switch (widget.list.first.sendingStatus) {
      case MessageSendingStatus.pending:
        return SizedBox(
          height: 14.h,
          width: 14.w,
          child: const FittedBox(
            child: CupertinoActivityIndicator(
              color: Colors.blue,
            ),
          ),
        );
      case MessageSendingStatus.failed:
        return SizedBox(
          height: 20.h,
          width: 20.w,
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
    required FileMessage e,
    int? imageSize,
  }) {
    return InkWell(
      onTap: () {},
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Stack(
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  ViewPhotoPage.routeName,
                  arguments: ViewPhotoPageArg(imageUrl: e.secureUrl ?? e.url),
                );
              },
              child: (e.localFile?.path.isMedia() == true)
                  ? Image.file(
                      e.localFile!,
                      alignment: Alignment.center,
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : CachedNetworkImage(
                      imageUrl: e.secureUrl ?? e.url,
                      alignment: Alignment.center,
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) {
                        return const SizedBox(
                          height: double.infinity,
                          width: double.infinity,
                          child: Icon(
                            Icons.image,
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSentWidget() {
    final String time = widget.list.last.createdAt.toTimeInDay();
    return Text(
      time,
      style: StylesConstant.ts14w400cFFABADBA,
    );
  }

  Widget _buildDateWidget() {
    final String date = widget.list.first.createdAt.toReadableDateWeekTime();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 30.h,
          ),
          Text(
            date,
            style: StylesConstant.ts14w400cFFABADBA,
          ),
        ],
      ),
    );
  }
}
