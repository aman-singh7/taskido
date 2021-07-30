import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_dot_do/locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_dot_do/models/participant_model.dart';
import 'package:task_dot_do/services/particular_group_service.dart';
import 'package:task_dot_do/ui/base_view.dart';
import 'package:task_dot_do/ui/components/fab_body/add_task_dialog.dart';
import 'package:task_dot_do/ui/components/routine_nav_dialog.dart';
import 'package:task_dot_do/viewmodels/particular_group_viewmodel.dart';

class ParticularGroupView extends StatefulWidget {
  static const id = 'particular_group_view';

  @override
  _ParticularGroupViewState createState() => _ParticularGroupViewState();
}

class _ParticularGroupViewState extends State<ParticularGroupView> {
  final argument = Get.arguments;

  final particularGroupService = locator<ParticularGroupService>();

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    Widget participantDialog(List<Participant> participants) {
      var res = <Widget>[];
      for (var participant in participants) {
        res.add(
          ListTile(
            title: Text(participant.name),
            subtitle: Text(participant.email),
          ),
        );
      }
      return Dialog(
        child: Container(
          width: w / 1.5,
          margin: const EdgeInsets.all(10),
          child: ListView(
            shrinkWrap: true,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Participants',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Divider(
                thickness: 2,
                color: Colors.grey[100],
              ),
              ...res,
            ],
          ),
        ),
      );
    }

    Widget buildExpansionTile(
      AsyncSnapshot<QuerySnapshot> snapshot,
      int index,
      ParticularGroupViewModel model,
    ) {
      var object = snapshot.data!.docs[index].data() as Map<String, dynamic>;
      var id = snapshot.data!.docs[index].id;

      return Card(
        margin: const EdgeInsets.all(10),
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ExpansionTile(
          leading: Icon(Icons.add_alarm_sharp),
          title: Text(object['title']),
          trailing: argument.isAdmin
              ? IconButton(
                  onPressed: () => model.deleteNotification(id, argument.id),
                  icon: Icon(Icons.cancel_outlined),
                )
              : null,
          children: [
            ListTile(
              leading: Icon(Icons.announcement_rounded),
              title: Linkify(
                onOpen: model.onOpen,
                textScaleFactor: 1.25,
                text: object['description'],
              ),
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text(
                DateFormat.yMMMMd('en_Us')
                    .add_jm()
                    .format((object['time'] as Timestamp).toDate()),
              ),
            ),
          ],
        ),
      );
    }

    return BaseView<ParticularGroupViewModel>(
      onModelReady: (model) => model.onModelReady(argument),
      builder: (context, model, child) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                argument.name,
                overflow: TextOverflow.ellipsis,
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => RoutineNavDialog(model.group),
                      );
                    },
                    icon: Icon(Icons.calendar_today),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Get.dialog(
                      Dialog(
                        child: Container(
                          width: w / 1.5,
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'Group Info',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                              Divider(
                                thickness: 2,
                                color: Colors.grey[100],
                              ),
                              ListTile(
                                leading: Text('Group Name:'),
                                title: Text(model.group.name),
                              ),
                              ListTile(
                                leading: Text('Group Id:'),
                                title: SelectableText(model.group.id),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.info_outline),
                ),
              ],
            ),
            body: Stack(
              children: [
                StreamBuilder(
                  stream:
                      particularGroupService.getNotification(model.group.id),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return buildExpansionTile(snapshot, index, model);
                        },
                      );
                    }
                    return Center(
                      child: Text('Looks like there is no notifications!'),
                    );
                  },
                ),
                Positioned(
                  bottom: h / 40,
                  left: w / 22,
                  child: Container(
                    height: h / 10,
                    width: w / 7,
                    child: MaterialButton(
                      color: Colors.amber,
                      shape: CircleBorder(),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return participantDialog(model.participants);
                          },
                        );
                      },
                      child: Icon(
                        Icons.people,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                if (model.group.isAdmin) ...[
                  Positioned(
                    bottom: h / 40,
                    right: w / 22,
                    child: Container(
                      height: h / 10,
                      width: w / 7,
                      child: MaterialButton(
                        shape: CircleBorder(),
                        color: Colors.red,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                child: AddTaskDialog(
                                  'Add Notification',
                                  groupId: model.group.id,
                                ),
                              );
                            },
                          );
                        },
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ]
              ],
            ),
          ),
        );
      },
    );
  }
}
