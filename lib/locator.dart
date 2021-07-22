import 'package:get_it/get_it.dart';
import 'package:task_dot_do/services/local_storage_service.dart';
import 'package:task_dot_do/viewmodels/home_viewmodel.dart';

GetIt locator = GetIt.instance;

Future<void> setUpLocator() async {
  locator.registerFactory<HomeViewmodel>(() => HomeViewmodel());
  var localStorage = await LocalStorageService.getInstance();
  locator.registerSingleton<LocalStorageService>(localStorage);
  return;
}
