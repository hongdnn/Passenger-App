import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';

// 700ms is a rough estimate, no concrete evidence to based this on
const Duration googleMapPageBackDelay = Duration(milliseconds: 700);

// On Android: Page with GoogleMap might crashes when Page is popped
// https://issuehint.com/issue/flutter/flutter/105965
mixin AndroidGoogleMapsBackMixin<T extends StatefulWidget> on State<T> {
  Timer? _timer;
  bool _canGoBack = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _timer = Timer(googleMapPageBackDelay, () {
        _canGoBack = true;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void popBack(BuildContext ctx) async {
    _doActionIfCanBack(
      action: () {
        Navigator.of(ctx).pop();
      },
    );
  }

  void popBackUntil(BuildContext ctx, RoutePredicate predicate) {
    _doActionIfCanBack(
      action: () {
        Navigator.of(ctx).popUntil(predicate);
      },
    );
  }

  void _doActionIfCanBack({required Function action}) async {
    if (!_canGoBack && Platform.isAndroid) {
      await Future<void>.delayed(googleMapPageBackDelay, () {
        action();
      });
    } else {
      action();
    }
  }
}
