import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_dot_do/ui/base_view.dart';
import 'package:task_dot_do/ui/components/custom_text_field.dart';
import 'package:task_dot_do/viewmodels/groups_viewmodel.dart';

class GroupFunctionBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    Widget buildDialog(String title, GroupsViewModel model) {
      var label = title == 'Create Group' ? 'Group Name' : 'Group Code';
      return AlertDialog(
        title: Text(title),
        content: CustomTextField(model.nameController, label, null, null),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => model.groupOption(
              title.split(' ').first,
              model.nameController.text.trim(),
            ),
            child: Text(title.split(' ').first),
          ),
        ],
      );
    }

    Widget buildIcon(String title, String iconName, GroupsViewModel model) {
      return GestureDetector(
        onTap: () {
          Get.back();
          showDialog(
            context: context,
            builder: (context) => buildDialog(title, model),
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: h / 8,
              width: w / 8,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black),
                image: DecorationImage(
                  image: AssetImage('assets/images/$iconName'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Text(title),
          ],
        ),
      );
    }

    return BaseView<GroupsViewModel>(
      builder: (context, model, child) => Container(
        height: h / 3,
        child: ListView(
          shrinkWrap: true,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Icon(Icons.more_vert),
                ),
                Text(
                  'Options',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                bottom: 25,
              ),
              child: Divider(
                color: Colors.grey,
                thickness: 1.5,
                endIndent: 20,
                indent: 20,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildIcon('Create Group', 'create_group.png', model),
                SizedBox(
                  width: w / 10,
                ),
                buildIcon('Join Group', 'join_group.png', model),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
