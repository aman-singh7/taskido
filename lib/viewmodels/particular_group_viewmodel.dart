import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:task_dot_do/locator.dart';
import 'package:task_dot_do/models/group_model.dart';
import 'package:task_dot_do/models/participant_model.dart';
import 'package:task_dot_do/services/particular_group_service.dart';
import 'package:task_dot_do/viewmodels/base_viewmodel.dart';
import 'package:url_launcher/url_launcher.dart';

class ParticularGroupViewModel extends BaseViewModel {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late List<Participant> _participants;
  late GroupModel _group;
  final service = locator<ParticularGroupService>();

  TextEditingController get titleController => _titleController;
  TextEditingController get descriptionController => _descriptionController;
  GroupModel get group => _group;
  List<Participant> get participants => _participants;

  void onOpen(LinkableElement? link) async {
    if (await canLaunch(link!.url)) {
      await launch(link.url);
    } else {
      throw 'Cannot launch $link';
    }
  }

  void getParticipant(String groupId) async {
    var res = await service.getParticipants(groupId);
    _participants = res;
    notifyListeners();
  }

  void deleteNotification(String docid, String groupId) async {
    var result = await service.deleteNotification(groupId, docid);
    if (result) {
      Get.snackbar(
        'Delete',
        'Deleted Successfully',
      );
    } else {
      Get.snackbar(
        'Delete',
        'Error while deleting the notification',
      );
    }
  }

  void onModelReady(GroupModel group) {
    _group = group;
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _participants = [];
    getParticipant(_group.id);
  }
}
