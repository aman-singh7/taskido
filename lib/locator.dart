import 'package:get_it/get_it.dart';
import 'package:task_dot_do/viewmodels/home_viewmodel.dart';

GetIt locator = GetIt.instance;

Future<void> setUpLocator() async {
  locator.registerFactory<HomeViewmodel>(() => HomeViewmodel());
  return;
}
