import 'package:logger/logger.dart';

final Logger _logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    lineLength: 80,
  ),
);

void Function(String) get logInDebug => _logger.d;
