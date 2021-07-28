import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task_dot_do/locator.dart';
import 'package:task_dot_do/models/task_model.dart';
import 'package:task_dot_do/services/local_storage_service.dart';

class BaseViewModel extends ChangeNotifier {
  final _localStorage = locator<LocalStorageService>();

  bool get isLoggedIn => _localStorage.isLoggedIn;

  set isLoggedIn(isLoggedIn) {
    _localStorage.isLoggedIn = isLoggedIn;
    notifyListeners();
  }

  LinkedHashMap<DateTime, List<Task>> events =
      LinkedHashMap<DateTime, List<Task>>(
    equals: isSameDay,
    hashCode: (DateTime day) => day.year + day.month * 10000 + day.day * 100000,
  )..addAll(
          {
            DateTime.now(): [
              Task(
                title: 'Complete Maths Assignment',
                notifyMe: true,
                isCompleted: true,
                from: 'Somewhere',
              ),
              Task(
                title: 'Walking',
                notifyMe: false,
                isCompleted: false,
                from: 'Somewhere',
              ),
              Task(
                title: 'Complete Maths Assignment',
                notifyMe: true,
                isCompleted: true,
                from: 'Somewhere',
              ),
              Task(
                title: 'Walking',
                notifyMe: false,
                isCompleted: false,
                from: 'Somewhere',
              ),
              Task(
                title: 'Complete Maths Assignment',
                notifyMe: true,
                isCompleted: true,
                from: 'Somewhere',
              ),
              Task(
                title: 'Walking',
                notifyMe: false,
                isCompleted: false,
                from: 'Somewhere',
              ),
              Task(
                title: 'Complete Maths Assignment',
                notifyMe: true,
                isCompleted: true,
                from: 'Somewhere',
              ),
              Task(
                title: 'Walking',
                notifyMe: false,
                isCompleted: false,
                from: 'Somewhere',
              ),
              Task(
                title: 'Complete Maths Assignment',
                notifyMe: true,
                isCompleted: true,
                from: 'Somewhere',
              ),
              Task(
                title: 'Walking',
                notifyMe: false,
                isCompleted: false,
                from: 'Somewhere',
              ),
            ]
          },
        );

  List<Task> getTasksForDay(DateTime day) {
    return events[day] ?? [];
  }
}
