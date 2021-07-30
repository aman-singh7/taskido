import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_dot_do/locator.dart';
import 'package:task_dot_do/models/group_model.dart';
import 'package:task_dot_do/services/group_service.dart';
import 'package:task_dot_do/viewmodels/base_viewmodel.dart';

class GroupsViewModel extends BaseViewModel {
  late TextEditingController _searchController;
  late TextEditingController _nameController;
  late List<GroupModel> _groups;
  late bool isLoading;
  final groupService = locator<GroupService>();

  TextEditingController get searchController => _searchController;
  TextEditingController get nameController => _nameController;
  List<GroupModel> get groups => _groups;

  void fetchGroups() async {
    var res = await groupService.joinedGroups();
    _groups.addAll(res);
    isLoading = false;
    notifyListeners();
  }

  void groupOption(String option, String input) async {
    Get.back();
    if (input == '') return;
    switch (option) {
      case 'Create':
        var result = await groupService.createGroup(input);
        if (result != null) {
          Get.snackbar(
            'Create Group',
            'Group Created Successfully!!',
            backgroundColor: Colors.blueAccent,
          );
          _groups.add(result);
        }
        Get.snackbar(
          'Create Group',
          'Error occured while creating group',
          backgroundColor: Colors.blueAccent,
        );
        break;
      case 'Join':
        for (var group in _groups) {
          if (group.id == input) {
            Get.snackbar(
              'Join Group',
              'Already Joined!!',
              backgroundColor: Colors.blueAccent,
            );
          }
        }
        var result = await groupService.joinGroup(input);
        if (result != null) {
          Get.snackbar(
            'Join Group',
            'Joined Successfully',
            backgroundColor: Colors.blueAccent,
          );
          _groups.add(result);
        } else {
          Get.snackbar(
            'Join Group',
            'Error occured while joining the group\nPlease recheck your connectivity and GroupId',
            backgroundColor: Colors.blueAccent,
          );
        }
        break;
    }
    notifyListeners();
    _nameController.clear();
  }

  void onModelReady() {
    _searchController = TextEditingController();
    _nameController = TextEditingController();
    _groups = [];
    isLoading = true;
    fetchGroups();
  }

  void onModelDestroy() {
    _searchController.dispose();
    _nameController.dispose();
  }
}
