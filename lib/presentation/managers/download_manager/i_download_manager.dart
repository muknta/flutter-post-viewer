import 'package:page_viewer/presentation/managers/download_manager/download_state.dart';

abstract class IDownloadManager {
  void download({required List<int> postIdList}) => throw UnimplementedError();

  /// Callback for discussion with outer classes
  Function(IDownloadState) get sendState;

  void dispose() => throw UnimplementedError();
}
