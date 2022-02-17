import 'dart:isolate';

import 'package:page_viewer/data/models/remote_models/loading_models/loading_query_models/i_loading_query_model.dart';
import 'package:page_viewer/data/models/remote_models/loading_models/loading_response_models/i_loading_response_model.dart';

abstract class IIsolateManager {
  Future<void> startLoading(
    ILoadingQueryModel model, {
    SendPort customPort,
  });

  Stream<ILoadingResponseModel> get taskListener;

  List<ILoadingResponseModel> get taskList;

  void killTaskById(int id);

  void dispose();
}
