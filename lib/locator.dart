import 'package:get_it/get_it.dart';
import 'package:task_dot_do/services/local_storage_service.dart';
import 'package:task_dot_do/viewmodels/add_task_viewmodel.dart';
import 'package:task_dot_do/viewmodels/base_landing_viewmodel.dart';
import 'package:task_dot_do/viewmodels/calender_viewmodel.dart';
import 'package:task_dot_do/viewmodels/groups_viewmodel.dart';
import 'package:task_dot_do/viewmodels/home_viewmodel.dart';
import 'package:task_dot_do/viewmodels/profile_viewmodel.dart';
import 'package:task_dot_do/viewmodels/login_viewmodel.dart';
import 'package:task_dot_do/viewmodels/startup_viewmodel.dart';

GetIt locator = GetIt.instance;

Future<void> setUpLocator() async {
  var localStorage = await LocalStorageService.getInstance();
  locator.registerSingleton<LocalStorageService>(localStorage);

  locator.registerFactory<BaseLandingViewmodel>(() => BaseLandingViewmodel());
  locator.registerFactory<StartUpViewModel>(() => StartUpViewModel());
  locator.registerFactory<LoginViewModel>(() => LoginViewModel());
  locator.registerFactory<HomeViewModel>(() => HomeViewModel());
  locator.registerFactory<ProfileViewModel>(() => ProfileViewModel());
  locator.registerFactory<CalenderViewModel>(() => CalenderViewModel());
  locator.registerFactory<GroupsViewModel>(() => GroupsViewModel());
  locator.registerFactory<AddTaskViewModel>(() => AddTaskViewModel());
  return;
}
