import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_dot_do/app_theme.dart';
import 'package:task_dot_do/ui/base_view.dart';
import 'package:task_dot_do/viewmodels/home_viewmodel.dart';

class HomeView extends StatelessWidget {
  static const String id = 'home_view';
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height / 360;
    var w = MediaQuery.of(context).size.width / 360;

    List<Widget> _buildDateTile(dynamic model) {
      var _date, result = <Widget>[], dates, activeTab;
      dates = model.dates;
      activeTab = model.activeDayTab;
      for (var index = 0; index < dates.length; index++) {
        _date = dates[index];
        result.add(
          ElevatedButton(
            onPressed: () => model.changeTab(index),
            style: ElevatedButton.styleFrom(
              primary: Colors.white60,
              elevation: 2.0,
              textStyle: AppTheme.button.copyWith(fontSize: 14),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(2.0, 15.0, 2.0, 15.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Container(
                      padding: const EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        color: activeTab == index ? Colors.lightBlue : null,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        _date.date.toString(),
                        style: TextStyle(
                          color:
                              activeTab == index ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    _date.day.substring(0, 3),
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        );
      }
      return result;
    }

    List<Widget> _buildTasks(dynamic model) {
      var result = <Widget>[], task, tasks = model.tasks;
      for (var index = 0; index < tasks.length; index++) {
        task = tasks[index];
        result.add(
          Container(
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
                onChanged: (val) => model.isTaskCompleted(val, index),
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
                      onPressed: () => model.deleteTask(index),
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
      return result;
    }

    return BaseView<HomeViewModel>(
      onModelReady: (model) => model.onModelReady(),
      builder: (context, model, child) => Container(
        width: w * 360,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Group5.jpg'),
            alignment: Alignment.bottomCenter,
            fit: BoxFit.fitWidth,
          ),
        ),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 25.0,
                left: 30.0,
              ),
              child: Text(
                'Home',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 20),
              child: Container(
                height: h * 20,
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    labelText: '\t' * 6 + 'Search Tasks',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Colors.grey[100],
                    filled: true,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _buildDateTile(model),
            ),
            SizedBox(
              height: h * 10,
            ),
            ..._buildTasks(model),
          ],
        ),
      ),
    );
  }
}
