import 'package:flutter/material.dart';
import 'package:task_dot_do/models/group_model.dart';
import 'package:task_dot_do/viewmodels/base_viewmodel.dart';

class GroupsViewModel extends BaseViewModel {
  late final TextEditingController _searchController;
  late List<GroupModel> _groups;

  TextEditingController get searchController => _searchController;
  List<GroupModel> get groups => _groups;

  void buildGroups() {
    _groups.add(
      GroupModel(
        name: 'p&I group',
        isAdmin: true,
      ),
    );
  }

  void onModelReady() {
    _searchController = TextEditingController();
    _groups = [];
    buildGroups();
  }
}
