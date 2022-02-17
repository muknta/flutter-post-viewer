import 'dart:isolate';

import 'package:page_viewer/data/models/remote_models/loading_models/loading_query_models/i_loading_query_model.dart';
import 'package:page_viewer/data/models/remote_models/loading_models/loading_status.dart';
import 'package:page_viewer/presentation/managers/download_manager/i_isolate_manager.dart';

abstract class ISingleTaskDownloader<Q extends ILoadingQueryModel> {
  /// Обробник завдань завантаження в ізолятах
  IIsolateManager get isolateManager;

  /// Містить необхідну інформацію для завантаження, а також індифікатор. Наприклад, якому рівневі, блокові чи юніту належить завантаження
  Q get queryModel;

  bool _loading = false;

  /// Починає завантаження
  Future<void> startLoading() async {
    print('startLoading single task');
    if (!_loading) {
      _loading = true;

      print('startLoading AFTER IF single task');
      await isolateManager.startLoading(
        queryModel,
        customPort: responsePort.sendPort,
      );
    }
  }

  /// Порт для отримання стану із завдання ізолята
  ReceivePort get responsePort;

  /// Обробляє response з isolateTasks
  Future<void> responseHandler(dynamic response);

  /// Генератор статусу для спілкування із зовнішнім клієнтом
  Stream<LoadingStatus> get statusStream;

  void dispose() => throw UnimplementedError();
}
