import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:page_viewer/internal/locator.config.dart';

final locator = GetIt.instance;

@injectableInit
void setupLocators() {
  $initGetIt(locator);
}
