import 'package:task_dot_do/viewmodels/base_viewmodel.dart';

class RoutineNavDialogViewModel extends BaseViewModel {
  final List<String> _days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thrusday',
    'Friday',
    'Saturday',
  ];
  late String _day;

  List<String> get days => _days;
  String get day => _day;

  void onChanged(String? value) {
    _day = value!;
    notifyListeners();
  }

  void onModelReady() {
    _day = days[0];
  }
}
