import 'package:passenger/util/enum.dart';

extension LoadStateExtension on LoadState {
  bool get isFinished => this == LoadState.success || this == LoadState.failure;
}
