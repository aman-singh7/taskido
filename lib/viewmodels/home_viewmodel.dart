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
  DayDate get selectedDay => dates[activeDayTab];
  DateTime get selectedDate =>
      DateTime(selectedDay.year, selectedDay.month, selectedDay.date);
  Stream<List<Task>> get tasksForSelectedDate => _tasksForSelectedDay();

  void buildDates(DateTime date) {
    late int prev, next;
    DateTime tempdate;
    String tempday;
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
      case 'Thursday':
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

    _activeDayTab += prev;

    for (var i = 1; i <= prev; i++) {
      tempdate = date.subtract(Duration(days: i));
      tempday = DateFormat('EEEE').format(tempdate);
      _dates.insert(
        0,
        DayDate(
            date: tempdate.day,
            month: tempdate.month,
            day: tempday,
            year: tempdate.year),
      );
    }

    for (var i = 1; i <= next; i++) {
      var tempdate = date.add(Duration(days: i));
      tempday = DateFormat('EEEE').format(tempdate);
      var length = _dates.length;
      _dates.insert(
        length,
        DayDate(
            date: tempdate.day,
            month: tempdate.month,
            day: tempday,
            year: tempdate.year),
      );
    }
  }

  // void buildTask() {
  //   var date = DateTime.now();
  //   var time = DateFormat.jm().format(date);
  //   _tasks = [];
  //   _tasks.addAll(
  //     [
  //       Task(
  //         id: '',
  //         title: 'Complete Maths Assignment',
  //         notifyMe: true,
  //         isCompleted: true,
  //         from: time,
  //       ),
  //       Task(
  //         id: '',
  //         title: 'Walking',
  //         notifyMe: false,
  //         isCompleted: false,
  //         from: time,
  //       ),
  //     ],
  //   );
  // }

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  // void isTaskCompleted(bool val, int index) {
  //   _tasks[index].isCompleted = val;
  //   notifyListeners();
  // }

  // void deleteTask(int index) {
  //   _tasks.removeAt(index);
  //   notifyListeners();
  // }

  void changeTab(int index) {
    _activeDayTab = index;
    notifyListeners();
  }

  void onModelReady() {
    var date = DateTime.now();
    var day = DateFormat('EEEE').format(date);
    _dates = [];
    _dates.add(
        DayDate(date: date.day, month: date.month, day: day, year: date.year));
    _activeDayTab = 0;
    buildDates(date);
    //buildTask();
  }

  Stream<List<Task>> _tasksForSelectedDay() {
    print(selectedDate);
    print(DateFormat('dd-MM-yyyy').format(selectedDate));
    return databaseService
        .getTasksforDate(DateFormat('dd-MM-yyyy').format(selectedDate));
  }
}
