import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:task_dot_do/models/routine_model.dart';
import 'package:task_dot_do/ui/base_view.dart';
import 'package:task_dot_do/ui/components/routine_input_dialog.dart';
import 'package:task_dot_do/viewmodels/routine_viewmodel.dart';

class RoutineView extends StatefulWidget {
  static const id = 'routine_view';

  @override
  _RoutineViewState createState() => _RoutineViewState();
}

class _RoutineViewState extends State<RoutineView> {
  var argument = Get.arguments;

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;

    Widget buildExpansionTile(
        Routine routine, RoutineViewModel model, int index) {
      return Card(
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
        child: ExpansionTile(
          leading: Icon(Icons.class_),
          title: Text(routine.name),
          trailing: model.group.isAdmin
              ? IconButton(
                  onPressed: () => model.deleteRoutine(routine.id, index),
                  icon: Icon(
                    Icons.cancel,
                  ))
              : null,
          children: [
            ListTile(
              leading: Icon(Icons.schedule),
              title: Text('${routine.from} - ${routine.to}'),
            ),
            if (routine.remark != '')
              ListTile(
                leading: Icon(Icons.label_important),
                title: Linkify(
                  textScaleFactor: 1.25,
                  onOpen: model.onOpen,
                  text: routine.remark,
                ),
              ),
          ],
        ),
      );
    }

    return BaseView<RoutineViewModel>(
      onModelReady: (model) => model.onModelReady(argument[1], argument[0]),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('${model.day} | ${model.group.name}'),
        ),
        body: Stack(
          children: [
            model.isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: model.routine.length,
                    itemBuilder: (context, index) {
                      return buildExpansionTile(
                          model.routine[index], model, index);
                    },
                  ),
            if (model.group.isAdmin)
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  height: h / 13,
                  width: h / 13,
                  margin: const EdgeInsets.all(14),
                  child: MaterialButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return RoutineInputDialog(model);
                        },
                      );
                    },
                    color: Colors.cyan,
                    shape: CircleBorder(),
                    child: Center(
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
