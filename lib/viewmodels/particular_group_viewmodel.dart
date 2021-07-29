import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:task_dot_do/locator.dart';
import 'package:task_dot_do/models/participant_model.dart';
import 'package:task_dot_do/services/particular_group_service.dart';
import 'package:task_dot_do/viewmodels/base_viewmodel.dart';
import 'package:url_launcher/url_launcher.dart';

class ParticularGroupViewModel extends BaseViewModel {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late List<Participant> _participants;
  final service = locator<ParticularGroupService>();

  TextEditingController get titleController => _titleController;
  TextEditingController get descriptionController => _descriptionController;
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
        '',
        'Deleted Successfully',
      );
    } else {
      Get.snackbar(
        '',
        'Error while deleting the notification',
      );
    }
  }

  void onModelReady(String groupId) {
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _participants = [];
    getParticipant(groupId);
  }
}
