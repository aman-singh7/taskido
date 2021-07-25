import 'package:intl/intl.dart';
import 'package:task_dot_do/models/date_model.dart';
import 'package:task_dot_do/models/task_model.dart';
import 'package:task_dot_do/viewmodels/base_viewmodel.dart';

class HomeViewModel extends BaseViewModel {
  late List<DayDate> _dates;
  late List<Task> _tasks;
  late int _activeDayTab;

  List<DayDate> get dates => _dates;
  List<Task> get tasks => _tasks;
  int get activeDayTab => _activeDayTab;

  void buildDates(DateTime date) {
    var prev, next, tempdate, tempday;
    switch (_dates[0].day) {
      case 'Monday':
        prev = 0;
        next = 5;
        break;
      case 'Tuesday':
        prev = 1;
        next = 4;
        break;
      case 'Wednesday':
        prev = 2;
        next = 3;
        break;
      case 'Thrushday':
        prev = 3;
        next = 2;
        break;
      case 'Friday':
        prev = 4;
        next = 1;
        break;
      case 'Saturday':
        prev = 5;
        next = 0;
        break;
      case 'Sunday':
        prev = 0;
        next = 5;
        break;
    }

    for (var i = 1; i <= prev; i++) {
      tempdate = date.subtract(Duration(days: i));
      tempday = DateFormat('EEEE').format(tempdate);
      _dates.insert(
        0,
        DayDate(date: tempdate.day, month: tempdate.month, day: tempday),
      );
    }

    for (var i = 1; i <= next; i++) {
      tempdate = date.add(Duration(days: i));
      tempday = DateFormat('EEEE').format(tempdate);
      var length = _dates.length;
      _dates.insert(
        length,
        DayDate(date: tempdate.day, month: tempdate.month, day: tempday),
      );
    }
  }

  void buildTask() {
    var date = DateTime.now();
    var time = DateFormat.jm().format(date);
    _tasks = [];
    _tasks.addAll(
      [
        Task(
          title: 'Complete Maths Assignment',
          notifyMe: true,
          isCompleted: true,
          from: time,
        ),
        Task(
          title: 'Walking',
          notifyMe: false,
          isCompleted: false,
          from: time,
        ),
      ],
    );
  }

  void isTaskCompleted(bool val, int index) {
    _tasks[index].isCompleted = val;
    notifyListeners();
  }

  void deleteTask(int index) {
    _tasks.removeAt(index);
    notifyListeners();
  }

  void changeTab(int index) {
    _activeDayTab = index;
    notifyListeners();
  }

  void onModelReady() {
    var date = DateTime.now();
    var day = DateFormat('EEEE').format(date);
    _dates = [];
    _dates.add(DayDate(date: date.day, month: date.month, day: day));
    buildDates(date);
    _activeDayTab = 0;
    buildTask();
  }
}
