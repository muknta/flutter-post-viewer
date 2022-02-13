import 'dart:async';

import 'package:page_viewer/internal/logger.dart';
import 'package:rxdart/rxdart.dart';

mixin BlocStreamMixin<T> {
  Function(T) sinkAdd(StreamController<T>? streamController) => streamController?.isClosed ?? true
      ? (_) {
          assert(streamController != null, 'streamController is NULL / ControllerHelperMixin addFunction');
          logInDebug('${streamController.toString()} is Closed');
        }
      : streamController!.sink.add;

  bool isStreamNotClosed(Subject streamController) => !streamController.isClosed;
  bool isStreamHasValue(BehaviorSubject streamController) => !streamController.isClosed && streamController.hasValue;

  void dispose();
}
