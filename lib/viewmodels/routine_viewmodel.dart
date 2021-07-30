import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:task_dot_do/locator.dart';
import 'package:task_dot_do/models/group_model.dart';
import 'package:task_dot_do/models/routine_model.dart';
import 'package:task_dot_do/services/routine_service.dart';
import 'package:task_dot_do/viewmodels/base_viewmodel.dart';
import 'package:url_launcher/url_launcher.dart';

class RoutineViewModel extends BaseViewModel {
  late bool _isLoading;
  late List<Routine> _routine;
  late String _day;
  late GroupModel _group;
  final RoutineService _routineService = locator<RoutineService>();

  bool get isLoading => _isLoading;
  String get day => _day;
  GroupModel get group => _group;
  List<Routine> get routine => _routine;

  void onOpen(LinkableElement? link) async {
    if (await canLaunch(link!.url)) {
      await launch(link.url);
    } else {
      throw 'Cannot launch $link';
    }
  }

  void sortRoutine() {
    _routine.sort((item1, item2) {
      return item1.compare.compareTo(item2.compare);
    });
  }

  void deleteRoutine(String docId, int index) async {
    var result = await _routineService.deleteRoutine(docId, _group.id, _day);
    if (result) {
      Get.snackbar(
        'Delete',
        'Deleted Successfully',
      );
      _routine.removeAt(index);
      sortRoutine();
    } else {
      Get.snackbar(
        'Delete',
        'Error occured while deleting',
      );
    }
    notifyListeners();
  }

  void addRoutine(Routine newRoutine) {
    _routine.add(newRoutine);
    sortRoutine();
    notifyListeners();
  }

  void getRoutines(String groupId, String day) async {
    var result = await _routineService.getRoutines(groupId, day);
    _routine = result;
    if (_routine.length > 1) {
      sortRoutine();
    }
    _isLoading = false;
    notifyListeners();
  }

  void onModelReady(GroupModel group, String day) {
    _isLoading = true;
    _routine = [];
    _group = group;
    _day = day;
    getRoutines(group.id, day);
  }
}
