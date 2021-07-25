import 'package:flutter/cupertino.dart';
import 'package:task_dot_do/locator.dart';
import 'package:task_dot_do/services/local_storage_service.dart';

class BaseViewModel extends ChangeNotifier {
  final _localStorage = locator<LocalStorageService>();

  bool get isLoggedIn => _localStorage.isLoggedIn;

  set isLoggedIn(isLoggedIn) {
    _localStorage.isLoggedIn = isLoggedIn;
    notifyListeners();
  }
}
