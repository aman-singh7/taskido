import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_dot_do/app_theme.dart';
import 'package:task_dot_do/locator.dart';
import 'package:task_dot_do/models/task_model.dart';
import 'package:task_dot_do/services/particular_group_service.dart';
import 'package:task_dot_do/ui/base_view.dart';
import 'package:task_dot_do/ui/components/custom_text_field.dart';
import 'package:task_dot_do/viewmodels/add_task_viewmodel.dart';
import 'package:task_dot_do/viewmodels/home_viewmodel.dart';

class AddTaskDialog extends StatelessWidget {
  AddTaskDialog(this.title, {this.groupId});
  final String title;
  final dynamic groupId;
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    final _key = GlobalKey<FormState>();
    final homemodel = locator<HomeViewModel>();
    final groupService = locator<ParticularGroupService>();

    void pickDate(AddTaskViewModel model) async {
      var date = await showDatePicker(
        context: context,
        initialDate: model.dateTime,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(
          const Duration(days: 30),
        ),
      );
      if (date != null) {
        model.dateUpdated(date);
      }
    }

    void pickTime(AddTaskViewModel model) async {
      var time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(
          hour: model.dateTime.hour,
          minute: model.dateTime.minute,
        ),
      );
      if (time != null) {
        model.timeUpdated(time);
      }
    }

    return BaseView<AddTaskViewModel>(
      onModelReady: (model) => model.onModelReady(),
      onModelDestroy: (model) => model.onModelDestroy(),
      builder: (context, model, child) => Container(
        height: MediaQuery.of(context).size.height / 1.5,
        margin: const EdgeInsets.all(15),
        child: ListView(
          shrinkWrap: true,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  title,
                  style: AppTheme.headline3,
                ),
              ),
            ),
            Divider(
              thickness: 2,
              color: Colors.grey,
            ),
            Form(
              key: _key,
              child: Container(
                padding: const EdgeInsets.all(12.0),
                height: h / 9,
                width: w / 4,
                child: CustomTextField(
                  model.titleController,
                  'Title',
                  'Title of Task',
                  Icons.title,
                  validator: model.tfValidator,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              width: w / 4,
              child: CustomTextField(
                model.descriptionController,
                'Description',
                'Description of Task',
                Icons.description,
                maxlines: 2,
                validator: model.tfValidator,
              ),
            ),
            ListTile(
              title: Text('Date'),
              subtitle: Text(
                DateFormat.yMMMMd('en_US').format(model.dateTime),
              ),
              onTap: () => pickDate(model),
              leading: Icon(Icons.date_range),
            ),
            ListTile(
              title: Text('Time'),
              subtitle: Text(
                DateFormat.jm().format(model.dateTime),
              ),
              leading: Icon(Icons.alarm),
              onTap: () => pickTime(model),
            ),
            CheckboxListTile(
              value: model.notifyMe,
              onChanged: (val) => model.onChanged(val!),
              controlAffinity: ListTileControlAffinity.leading,
              title:
                  title == 'Add Task' ? Text('Notify Me') : Text('Important'),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              height: h / 13,
              child: ElevatedButton(
                onPressed: () {
                  if (_key.currentState!.validate()) {
                    Get.back();
                    if (title == 'Add Task') {
                      var task = Task(
                        title: model.titleController.text.trim(),
                        notifyMe: model.notifyMe,
                        isCompleted: false,
                        from: DateFormat.jm().format(model.dateTime),
                        description: model.descriptionController.text.trim(),
                      );
                      homemodel.addTask(task);
                    } else {
                      groupService.createNotification(
                        model.titleController.text.trim(),
                        model.descriptionController.text.trim(),
                        model.dateTime,
                        groupId as String,
                        model.notifyMe,
                      );
                    }
                  }
                },
                child: Text(title),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
