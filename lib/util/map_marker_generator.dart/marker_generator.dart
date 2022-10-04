import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

import 'package:passenger/util/size.dart';

class MarkerGenerator {
  MarkerGenerator(this.markerWidgets, this.callback);
  final Function(List<Uint8List>) callback;
  final List<Widget> markerWidgets;

  void generate(BuildContext context) {
    afterFirstLayout(context);
  }

  void afterFirstLayout(BuildContext context) {
    addOverlay(context);
  }

  void addOverlay(BuildContext context) {
    OverlayState? overlayState = Overlay.of(context);

    OverlayEntry? entry;
    entry = OverlayEntry(
      builder: (BuildContext context) {
        return _MarkerHelper(
          markerWidgets: markerWidgets,
          callback: (List<Uint8List> bitmapList) {
            // Given callback function
            callback.call(bitmapList);

            // Remove marker widget stack from Overlay when finished
            entry?.remove();
          },
        );
      },
      maintainState: true,
    );

    overlayState?.insert(entry);
  }
}

class _MarkerHelper extends StatefulWidget {
  const _MarkerHelper({
    Key? key,
    required this.markerWidgets,
    required this.callback,
  }) : super(key: key);
  final List<Widget> markerWidgets;
  final Function(List<Uint8List>) callback;

  @override
  _MarkerHelperState createState() => _MarkerHelperState();
}

class _MarkerHelperState extends State<_MarkerHelper>
    with AfterLayoutMixin<_MarkerHelper> {
  List<GlobalKey> globalKeys = <GlobalKey>[];

  @override
  void afterFirstLayout(BuildContext context) {
    _getBitmaps(context).then((List<Uint8List> list) {
      widget.callback(list);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(ScreenSize.width, 0),
      child: Material(
        type: MaterialType.transparency,
        child: Stack(
          children: widget.markerWidgets.map((Widget i) {
            final GlobalKey<State<StatefulWidget>> markerKey = GlobalKey();
            globalKeys.add(markerKey);
            return RepaintBoundary(
              key: markerKey,
              child: i,
            );
          }).toList(),
        ),
      ),
    );
  }

  Future<List<Uint8List>> _getBitmaps(BuildContext context) async {
    Iterable<Future<Uint8List>> futures = globalKeys
        .map((GlobalKey<State<StatefulWidget>> key) => _getUint8List(key));
    return Future.wait(futures);
  }

  Future<Uint8List> _getUint8List(GlobalKey markerKey) async {
    RenderRepaintBoundary? boundary =
        markerKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    ui.Image? image = await boundary?.toImage(pixelRatio: 3.0);
    ByteData? byteData =
        await image?.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }
}

mixin AfterLayoutMixin<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => afterFirstLayout(context));
  }

  void afterFirstLayout(BuildContext context);
}
