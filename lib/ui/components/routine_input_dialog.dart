import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_dot_do/locator.dart';
import 'package:task_dot_do/services/routine_service.dart';
import 'package:task_dot_do/ui/base_view.dart';
import 'package:task_dot_do/ui/components/custom_text_field.dart';
import 'package:task_dot_do/viewmodels/routine_input_dialog_viewmodel.dart';
import 'package:task_dot_do/viewmodels/routine_viewmodel.dart';

class RoutineInputDialog extends StatelessWidget {
  RoutineInputDialog(this.routineModel);
  final RoutineViewModel routineModel;
  final _key = GlobalKey<FormState>();
  final routineService = locator<RoutineService>();
  @override
  Widget build(BuildContext context) {
    void pickTime(RoutineInputDialogViewModel model, DateTime initialtime,
        String command) async {
      var time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(
          hour: initialtime.hour,
          minute: initialtime.minute,
        ),
      );
      if (time != null) {
        model.setTime(time, command);
      }
    }

    return BaseView<RoutineInputDialogViewModel>(
      onModelReady: (model) => model.onModelReady(),
      onModelDestroy: (model) => model.onModelDestroy(),
      builder: (context, model, child) => Dialog(
        child: Container(
          width: MediaQuery.of(context).size.width / 1.5,
          margin: const EdgeInsets.all(10),
          child: Form(
            key: _key,
            child: ListView(
              shrinkWrap: true,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'Add Routine',
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                    model.nameController,
                    'Name',
                    'Enter the name',
                    Icons.subject,
                    validator: model.validator,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Icon(Icons.schedule),
                    title: Text('From'),
                    subtitle: Text(DateFormat.jm().format(model.from)),
                    onTap: () => pickTime(model, model.from, 'from'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Icon(Icons.schedule),
                    title: Text('To'),
                    subtitle: Text(DateFormat.jm().format(model.to)),
                    onTap: () => pickTime(model, model.to, 'to'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                    model.remarkController,
                    'Remark',
                    'Enter the remark',
                    Icons.label_important,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_key.currentState!.validate()) {
                        Get.back();
                        var result = await routineService.addRoutine(
                          model.nameController.text.trim(),
                          model.from,
                          model.to,
                          model.remarkController.text.trim(),
                          routineModel.group.id,
                          routineModel.day,
                        );
                        if (result != null) {
                          routineModel.addRoutine(result);
                        }
                      }
                    },
                    child: Text('Add'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
