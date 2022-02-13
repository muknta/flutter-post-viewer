import 'package:logger/logger.dart';

final Logger _logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    lineLength: 80,
  ),
);

void Function(String message) get logInDebug => _logger.d;

void Function(
  String message, [
  dynamic error,
  StackTrace? stackTrace,
]) get logError => _logger.e;
