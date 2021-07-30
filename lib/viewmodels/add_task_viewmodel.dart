import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_dot_do/validators.dart';
import 'package:task_dot_do/viewmodels/base_viewmodel.dart';

class AddTaskViewModel extends BaseViewModel {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late bool notifyMe;
  late DateTime _dateTime;

  TextEditingController get titleController => _titleController;
  TextEditingController get descriptionController => _descriptionController;
  DateTime get dateTime => _dateTime;
  String? Function(String?) get tfValidator => Validator.validateTextField;

  void onChanged(bool val) {
    notifyMe = val;
    notifyListeners();
  }

  void dateUpdated(DateTime val) {
    _dateTime = val;
    notifyListeners();
  }

  void timeUpdated(TimeOfDay time) {
    _dateTime = DateTime(
      _dateTime.year,
      _dateTime.month,
      _dateTime.day,
      time.hour,
      time.minute,
    );
    notifyListeners();
  }

  void onModelReady() {
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    notifyMe = false;
    _dateTime = DateTime.now();
  }

  void onModelDestroy() {
    _titleController.dispose();
    _descriptionController.dispose();
  }
}
