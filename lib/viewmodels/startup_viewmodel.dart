import 'package:get/get.dart';
import 'package:task_dot_do/locator.dart';
import 'package:task_dot_do/services/local_storage_service.dart';
import 'package:task_dot_do/ui/base_landing_view.dart';
import 'package:task_dot_do/ui/home_view.dart';
import 'package:task_dot_do/ui/login_view.dart';
import 'package:task_dot_do/viewmodels/base_viewmodel.dart';

class StartUpViewModel extends BaseViewModel {
  LocalStorageService localStorageService = locator<LocalStorageService>();

  void onModelReady() async {
    await Future.delayed(
      Duration(seconds: 2),
    );
    await Get.offAllNamed(
      localStorageService.isLoggedIn ? BaseLandingView.id : LoginView.id,
    );
  }
}
