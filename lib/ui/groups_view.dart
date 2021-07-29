import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_dot_do/models/group_model.dart';
import 'package:task_dot_do/ui/base_view.dart';
import 'package:task_dot_do/ui/particular_group_view.dart';
import 'package:task_dot_do/viewmodels/groups_viewmodel.dart';

class GroupsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    List<Widget> buildGroupTile(List<GroupModel> groups) {
      var result = <Widget>[];

      for (var group in groups) {
        result.add(
          Padding(
            padding: const EdgeInsets.only(
              left: 18,
              right: 18,
              bottom: 10,
            ),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.grey),
              ),
              child: ListTile(
                leading: Icon(
                  Icons.people_rounded,
                ),
                title: Text(group.name),
                onTap: () =>
                    Get.to(() => ParticularGroupView(), arguments: group),
              ),
            ),
          ),
        );
      }

      return result;
    }

    return BaseView<GroupsViewModel>(
      onModelReady: (model) => model.onModelReady(),
      builder: (context, model, child) => Container(
        child: Container(
          height: h / 1.1,
          width: w,
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage('assets/images/Group5.jpg'),
              alignment: Alignment.bottomCenter,
              fit: BoxFit.contain,
            ),
          ),
          child: model.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView(
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        left: 20,
                      ),
                      child: Text(
                        'Groups',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      height: h / 11,
                      padding: const EdgeInsets.only(
                        left: 25,
                        right: 25,
                        top: 22,
                      ),
                      child: TextField(
                        controller: model.searchController,
                        decoration: InputDecoration(
                          labelText: '\t\t\tSearch',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: h / 18,
                    ),
                    ...buildGroupTile(model.groups)
                  ],
                ),
        ),
      ),
    );
  }
}
