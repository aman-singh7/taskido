import 'package:get/get.dart';
import 'package:task_dot_do/locator.dart';
import 'package:task_dot_do/models/person_model.dart';
import 'package:task_dot_do/services/local_storage_service.dart';
import 'package:task_dot_do/services/profile_service.dart';
import 'package:task_dot_do/ui/login_view.dart';
import 'package:task_dot_do/viewmodels/base_viewmodel.dart';

class ProfileViewModel extends BaseViewModel {
  final profileService = locator<ProfileService>();
  final localStorage = locator<LocalStorageService>();
  late Person _person;

  Person get person => _person;

  void fetchInfo() async {
    var person = await profileService.getInformation();
    if (person != null) _person = person;
    notifyListeners();
  }

  void logout() {
    localStorage.isLoggedIn = false;
    Get.offAllNamed(LoginView.id);
  }

  void onModelReady() {
    _person = Person(
      email: 'Email',
      name: 'Name',
      phone: 'Phone',
      enrollment: 'Enrollment',
    );
    fetchInfo();
  }
}
