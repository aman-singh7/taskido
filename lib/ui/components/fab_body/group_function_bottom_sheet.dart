import 'package:flutter/cupertino.dart';
import 'package:task_dot_do/ui/base_view.dart';
import 'package:task_dot_do/viewmodels/groups_viewmodel.dart';

class GroupFunctionBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    return BaseView<GroupsViewModel>(
      builder: (context, model, child) => Container(
        height: h / 3,
        child: ListView(
          shrinkWrap: true,
          children: [],
        ),
      ),
    );
  }
}
