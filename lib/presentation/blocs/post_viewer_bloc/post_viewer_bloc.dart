import 'package:page_viewer/presentation/mixins/bloc_stream_mixin.dart';
import 'package:rxdart/rxdart.dart';

part 'post_viewer_event.dart';
part 'post_viewer_state.dart';

class PostViewerBloc with BlocStreamMixin {
  PostViewerBloc() {
    _eventController.listen(handleEvent);
  }

  final _eventController = BehaviorSubject<PostViewerEvent>();
  Stream<PostViewerEvent> get eventStream => _eventController.stream;
  Function(PostViewerEvent) get addEvent => sinkAdd(_eventController);

  void handleEvent(PostViewerEvent event) {
    if (event is LoadPostsEvent) {
      // TODO: implement
    } else if (event is OpenPostEvent) {
      // TODO: implement
    }
  }

  @override
  void dispose() {
    if (isStreamNotClosed(_eventController)) {
      _eventController.close();
    }
  }
}
