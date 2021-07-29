import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task_dot_do/locator.dart';
import 'package:task_dot_do/models/task_model.dart';
import 'package:task_dot_do/services/Database_service.dart';
import 'package:task_dot_do/services/local_storage_service.dart';

class BaseViewModel extends ChangeNotifier {
  final _localStorage = locator<LocalStorageService>();
  final databaseService = locator<DatabaseService>();

  bool get isLoggedIn => _localStorage.isLoggedIn;

  set isLoggedIn(isLoggedIn) {
    _localStorage.isLoggedIn = isLoggedIn;
    notifyListeners();
  }

  LinkedHashMap<DateTime,
      List<Task>> events = LinkedHashMap<DateTime, List<Task>>(
    equals: isSameDay,
    hashCode: (DateTime day) => day.year + day.month * 10000 + day.day * 100000,
  )..addAll(
      {}); // add tasks from database service to it using databaseService.getTaskMap();

  List<Task> getTasksForDay(DateTime day) {
    return events[day] ?? [];
  }
}
