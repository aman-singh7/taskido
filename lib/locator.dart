import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:task_dot_do/services/databases_service.dart';
import 'package:task_dot_do/services/dialog_service.dart';
import 'package:task_dot_do/services/firebase_auth_service.dart';
import 'package:task_dot_do/services/group_service.dart';
import 'package:task_dot_do/services/local_storage_service.dart';
import 'package:task_dot_do/services/particular_group_service.dart';
import 'package:task_dot_do/services/profile_service.dart';
import 'package:task_dot_do/services/push_notification.dart';
import 'package:task_dot_do/services/routine_service.dart';
import 'package:task_dot_do/viewmodels/add_task_viewmodel.dart';
import 'package:task_dot_do/viewmodels/base_landing_viewmodel.dart';
import 'package:task_dot_do/viewmodels/calender_viewmodel.dart';
import 'package:task_dot_do/viewmodels/groups_viewmodel.dart';
import 'package:task_dot_do/viewmodels/home_viewmodel.dart';
import 'package:task_dot_do/viewmodels/particular_group_viewmodel.dart';
import 'package:task_dot_do/viewmodels/profile_viewmodel.dart';
import 'package:task_dot_do/viewmodels/login_viewmodel.dart';
import 'package:task_dot_do/viewmodels/register_viewmodel.dart';
import 'package:task_dot_do/viewmodels/routine_input_dialog_viewmodel.dart';
import 'package:task_dot_do/viewmodels/routine_nav_dialog_viewmodel.dart';
import 'package:task_dot_do/viewmodels/routine_viewmodel.dart';
import 'package:task_dot_do/viewmodels/startup_viewmodel.dart';

GetIt locator = GetIt.instance;

Future<void> setUpLocator() async {
  var localStorage = await LocalStorageService.getInstance();
  locator.registerSingleton<LocalStorageService>(localStorage);
  var _firebaseAuth = FirebaseAuth.instance;
  locator.registerSingleton<FirebaseAuth>(_firebaseAuth);
  var _firebaseFirestore = FirebaseFirestore.instance;
  locator.registerSingleton<FirebaseFirestore>(_firebaseFirestore);
  var _firebaseAuthService = FirebaseAuthService();
  locator.registerSingleton<FirebaseAuthService>(_firebaseAuthService);
  var databaseService = DatabaseService();
  locator.registerSingleton<DatabaseService>(databaseService);
  var homeView = HomeViewModel();
  locator.registerSingleton<HomeViewModel>(homeView);
  var baseLandingView = BaseLandingViewmodel();
  locator.registerSingleton<BaseLandingViewmodel>(baseLandingView);
  var groupService = GroupService();
  locator.registerSingleton<GroupService>(groupService);
  var profileService = ProfileService();
  locator.registerSingleton<ProfileService>(profileService);
  var pushNotification = PushNotification();
  locator.registerSingleton<PushNotification>(pushNotification);
  var groupViewModel = GroupsViewModel();
  locator.registerSingleton<GroupsViewModel>(groupViewModel);
  var particularGroupService = ParticularGroupService();
  locator.registerSingleton<ParticularGroupService>(particularGroupService);
  var routineService = RoutineService();
  locator.registerSingleton<RoutineService>(routineService);

  locator.registerFactory<DialogService>(() => DialogService());
  //locator.registerFactory<BaseLandingViewmodel>(() => BaseLandingViewmodel());
  locator.registerFactory<StartUpViewModel>(() => StartUpViewModel());
  locator.registerFactory<LoginViewModel>(() => LoginViewModel());
  locator.registerFactory<RegisterViewModel>(() => RegisterViewModel());
  //locator.registerFactory<HomeViewModel>(() => HomeViewModel());
  locator.registerFactory<ProfileViewModel>(() => ProfileViewModel());
  locator.registerFactory<CalenderViewModel>(() => CalenderViewModel());
  //locator.registerFactory<GroupsViewModel>(() => GroupsViewModel());
  locator.registerFactory<AddTaskViewModel>(() => AddTaskViewModel());
  locator.registerFactory<ParticularGroupViewModel>(
      () => ParticularGroupViewModel());
  locator.registerFactory<RoutineNavDialogViewModel>(
      () => RoutineNavDialogViewModel());
  locator.registerFactory<RoutineViewModel>(() => RoutineViewModel());
  locator.registerFactory<RoutineInputDialogViewModel>(
      () => RoutineInputDialogViewModel());
  return;
}
