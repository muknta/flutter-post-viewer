import 'package:get_it/get_it.dart';
import 'package:page_viewer/internal/navigation/navigation.dart';

GetIt locator = GetIt.instance;

void setupLocators() {
  locator.registerLazySingleton(() => NavigationService());
}
