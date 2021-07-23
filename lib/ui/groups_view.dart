import 'package:flutter/cupertino.dart';
import 'package:task_dot_do/ui/base_view.dart';
import 'package:task_dot_do/viewmodels/groups_viewmodel.dart';

class GroupsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<GroupsViewModel>(
      builder: (context, model, child) => Container(
        child: Center(
          child: Text('Groups Page'),
        ),
      ),
    );
  }
}
