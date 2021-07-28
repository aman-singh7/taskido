import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task_dot_do/locator.dart';
import 'package:task_dot_do/models/task_model.dart';
import 'package:task_dot_do/viewmodels/base_landing_viewmodel.dart';
import 'package:task_dot_do/viewmodels/base_viewmodel.dart';

class CalenderViewModel extends BaseViewModel {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focussedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  BaseLandingViewmodel baseLandingViewModel = locator<BaseLandingViewmodel>();
  late final ScrollController _scrollController;

  ScrollController get scrollController => _scrollController;
  CalendarFormat get calendarFormat => _calendarFormat;
  DateTime get focussedDay => _focussedDay;
  DateTime get selectedDay => _selectedDay;
  List<Task> get tasksOnSelectedDay => getTasksForDay(selectedDay);

  set focussedDay(DateTime focussedDay) {
    _focussedDay = focussedDay;
    notifyListeners();
  }

  set selectedDay(DateTime selectedDay) {
    _selectedDay = selectedDay;
    notifyListeners();
  }

  set calendarFormat(CalendarFormat calendarFormat) {
    _calendarFormat = calendarFormat;
    notifyListeners();
  }

  void onModelReady() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (baseLandingViewModel.isVisible) {
          baseLandingViewModel.isVisible = false;
          print(baseLandingViewModel.isVisible);
          notifyListeners();
        }
      }
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!baseLandingViewModel.isVisible) {
          baseLandingViewModel.isVisible = true;
          print(baseLandingViewModel.isVisible);
          notifyListeners();
        }
      }
    });
  }

  void onModelDestroy() {
    scrollController.dispose();
  }
}
