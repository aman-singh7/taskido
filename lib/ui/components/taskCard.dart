import 'package:flutter/material.dart';
import 'package:task_dot_do/models/task_model.dart';
import 'package:task_dot_do/viewmodels/base_viewmodel.dart';

class TaskCard extends StatelessWidget {
  final DateTime date;
  final Task task;
  final BaseViewModel model;

  const TaskCard({
    required this.date,
    required this.task,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        bottom: 8.0,
        left: 10,
        right: 10,
      ),
      child: Card(
        elevation: 4,
        shadowColor: Colors.lightBlue[100],
        child: CheckboxListTile(
          title: Text(
            task.title,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(task.from),
          value: task.isCompleted,
          controlAffinity: ListTileControlAffinity.leading,
          onChanged: (val) =>
              model.upDateTaskCompltedStatus(val, task.id, date),
          secondary: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (task.notifyMe) ...[
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.notifications,
                    //color: Colors.yellow,
                  ),
                ),
              ],
              IconButton(
                onPressed: () => model.deleteTask(task.id, date),
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
