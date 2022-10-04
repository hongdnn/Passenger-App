import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:images_picker/images_picker.dart';
import 'package:passenger/core/app_config/env/logger_config.dart';
import 'package:passenger/core/app_config/get_it/getit_config.dart';
import 'package:passenger/core/extension/list_extension.dart';
import 'package:passenger/features/sendbird_chat/presentation/bloc/conversation_page_bloc.dart';
import 'package:passenger/util/assets.dart';
import 'package:passenger/util/styles.dart';

import 'message_input_widget.dart';

// for demo purpose
const String demoDriverId = 'demoDriverId';
const String demoDriverName = 'Peter Parker';
const String demoUserId = 'demoUserId';

class ConversationArg {
  ConversationArg({
    required this.driverId,
    required this.driverName,
    this.initializeMessage,
  });

  final String driverId;
  final String driverName;
  final String? initializeMessage;
}

class ConversationPage extends StatelessWidget {
  const ConversationPage({Key? key, required this.arg}) : super(key: key);

  final ConversationArg arg;
  static const String routeName = '/conversationPage';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ConversationPageBloc>(
      create: (_) => getIt<ConversationPageBloc>()
        ..add(
          InitializeChatEvent(
            driverId: arg.driverId,
            initializeMessage: arg.initializeMessage,
          ),
        ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(arg.driverName, style: StylesConstant.ts16w400,),
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: SvgPicture.asset(SvgAssets.icCall),
            )
          ],
        ),
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: const _ConversationBody(),
        ),
      ),
    );
  }
}

class _ConversationBody extends StatefulWidget {
  const _ConversationBody({Key? key}) : super(key: key);

  @override
  State<_ConversationBody> createState() => _ConversationBodyState();
}

class _ConversationBodyState extends State<_ConversationBody> {
  final ScrollController lstController = ScrollController();

  @override
  void initState() {
    lstController.addListener(_scrollListener);
    super.initState();
  }

  Future<List<File>?> _getImage() async {
    final List<Media>? medias = await ImagesPicker.pick(count: 1);
    if (medias != null) {
      return medias.map((Media media) => File(media.path)).toList();
    } else {
      return null;
    }
  }

  Future<List<File>?> _openCameraAndGetImage() async {
    final List<Media>? medias = await ImagesPicker.openCamera();
    if (medias != null) {
      return medias.map((Media media) => File(media.path)).toList();
    } else {
      return null;
    }
  }

  void _scrollListener() {
    if (lstController.offset >= lstController.position.maxScrollExtent &&
        !lstController.position.outOfRange &&
        context.read<ConversationPageBloc>().params.previousResultSize > 0) {
      context.read<ConversationPageBloc>().add(LoadPreviousMessageEvent());
    }
    if (lstController.offset <= lstController.position.minScrollExtent &&
        !lstController.position.outOfRange) {
      // reach bottom
    }
  }

  Widget _buildMessageListWidget(ConversationPageState state) {
    List<Widget> list = <Widget>[
      ...state.listMessage.getMessageItemList(
          // unreadMessageCount: 10,
          ),
    ];
    if (state.status == ConversationPageStatus.loadingAllMessages ||
        state.status == ConversationPageStatus.initializingConversation ||
        state.status == ConversationPageStatus.connectingToSendbird) {
      return const CupertinoActivityIndicator();
    }

    return Expanded(
      child: ListView.builder(
        itemCount: list.length,
        reverse: true,
        physics: const AlwaysScrollableScrollPhysics(),
        controller: lstController,
        itemBuilder: (_, int index) {
          return list[index];
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConversationPageBloc, ConversationPageState>(
      builder: (BuildContext context, ConversationPageState state) {
        logi(message: '${state.listMessage}');

        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            _buildMessageListWidget(state),
            _buildMessageInputWidget(context),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    lstController.dispose();
    super.dispose();
  }

  Widget _buildMessageInputWidget(BuildContext context) {
    return MessageInputWidget(
      onChanged: (String text) {},
      onPressSend: (String text) {
        context
            .read<ConversationPageBloc>()
            .add(SendingMessageEvent(message: text));
      },
      onPressAddMedia: () async {
        List<File>? files = await _getImage();
        if (!mounted) return;

        if (files != null) {
          _sendMediaMessage(context, files);
        }
      },
      onPressCamera: () async {
        List<File>? files = await _openCameraAndGetImage();
        if (!mounted) return;

        if (files != null) {
          _sendMediaMessage(context, files);
        }
      },
    );
  }

  void _sendMediaMessage(BuildContext context, List<File> files) {
    context.read<ConversationPageBloc>().add(SendingFileEvent(message: files));
  }
}
