import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_dot_do/models/group_model.dart';
import 'package:task_dot_do/ui/base_view.dart';
import 'package:task_dot_do/ui/routine_view.dart';
import 'package:task_dot_do/viewmodels/routine_nav_dialog_viewmodel.dart';

class RoutineNavDialog extends StatelessWidget {
  RoutineNavDialog(this.groupModel);
  final GroupModel groupModel;
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return BaseView<RoutineNavDialogViewModel>(
        onModelReady: (model) => model.onModelReady(),
        builder: (context, model, child) {
          return Dialog(
            child: Container(
              width: w / 1.5,
              margin: const EdgeInsets.all(12),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Routine',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.grey[100],
                  ),
                  ListTile(
                    leading: Text('Select Day: '),
                    title: DropdownButton(
                      items: model.days.map((day) {
                        return DropdownMenuItem(
                          value: day,
                          child: Text(day),
                        );
                      }).toList(),
                      icon: Icon(Icons.arrow_drop_down),
                      value: model.day,
                      onChanged: model.onChanged,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                      Get.to(
                        () => RoutineView(),
                        arguments: [model.day, groupModel],
                      );
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
