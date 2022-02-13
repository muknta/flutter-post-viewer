import 'package:dio/dio.dart';

/// dio errors is not extending dart Exception/Error
///
/// https://github.com/flutterchina/dio/issues/1228
class DioErrorInterceptor extends Interceptor {
  @override
  // ignore: avoid_renaming_method_parameters
  Future onError(DioError dioError, ErrorInterceptorHandler handler) {
    super.onError(dioError, handler);
    return Future.value(dioError);
  }
}
