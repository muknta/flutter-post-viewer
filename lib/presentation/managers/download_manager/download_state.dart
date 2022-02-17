import 'package:equatable/equatable.dart';

abstract class IDownloadState extends Equatable {
  const IDownloadState();

  @override
  List<Object?> get props => const [];
}

class DownloadInitialState extends IDownloadState {
  const DownloadInitialState();
}

class DownloadingState extends IDownloadState {
  const DownloadingState();
}

class DownloadErrorState extends IDownloadState {
  const DownloadErrorState();
}

class DownloadDoneState extends IDownloadState {
  const DownloadDoneState();
}
