enum LoadingStatus {
  prepare,
  loading,
  success,
  error,
}

bool loadingStatusIsError(LoadingStatus status) => status == LoadingStatus.error;

bool loadingStatusIsSuccess(LoadingStatus status) => status == LoadingStatus.success;
