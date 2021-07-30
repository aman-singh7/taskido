import 'package:flutter/material.dart';
import 'package:task_dot_do/validators.dart';
import 'package:task_dot_do/viewmodels/base_viewmodel.dart';

class RoutineInputDialogViewModel extends BaseViewModel {
  late DateTime _from;
  late DateTime _to;
  late TextEditingController _nameController;
  late TextEditingController _remarkController;

  TextEditingController get nameController => _nameController;
  TextEditingController get remarkController => _remarkController;
  String? Function(String?) get validator => Validator.validateTextField;
  DateTime get from => _from;
  DateTime get to => _to;

  void setTime(TimeOfDay time, String command) {
    switch (command) {
      case 'from':
        _from = DateTime(
          _from.year,
          _from.month,
          _from.day,
          time.hour,
          time.minute,
        );
        _to = _from.add(const Duration(hours: 1));
        break;
      case 'to':
        _to = DateTime(
          _to.year,
          _to.month,
          _to.day,
          time.hour,
          time.minute,
        );
        break;
    }
    notifyListeners();
  }

  void onModelDestroy() {
    _nameController.dispose();
    _remarkController.dispose();
  }

  void onModelReady() {
    _nameController = TextEditingController();
    _remarkController = TextEditingController();
    _from = DateTime.now();
    _to = _from.add(const Duration(hours: 1));
  }
}
